import 'package:dappstore/core/signer/i_signer.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'i_injected_web3_cubit.dart';

part '../../../../generated/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.freezed.dart';
part 'injected_web3_state.dart';

@LazySingleton(as: IInjectedWeb3Cubit)
class InjectedWeb3Cubit extends Cubit<InjectedWeb3State>
    implements IInjectedWeb3Cubit {
  final IWalletConnectCubit signer;
  InjectedWeb3Cubit({required this.signer})
      : super(InjectedWeb3State.initial());

  @override
  started() {
    // emit(state.copyWith(
    //   failure: false,
    //   connected: false,
    // ));
  }
  @override
  connect(int chainId, String originalUrl) {
    // emit(state.copyWith(
    //     connectedChainId: chainId,
    //     connectedChainRpc: NetworkConfig.fromChainId(chainId)!.endpoint,
    //     connected: true,
    //     originalUrl: originalUrl));
    // return getAccounts();
  }
  @override
  changeChains(int chainId) {
    // emit(state.copyWith(
    //     connectedChainId: chainId,
    //     connectedChainRpc: NetworkConfig.fromChainId(chainId)!.endpoint));
    // return getAccounts();
  }

  @override
  String getAccounts() {
    // return getIt<ConfigurationCubit>().state.credentials!.address!;
    return "";
  }

  @override
  Future<String> sendTransaction(
      JsTransactionObject jsTransactionObject) async {
    // return await BrowserSigningUtils.sendTransaction(
    //     NetworkConfig.fromChainId(state.connectedChainId!)!,
    //     keys.decryptedPrivateKey!,
    //     Transaction(
    //         from: jsTransactionObject.from != null
    //             ? EthereumAddress.fromHex(jsTransactionObject.from!)
    //             : null,
    //         to: jsTransactionObject.to != null
    //             ? EthereumAddress.fromHex(jsTransactionObject.to!)
    //             : null,
    //         data: jsTransactionObject.data != null
    //             ? hexToBytes(jsTransactionObject.from!)
    //             : null,
    //         value: jsTransactionObject.value != null
    //             ? EtherAmount.inWei(BigInt.parse(jsTransactionObject.from!))
    //             : null));
    return "";
  }

  @override
  Future<String> signTransaction(
      JsTransactionObject jsTransactionObject) async {
    // return bytesToHex(await BrowserSigningUtils.signTransaction(
    //     NetworkConfig.fromChainId(state.connectedChainId!)!,
    //     keys.decryptedPrivateKey!,
    //     Transaction(
    //         from: jsTransactionObject.from != null
    //             ? EthereumAddress.fromHex(jsTransactionObject.from!)
    //             : null,
    //         to: jsTransactionObject.to != null
    //             ? EthereumAddress.fromHex(jsTransactionObject.to!)
    //             : null,
    //         data: jsTransactionObject.data != null
    //             ? hexToBytes(jsTransactionObject.from!)
    //             : null,
    //         value: jsTransactionObject.value != null
    //             ? EtherAmount.inWei(BigInt.parse(jsTransactionObject.from!))
    //             : null)));
    return "";
  }

  @override
  Future<String> ecRecover(JsEcRecoverObject ecRecoverObject) async {
    // return BrowserSigningUtils.ecRecover(
    //     ecRecoverObject.signature!, ecRecoverObject.message!);
    return "";
  }

  @override
  String signPersonalMessage(String data) {
    // return BrowserSigningUtils.signPersonalMessage(
    //   privateKey: keys.decryptedPrivateKey!,
    //   message: data,
    // );
    return "";
  }

  @override
  String signMessage(String data) {
    //return BrowserSigningUtils.signMessage(keys.decryptedPrivateKey!, data);
    return "";
  }

  @override
  String signTypedData(JsEthSignTypedData data) {
    // return BrowserSigningUtils.signTypedData(
    //     privateKey: keys.decryptedPrivateKey!,
    //     jsonData: jsonEncode(data.toJson()),
    //     version: TypedDataVersion.V4);
    return "";
  }
}
