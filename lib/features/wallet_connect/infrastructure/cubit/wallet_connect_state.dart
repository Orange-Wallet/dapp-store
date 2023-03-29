part of 'wallet_connect_cubit.dart';

@freezed
class WalletConnectState with _$WalletConnectState {
  const factory WalletConnectState({
    required bool connected,
    required bool failure,
    required List<SessionStruct> sessions,
    required SessionStruct? activeSession,
    required String? activeAddress,
    required String? activeChainId,
    required List<PairingStruct> pairings,
    required List<int> approvedChains,
  }) = _WalletConnectState;

  factory WalletConnectState.initial() => const WalletConnectState(
        connected: false,
        failure: false,
        sessions: [],
        pairings: [],
        activeSession: null,
        activeAddress: null,
        activeChainId: null,
        approvedChains: [],
      );

  factory WalletConnectState.fromJson(Map<String, dynamic> json) =>
      _$WalletConnectStateFromJson(json);
}
