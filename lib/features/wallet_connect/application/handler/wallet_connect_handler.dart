import 'package:dappstore/features/wallet_connect/application/handler/i_wallet_connect_handler.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';

class WalletConnectHandler implements IWalletConnectHandler {
  @override
  // TODO: implement approvedChains
  List<int>? get approvedChains => throw UnimplementedError();

  @override
  // TODO: implement getActiveAdddress
  String? get getActiveAdddress => throw UnimplementedError();

  @override
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts() {
    // TODO: implement getAllConnectedAccounts
    throw UnimplementedError();
  }

  @override
  // TODO: implement getChain
  String? get getChain => throw UnimplementedError();

  @override
  Future<bool> getFirstConnectRequest() {
    // TODO: implement getFirstConnectRequest
    throw UnimplementedError();
  }

  @override
  initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  started() {
    // TODO: implement started
    throw UnimplementedError();
  }

  @override
  // TODO: implement walletConnectCubit
  IWalletConnectCubit get walletConnectCubit => throw UnimplementedError();

  @override
  // TODO: implement walletConnectstore
  IWalletConnectStore get walletConnectstore => throw UnimplementedError();
}
