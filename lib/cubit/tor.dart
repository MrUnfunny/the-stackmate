import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/api/libtor.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/result.dart';
import 'package:flutter_socks_proxy/socks_proxy.dart';
import 'package:utopic_tor_onion_proxy/utopic_tor_onion_proxy.dart';

part 'tor.freezed.dart';

@freezed
class TorState with _$TorState {
  const factory TorState({
    @Default('/tmp') String workingDir,
    @Default(9050) int socks5Port,
    @Default('') String httpProxy,
    @Default('Starting Tor.\nThis may take a while ...')
        String bootstapProgress,
    @Default(false) bool isRunning,
    @Default(false) bool isConnected,
    @Default('') String controlKey,
    @Default('') String errConnection,
  }) = _TorState;

  const TorState._();

  String getSocks5() {
    return '127.0.0.1:' + socks5Port.toString();
  }
}

class TorCubit extends Cubit<TorState> {
  TorCubit(this._logger) : super(const TorState());
  final Logger _logger;

  Future<void> start() async {
    try {
      if (state.isRunning) {
        await stop();
        return;
      }

      emit(
        state.copyWith(
          bootstapProgress: 'Starting Tor.\nThis may take a while ...',
          isRunning: true,
          errConnection: '',
        ),
      );
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final port = await UtopicTorOnionProxy.startTor();
        emit(
          state.copyWith(
            socks5Port: port!,
            errConnection: '',
            isRunning: true,
            isConnected: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isRunning: false,
            errConnection: 'Not Connected To The Internet.',
          ),
        );
      }
    } on PlatformException catch (e) {
      emit(
        state.copyWith(
          isRunning: false,
          errConnection:
              'Could not bind to port. You might have an other tor instance running.',
        ),
      );
      _logger.logException(e, 'Tor.start', '');
      return;
    } catch (e) {
      emit(
        state.copyWith(
          isRunning: false,
          errConnection: e.toString(),
        ),
      );
      _logger.logException(e, 'Tor.start', '');
      return;
    }
  }

  Future<void> checkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final isConnected = await UtopicTorOnionProxy.isTorRunning();
        emit(
          state.copyWith(isConnected: isConnected!),
        );
      } else {
        emit(
          state.copyWith(
            isConnected: false,
            isRunning: false,
            errConnection: 'Not Connected To The Internet.',
          ),
        );
      }
    } catch (e) {
      state.copyWith(
        isConnected: false,
        isRunning: false,
        errConnection: e.toString(),
      );
      _logger.logException(e, 'Tor.status', '');
    }
  }

  Future<void> stop() async {
    try {
      emit(
        state.copyWith(
          bootstapProgress: 'Stopping Tor.\nThis might take a while...',
          errConnection: '',
        ),
      );
      final isStopped = await UtopicTorOnionProxy.stopTor();
      emit(
        state.copyWith(
          isRunning: !isStopped!,
          isConnected: false,
          bootstapProgress: 'Tor stopped.',
          errConnection: 'Tor disconnected.',
        ),
      );
    } catch (e) {
      state.copyWith(
        errConnection: e.toString(),
      );
      _logger.logException(e, 'Tor.stop', '');
    }
  }

  void useExternalSocks5(String port) {
    try {
      port.replaceAll(' ', '');
      if (port == '') return;
      final socsk5 = int.parse(port);
      emit(
        state.copyWith(socks5Port: socsk5),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> testExternalSocks5() async {
    await stop();
    await testConnection();
  }

  Future<void> testConnection() async {
    try {
      SocksProxy.initProxy(
        proxy: 'SOCKS5 localhost:${state.socks5Port.toString()}',
      );
      await HttpClient()
          .getUrl(
        Uri.parse(
          'http://github.com/StackmateNetwork/the-stackmate/blob/master/docs/PRIVACY.md',
        ),
      )
          .then((value) {
        return value.close();
      }).then((value) {
        return value.transform(utf8.decoder);
      }).then((value) {
        return value.fold(
            '', (dynamic previous, element) => previous + element);
      }).then(
        (value) {
          emit(
            state.copyWith(isConnected: true),
          );
          print(value);
        },
      ).catchError((e) {
        state.copyWith(
          isConnected: false,
          errConnection:
              'Could not connect to the internet via Tor. Restart Tor or try another external port.',
        );
        _logger.logException(e, 'Tor.ConnectionStatus', '');
      });
    } catch (e) {
      state.copyWith(
        isConnected: false,
        errConnection:
            'Could not connect to the internet via Tor. Restart Tor or try another external port.',
      );
      _logger.logException(e, 'Tor.ConnectionStatus', '');
    }
  }
}

void daemonStart(dynamic data) {
  final obj = data as Map<String, String?>;

  LibTor().torStart(
    path: obj['path']!,
    socks5Port: obj['socks5Port']!,
    httpProxy: obj['httpProxy']!,
  );
}

Future<R<String>> controlProgress(dynamic data) async {
  final obj = data as Map<String, String?>;

  final resp = LibTor().torStatus(
    controlPort: obj['controlPort']!,
    controlKey: obj['controlKey']!,
  );
  if (resp.hasError)
    return resp;
  else if (resp.result!.startsWith('101'))
    return const R(error: 'Error, requires restart.');
  else
    return resp;
}

Future<R<String>> controlShutdown(dynamic data) async {
  final obj = data as Map<String, String?>;

  final resp = LibTor().torStop(
    controlPort: obj['controlPort']!,
    controlKey: obj['controlKey']!,
  );

  return resp;
}
