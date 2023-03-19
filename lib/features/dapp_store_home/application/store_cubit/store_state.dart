part of 'store_cubit.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState({
    DappList? dappList,
    DappList? searchresult,
    CuratedList? curatedList,
    int? currentPage,
    int? searchPage,
  }) = _StoreState;

  factory StoreState.initial() => const _StoreState();

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);
}
