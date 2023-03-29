import 'dart:developer';

import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:dappstore/features/wallet_connect/utils/eip155.dart';
import 'package:dappstore/features/wallet_connect/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';
import 'package:wallet_connect_dart_v2/wc_utils/misc/logger/logger.dart';

part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.freezed.dart';
part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.g.dart';
part 'wallet_connect_state.dart';

@LazySingleton(as: IWalletConnectCubit)
class WalletConnectCubit extends Cubit<WalletConnectState>
    implements IWalletConnectCubit {
  @override
  SignClient? signClient;
  IErrorLogger errorLogger;
  WalletConnectCubit({required this.errorLogger})
      : super(WalletConnectState.initial());

  @override
  started() async {
    await initialize();
    getSessionAndPairings();
  }

  @override
  initialize() async {
    try {
      signClient = await SignClient.init(
        projectId: "36f352c5daeb6ed6ae15657366a9df3d",
        relayUrl: "wss://relay.walletconnect.com",
        metadata: const AppMetadata(
          name: 'DappStore_test',
          description: 'Dapp Store by HTC',
          url: 'https://htc.com/',
          icons: [
            'https://1000logos.net/wp-content/uploads/2021/05/HTC-logo.png'
          ],
        ),
        database: ':memory:',
        logger: Logger(level: Level.error),
      );
      log(signClient?.name ?? "error");
    } catch (e, trace) {
      log("${e.toString()}: $trace");
    }
  }

  @override
  getSessionAndPairings() {
    final sessions = signClient!.session.getAll();
    final pairings = signClient!.core.pairing.getPairings();
    emit(state.copyWith(sessions: sessions, pairings: pairings));
  }

  @override
  String? getChain() {
    return state.activeChainId;
  }

  @override
  List<int>? get approvedChains => state.approvedChains;

  @override
  String? getActiveAdddress() {
    return state.activeAddress;
  }

  @override
  Future<bool> getConnectRequest(List<String> chainIds) async {
    EngineConnection? res =
        await signClient?.connect(Eip155Data.getSessionConnectParams(chainIds));
    res?.approval?.then((value) {
      emit(state.copyWith(
        activeSession: value,
        failure: false,
        sessions: signClient!.session.getAll(),
        activeChainId: WCHelper.getChainIdFromAccountStr(
            value.namespaces[ChainType.eip155.name]!.accounts.first),
        activeAddress: WCHelper.getAddressFromAccountStr(
            value.namespaces[ChainType.eip155.name]!.accounts.first),
        connected: true,
        approvedChains: value.namespaces[ChainType.eip155.name]!.accounts
            .map((e) =>
                int.parse(WCHelper.getChainIdFromAccountStr(e).split(":")[1]))
            .toList(),
      ));
      getSessionAndPairings();
      // await getEthSign("Testing");
      log("connected");
      return true;
    }).catchError((e) {
      debugPrint("Connection error $e");
      log("failed");
      return false;
    });
    return await launchUrlString(res!.uri!);
  }

  @override
  Future<String> getPersonalSign(
    String data,
  ) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.PERSONAL_SIGN,
        chainId: state.activeChainId!,
        address: state.activeAddress!,
        data: data,
      );
      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  @override
  Future<String> getEthSign(String data) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SIGN,
        chainId: state.activeChainId!,
        address: state.activeAddress!,
        data: data,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  @override
  Future<String> getEthSignTypedData(String data) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SIGN_TYPED_DATA,
        chainId: state.activeChainId!,
        address: state.activeAddress!,
        data: data,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  @override
  getEthSignTransaction(EthereumTransaction transaction, int chainId) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SIGN_TRANSACTION,
        chainId: chainId.toString(),
        address: state.activeAddress!,
        transaction: transaction,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  @override
  getEthSendTransaction(EthereumTransaction transaction, int chainId) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SEND_TRANSACTION,
        chainId: "eip155:${chainId.toString()}",
        address: state.activeAddress!,
        transaction: transaction,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  @override
  Future<void> disconnect(String topic) async {
    await signClient!.disconnect(
      topic: topic,
      reason: getSdkError(SdkErrorKey.USER_DISCONNECTED),
    );
    getSessionAndPairings();
  }

  @override
  disconnectAll() async {
    log("message");
    for (var element in state.sessions) {
      try {
        await signClient!.disconnect(
          topic: element.topic,
          reason: getSdkError(SdkErrorKey.USER_DISCONNECTED),
        );
      } catch (e, stackTrace) {
        log(" ${e.toString()}: $stackTrace");
      }
    }
    getSessionAndPairings();
  }

// returns topic->AccountList
  @override
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts() {
    Map<String, List<ConnectedAccount>> accountList = {};
    for (var element in state.sessions) {
      accountList[element.topic] =
          WCHelper.getConnectedAccountForSession(element);
    }
    return accountList;
  }
}
