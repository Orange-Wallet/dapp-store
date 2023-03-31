part of 'dapp_info_cubit.dart';

@freezed
class DappInfoState with _$DappInfoState {
  const factory DappInfoState({
    bool? loading,
    DappInfo? dappInfo,
    String? activeDappId,
  }) = _DappInfoState;

  factory DappInfoState.initial() => const _DappInfoState(loading: false);

  factory DappInfoState.fromJson(Map<String, dynamic> json) =>
      _$DappInfoStateFromJson(json);
}
