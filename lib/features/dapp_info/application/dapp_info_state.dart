part of 'dapp_info_cubit.dart';

@freezed
class DappInfoState with _$DappInfoState {
  const factory DappInfoState({
    bool? loading,
    DappInfo? dappInfo,
    String? activeDappId,
    required List<PostRating> ratings,
    PostRating? selfRating,
  }) = _DappInfoState;

  factory DappInfoState.initial() =>
      const _DappInfoState(loading: false, ratings: []);

  factory DappInfoState.fromJson(Map<String, dynamic> json) =>
      _$DappInfoStateFromJson(json);
}
