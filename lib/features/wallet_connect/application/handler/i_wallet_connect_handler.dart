import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';

abstract class IWalletConnectHandler {
  IWalletConnectCubit get walletConnectCubit;
  IWalletConnectStore get walletConnectstore;

  started();

  initialize();

  Future<bool> getFirstConnectRequest();

  String? get getActiveAdddress;

  String? get getChain;

  List<int>? get approvedChains;

// returns topic->AccountList
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts();
}
