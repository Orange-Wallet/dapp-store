import 'package:dappstore/core/signer/i_signer.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';

abstract class IWalletConnectCubit extends Cubit<WalletConnectState>
    implements ISigner {
  SignClient? signClient;
  IWalletConnectCubit() : super(WalletConnectState.initial());

  started();

  initialize();

  getSessionAndPairings();

  getConnectRequest(List<String> chainIds);

  @override
  getPersonalSign(
    String data,
  );

  @override
  getEthSign(String data);

  @override
  getEthSignTypedData(String data);

  @override
  getEthSignTransaction(EthereumTransaction transaction);

  @override
  getEthSendTransaction(EthereumTransaction transaction);

  Future<void> disconnect(String topic);

  disconnectAll();

// returns topic->AccountList
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts();
}