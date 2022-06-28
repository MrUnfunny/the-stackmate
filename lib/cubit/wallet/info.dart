import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:libstackmate/outputs.dart';
import 'package:sats/api/libbitcoin.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/node.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/interface/launcher.dart';
import 'package:sats/pkg/interface/share.dart';
import 'package:sats/pkg/interface/storage.dart';
import 'package:sats/pkg/interface/vibrate.dart';
import 'package:sats/pkg/storage.dart';

part 'info.freezed.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    @Default(false) bool loadingTransactions,
    @Default('') String errLoadingTransactions,
    @Default(true) bool loadingBalance,
    @Default('') String errLoadingBalance,
    @Default(0) int balance,
    @Default([]) List<Transaction> transactions,
    @Default('') String errDeleting,
    @Default(false) bool deleted,
    @Default(false) bool showInfo,
    @Default(0) int currentHeight,
  }) = _InfoState;
  const InfoState._();

  bool zeroBalance() => balance == 0;
  bool zeroBalanceAmt() => balance == 0;
}

class InfoCubit extends Cubit<InfoState> {
  InfoCubit(
    this._walletsCubit,
    this._storage,
    this._logger,
    this._launcher,
    this._share,
    this._vibrate,
    this._nodeAddressCubit,
    this._torCubit,
    this._blockchainCubit,
  ) : super(const InfoState()) {
    _init();
  }

  final WalletsCubit _walletsCubit;
  final IStorage _storage;
  final Logger _logger;
  final IShare _share;
  final ILauncher _launcher;
  final IVibrate _vibrate;
  final ChainSelectCubit _blockchainCubit;
  final NodeAddressCubit _nodeAddressCubit;
  final TorCubit _torCubit;

  static const defaultTestnetExplorer =
      'https://mempool.bullbitcoin.com/testnet/tx/';
  static const defaultMainnetExplorer = 'https://mempool.bullbitcoin.com/tx/';

  static const emailShareSubject = 'Transaction Details';
  static const walletHasFunds = 'Wallet has funds';

  void _init() async {
    getHistory();
  }

  void getHistory() async {
    try {
      final node = _nodeAddressCubit.state.getAddress();
      final socks5 = _torCubit.state.getSocks5();
      final wallet = _walletsCubit.state.selectedWallet!;
      emit(
        state.copyWith(
          loadingBalance: true,
          errLoadingTransactions: '',
          balance: wallet.balance,
          transactions: wallet.transactions,
        ),
      );
      final currentHeight = await compute(computeCurrentHeight, {
        'network': _blockchainCubit.state.blockchain.name,
        'nodeAddress': node,
        'socks5': socks5,
      });

      emit(
        state.copyWith(
          loadingBalance: true,
          loadingTransactions: true,
          balance: wallet.balance,
          transactions: wallet.transactions,
          currentHeight: currentHeight,
        ),
      );

      // THIS PART NEEDS TO BE REVIEWS
      // compute is used and errors are not properly handled
      final balance = await compute(computeBalance, {
        'descriptor': _walletsCubit.state.selectedWallet!.descriptor,
        'nodeAddress': node,
        'socks5': socks5,
      });

      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingTransactions: true,
          loadingBalance: false,
          errLoadingTransactions: '',
          balance: balance,
          currentHeight: currentHeight,
        ),
      );
      _walletsCubit.addBalanceToSelectedWallet(balance);

      final transactions = await compute(computeHistory, {
        'descriptor': _walletsCubit.state.selectedWallet!.descriptor,
        'nodeAddress': node,
        'socks5': socks5,
      });
      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingTransactions: false,
          loadingBalance: false,
          transactions: transactions,
          errLoadingTransactions: '',
          balance: balance,
          currentHeight: currentHeight,
        ),
      );

      _walletsCubit.addTransactionsToSelectedWallet(transactions);
      return;
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingBalance: false,
          loadingTransactions: false,
          errLoadingTransactions: e.toString(),
        ),
      );
      _logger.logException(e, 'HistoryCubit.getHistory', s);
    }
  }

  void openLink(Transaction transaction) {
    try {
      String url = '';
      if (_blockchainCubit.state.blockchain == Blockchain.test)
        url = defaultTestnetExplorer;
      else
        url = defaultMainnetExplorer;

      url += transaction.txid;

      _launcher.launchApp(url);
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.openLink', s);
    }
  }

  void shareTransaction(Transaction transaction) {
    try {
      String text = '';
      text += '\nTxId: ' + transaction.txid;
      text += 'Amount: ' + transaction.amountToBtc() + ' BTC';
      text += '\nFee: ' + transaction.feesToBtc() + ' BTC';

      _share.share(text: text, subjectForEmail: emailShareSubject);
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.shareTransaction', s);
    }
  }

  void deleteClicked() {
    emit(state.copyWith(errDeleting: ''));

    _storage.deleteItemAt<Wallet>(
      StoreKeys.Wallet.name,
      _walletsCubit.state.selectedWallet!.id!,
    );
    _walletsCubit.refresh();
    emit(state.copyWith(deleted: true));
  }

  void toggleShowInfo() {
    emit(state.copyWith(showInfo: !state.showInfo));
  }
}

List<Transaction> computeHistory(dynamic obj) {
  final data = obj as Map<String, String?>;
  final resp = LibBitcoin().getHistory(
    descriptor: data['descriptor']!,
    nodeAddress: data['nodeAddress']!,
    socks5: obj['socks5']!,
  );

  if (resp.hasError) {
    throw SMError.fromJson(resp.error!);
  }
  return resp.result!;
}

int computeBalance(dynamic obj) {
  final data = obj as Map<String, String?>;
  final resp = LibBitcoin().syncBalance(
    descriptor: data['descriptor']!,
    nodeAddress: data['nodeAddress']!,
    socks5: obj['socks5']!,
  );
  if (resp.hasError) {
    throw SMError.fromJson(resp.error!);
  }
  return resp.result!;
}

int computeCurrentHeight(dynamic obj) {
  final data = obj as Map<String, String?>;
  final resp = LibBitcoin().getHeight(
    network: data['network']!,
    nodeAddress: data['nodeAddress']!,
    socks5: obj['socks5']!,
  );
  if (resp.hasError) {
    throw SMError.fromJson(resp.error!);
  }
  return resp.result!;
}
