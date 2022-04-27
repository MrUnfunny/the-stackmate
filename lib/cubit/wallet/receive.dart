import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/api/stackmate-core.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/node.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/interface/clipboard.dart';
import 'package:sats/pkg/interface/share.dart';
import 'package:sats/pkg/interface/storage.dart';
import 'package:sats/pkg/interface/vibrate.dart';
import 'package:sats/api/interface/stackmate-core.dart';

import '../../model/wallet.dart';
import '../../pkg/storage.dart';

part 'receive.freezed.dart';

@freezed
class ReceiveState with _$ReceiveState {
  const factory ReceiveState({
    @Default(true) bool loadingAddress,
    @Default('') String errLoadingAddress,
    String? address,
  }) = _ReceiveState;
}

class ReceiveCubit extends Cubit<ReceiveState> {
  ReceiveCubit(
    this._walletCubit,
    this._logger,
    this._clipBoard,
    this._share,
    this._vibrate,
    this._storage,
    this._core,
  ) : super(const ReceiveState()) {
    _init();
  }

  final WalletsCubit _walletCubit;
  final Logger _logger;
  final IShare _share;
  final IClipBoard _clipBoard;
  final IVibrate _vibrate;
  final IStorage _storage;
  final IStackMateCore _core;

  void _init() {
    getAddress();
  }

  void getAddress() async {
    try {
      // await Future.delayed(const Duration(milliseconds: 500));
      final wallet = _walletCubit.state.selectedWallet!;
      _vibrate.vibe();

      // await Future.delayed(const Duration(seconds: 1));

      // final w = _walletCubit.state.selectedWallet!.descriptor.split('#')[0];
      final nextIndex = wallet.lastAddressIndex! + 1;

      final latestAddress = _core.getAddress(
        descriptor: wallet.descriptor,
        index: nextIndex.toString(),
      );

      // _logger.logAPI(
      //   'get address',
      //   'desc: $w\nnetwork: ' +
      //       _blockchain.state.blockchain.name +
      //       '\n\nresp:\n$address',
      //   000,
      // );

      // Update wallet state here
      emit(
        state.copyWith(
          loadingAddress: false,
          address: latestAddress,
        ),
      );

      final updated = wallet.copyWith(
        lastAddressIndex: nextIndex,
      );

      await _storage.saveItemAt<Wallet>(
        StoreKeys.Wallet.name,
        updated.id!,
        updated,
      );

      _walletCubit.walletSelected(updated);
      return;
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingAddress: false,
          errLoadingAddress: e.toString(),
        ),
      );
      _logger.logException(e, 'ReceiveCubit.getAddress', s);
    }
  }

  void copyAddress() {
    try {
      _clipBoard.copyToClipBoard(state.address!);
      _vibrate.vibe();
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.copyAddress', s);
    }
  }

  void shareAddress() {
    try {
      final address = state.address!;
      final text = 'This is my bitcoin address:\n$address';
      _share.share(text: text, subjectForEmail: 'Bitcoin Address');
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.shareAddress', s);
    }
  }
}

String getAdrr(dynamic msg) {
  final data = msg as Map<String, String?>;
  final resp = BitcoinFFI().getAddress(
    descriptor: data['descriptor']!,
    index: data['index']!,
  );
  return resp;
}
