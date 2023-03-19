part of 'injected_web3_cubit.dart';

@freezed
class InjectedWeb3State with _$InjectedWeb3State {
  const factory InjectedWeb3State({
    bool? connected,
    bool? failure,
    int? connectedChainId,
    String? connectedChainRpc,
    String? originalUrl,
  }) = _InjectedWeb3State;

  factory InjectedWeb3State.initial() => const _InjectedWeb3State(
      connected: false, failure: false, originalUrl: "");
}
