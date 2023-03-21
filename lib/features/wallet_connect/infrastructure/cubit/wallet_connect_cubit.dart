import 'dart:developer';

import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:dappstore/features/wallet_connect/utils/eip155.dart';
import 'package:dappstore/features/wallet_connect/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';
import 'package:wallet_connect_dart_v2/wc_utils/misc/logger/logger.dart';

part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.freezed.dart';
part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.g.dart';
part 'wallet_connect_state.dart';

@lazySingleton
class WalletConnectCubit extends Cubit<WalletConnectState> {
  SignClient? signClient;
  WalletConnectCubit() : super(WalletConnectState.initial());

  started() async {
    await initialize();
    // getSessionAndPairings();
  }

  initialize() async {
    signClient = await SignClient.init(
      projectId: "36f352c5daeb6ed6ae15657366a9df3d",
      relayUrl: "wss://relay.walletconnect.com",
      metadata: const AppMetadata(
        name: 'DappStore_test',
        description: 'Dapp Store by HTC',
        url: 'https://orangewallet.app/',
        icons: ['https://avatars.githubusercontent.com/u/82613752'],
      ),
      database: 'wallet_connect_v2.db',
      logger: Logger(level: Level.error),
    );

    // signClient!.on(SignClientEvent.SESSION_EVENT.value, (data) async {
    //   final eventData = data as SignClientEventParams<RequestSessionEvent>;
    //   log('SESSION_EVENT: $eventData');
    // });

    // signClient!.on(SignClientEvent.SESSION_PING.value, (data) async {
    //   final eventData = data as SignClientEventParams<void>;
    //   log('SESSION_PING: $eventData');
    // });

    // signClient!.on(SignClientEvent.SESSION_DELETE.value, (data) async {
    //   final eventData = data as SignClientEventParams<void>;
    //   log('SESSION_DELETE: $eventData');
    // });
  }

  getSessionAndPairings() {
    final sessions = signClient!.session.getAll();
    final pairings = signClient!.core.pairing.getPairings();
    emit(state.copyWith(sessions: sessions, pairings: pairings));
  }

  getConnectRequest(List<String> chainIds) async {
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
      ));
      getSessionAndPairings();
      log("connected");
    }).catchError((_) {
      log("failed");
    });
    launchUrlString(res!.uri!);
  }

  getPersonalSign(
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

  getEthSign(String data) async {
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

  getEthSignTypedData(String data) async {
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

  getEthSignTransaction(EthereumTransaction transaction) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SIGN_TRANSACTION,
        chainId: state.activeChainId!,
        address: state.activeAddress!,
        transaction: transaction,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  getEthSendTransaction(EthereumTransaction transaction) async {
    if (state.activeSession != null) {
      SessionRequestParams params = Eip155Data.getRequestParams(
        topic: state.activeSession!.topic,
        method: Eip155Methods.ETH_SEND_TRANSACTION,
        chainId: state.activeChainId!,
        address: state.activeAddress!,
        transaction: transaction,
      );

      var res = await signClient?.request(params);
      return res;
    } else {
      throw Exception("No active Session");
    }
  }

  Future<void> disconnect(String topic) async {
    await signClient!.disconnect(
      topic: topic,
      reason: getSdkError(SdkErrorKey.USER_DISCONNECTED),
    );
    getSessionAndPairings();
  }

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
  }

  // connectNewSession(
  //   String qrCode, {
  //   bool fromIosWeb = false,
  // }) async {
  //   if (_isValidPairUri(qrCode)) {
  //     await signClient!.pair(qrCode);
  //   }
  // }

  // bool _isValidPairUri(String qrCode) {
  //   if (Uri.tryParse(qrCode) != null) {
  //     final uri = Uri.parse(qrCode);
  //     final path = uri.path;
  //     final requiredValues = path.split("@");
  //     if (requiredValues[1] == '2') {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
}
