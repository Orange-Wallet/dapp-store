import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'i_injected_web3_cubit.dart';

part '../../../../generated/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.freezed.dart';
part 'injected_web3_state.dart';

typedef ShowError = Function(SigningFailures error);

enum SigningFailures { SENDING_FAILED, SIGNING_FAILED, METHOD_NOT_SUPPORTED }

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
    emit(
      state.copyWith(
        connectedChainId: chainId,
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
    emit(
      state.copyWith(
        connectedChainId: chainId,
      ),
    );
    return account;
  }

  @override
  Future<String> sendTransaction(
      JsTransactionObject jsTransactionObject) async {
    try {
      final txHash = await signer.getEthSendTransaction(EthereumTransaction(
        from: jsTransactionObject.from!,
        to: jsTransactionObject.to!,
        value: jsTransactionObject.value ?? "0",
        data: jsTransactionObject.data,
      ));
      return txHash;
    } catch (e) {
      errorLogger.logError(e);
      errorCallBack!.call(SigningFailures.SENDING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signTransaction(
      JsTransactionObject jsTransactionObject) async {
    try {
      final signedTx = await signer.getEthSignTransaction(EthereumTransaction(
        from: jsTransactionObject.from!,
        to: jsTransactionObject.to!,
        value: jsTransactionObject.value ?? "0",
        data: jsTransactionObject.data,
      ));
      return signedTx;
    } catch (e) {
      errorLogger.logError(e);
      errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> ecRecover(JsEcRecoverObject ecRecoverObject) async {
    errorCallBack!.call(SigningFailures.METHOD_NOT_SUPPORTED);
    return "";
  }

  @override
  Future<String> signPersonalMessage(String data) async {
    try {
      final signedMessage = await signer.getPersonalSign(data);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signMessage(String data) async {
    try {
      final signedMessage = await signer.getEthSign(data);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }

  @override
  Future<String> signTypedData(JsEthSignTypedData data) async {
    try {
      final signedMessage = await signer.getEthSignTypedData(data.data!);
      return signedMessage;
    } catch (e) {
      errorLogger.logError(e);
      errorCallBack!.call(SigningFailures.SIGNING_FAILED);
      return "";
    }
  }
}
