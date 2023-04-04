import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_mapping.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'i_injected_web3_cubit.dart';

part '../../../../generated/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.freezed.dart';
part 'injected_web3_state.dart';

typedef ShowError = Function(SigningFailures error);

enum SigningFailures {
  // ignore: constant_identifier_names
  SENDING_FAILED,
  // ignore: constant_identifier_names
  SIGNING_FAILED,
  // ignore: constant_identifier_names
  METHOD_NOT_SUPPORTED,
  // ignore: constant_identifier_names
  CHAIN_NOT_SUPPORTED,
}

@LazySingleton(as: IInjectedWeb3Cubit)
class InjectedWeb3Cubit extends Cubit<InjectedWeb3State>
    implements IInjectedWeb3Cubit {
  ShowError? errorCallBack;
  final IErrorLogger errorLogger;
  final IWalletConnectCubit signer;
  InjectedWeb3Cubit({required this.signer, required this.errorLogger})
      : super(InjectedWeb3State.initial());

  @override
  started(ShowError callback) {
    emit(state.copyWith(
      failure: false,
      connected: false,
    ));
    errorCallBack = callback;
  }

  @override
  connect(int chainId, String originalUrl) async {
    final supported = signer.approvedChains!.first;
    final rpc = RpcMapping.networks[supported];
    emit(
      state.copyWith(
        //connectedChainId: int.parse(signer.getChain()!),
        //connectedChainId: 137,
        //connectedChainRpc: "https://rpc.ankr.com/polygon",
        connectedChainId: supported,
        connectedChainRpc: rpc,
        connected: true,
        originalUrl: originalUrl,
      ),
    );
    return account;
  }

  @override
  String? get account => signer.getActiveAdddress();

  @override
  String? get chainId => signer.getChain();

  @override
  changeChains(int chainId) {
    final approvedChains = signer.approvedChains;
    final rpcEndpoint = RpcMapping.networks[chainId];
    if (approvedChains!.contains(chainId) && rpcEndpoint != null) {
      debugPrint("chain id $chainId");
      emit(
        state.copyWith(
          connectedChainId: chainId,
          connectedChainRpc: rpcEndpoint,
        ),
      );
      return rpcEndpoint;
    } else {
      //errorCallBack!.call(SigningFailures.SENDING_FAILED);

      return "";
    }
  }

  @override
  Future<String> sendTransaction(
    JsTransactionObject jsTransactionObject,
  ) async {
    try {
      debugPrint("transaction callback ${jsTransactionObject.toString()}");
      final txHash = await signer.getEthSendTransaction(
          EthereumTransaction(
            from: jsTransactionObject.from!,
            to: jsTransactionObject.to!,
            value: jsTransactionObject.value ?? "0",
            data: jsTransactionObject.data ?? "",
          ),
          state.connectedChainId!);
      return txHash;
    } catch (e) {
      errorLogger.logError(e);
      // errorCallBack!.call(SigningFailures.SENDING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signTransaction(
    JsTransactionObject jsTransactionObject,
  ) async {
    try {
      final signedTx = await signer.getEthSignTransaction(
          EthereumTransaction(
            from: jsTransactionObject.from!,
            to: jsTransactionObject.to!,
            value: jsTransactionObject.value ?? "0",
            data: jsTransactionObject.data ?? "",
          ),
          state.connectedChainId!);
      return signedTx;
    } catch (e) {
      errorLogger.logError(e);
      //errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> ecRecover(JsEcRecoverObject ecRecoverObject) async {
    //errorCallBack!.call(SigningFailures.METHOD_NOT_SUPPORTED);
    return "";
  }

  @override
  Future<String> signPersonalMessage(
    String data,
  ) async {
    try {
      final signedMessage = await signer.getPersonalSign(data);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      //  errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signMessage(
    String data,
  ) async {
    try {
      final signedMessage = await signer.getEthSign(data);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      // errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signTypedData(
    JsEthSignTypedData data,
  ) async {
    try {
      final signedMessage = await signer.getEthSignTypedData(data.data!);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      // errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }
}
