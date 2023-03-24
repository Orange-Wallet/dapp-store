import 'dart:developer';

import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.freezed.dart';
part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.g.dart';
part 'store_state.dart';

@LazySingleton(as: IStoreCubit)
class StoreCubit extends Cubit<StoreState> implements IStoreCubit {
  @override
  IDappListRepo dappListRepo;
  StoreCubit({required this.dappListRepo}) : super(StoreState.initial());

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  started() async {
    await getDappList();
    await getCuratedCategoryList();
    await getCuratedList();
    await getFeaturedDappsList();
    for (var i = 0; i < 3; i++) {
      if (state.curatedCategoryList?[i]?.category != null) {
        getFeaturedDappsByCategory(
            category: state.curatedCategoryList![i]!.category!);
      }
    }
  }

  @override
  getDappList() async {
    DappList dappList =
        await dappListRepo.getDappList(queryParams: GetDappQueryDto(limit: 20));
    emit(
        state.copyWith(dappList: dappList, dappListCurrentPage: dappList.page));
  }

  @override
  getDappListNextPage() async {
    int nextPage = (state.dappListCurrentPage ?? 0) + 1;
    if (nextPage <= (state.dappList?.pageCount ?? 0)) {
      DappList dappList = await dappListRepo.getDappList(
          queryParams: GetDappQueryDto(page: nextPage));
      DappList? currentList = state.dappList;

      DappList updatedList = DappList(
          page: dappList.page,
          limit: dappList.limit,
          pageCount: dappList.pageCount,
          response: [...?currentList?.response, ...?dappList.response]);
      emit(state.copyWith(
        dappList: updatedList,
        dappListCurrentPage: updatedList.page,
      ));
      log(state.toString());
    }
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    DappInfo? dappInfo =
        await dappListRepo.getDappInfo(queryParams: queryParams);
    log(dappInfo.toString());
    return dappInfo;
  }

  @override
  setActiveDappId({required String dappId}) {
    emit(state.copyWith(activeDappId: dappId));
  }

  @override
  DappInfo? get getActiveDappInfo => state.dappList?.response
      ?.firstWhere((element) => element?.dappId == state.activeDappId);

  @override
  getCuratedList() async {
    List<CuratedList> curatedList = await dappListRepo.getCuratedList();
    emit(state.copyWith(curatedList: curatedList));
    log(state.toString());
  }

  @override
  getSearchDappList({required GetDappQueryDto queryParams}) async {
    DappList dappList =
        await dappListRepo.getDappList(queryParams: queryParams);
    emit(state.copyWith(
        searchResult: dappList,
        searchPage: dappList.page,
        searchParams: queryParams));
    log(state.toString());
  }

  @override
  getSearchDappListNextPage() async {
    GetDappQueryDto queryParams = state.searchParams!;
    int nextPage = (state.searchPage ?? 0) + 1;
    if (nextPage <= (state.searchResult?.pageCount ?? 0)) {
      DappList searchList = await dappListRepo.getDappList(
          queryParams: queryParams.copyWith(page: nextPage));
      DappList? currentList = state.searchResult;

      DappList updatedList = DappList(
          page: searchList.page,
          limit: searchList.limit,
          pageCount: searchList.pageCount,
          response: [...?currentList?.response, ...?searchList.response]);
      emit(state.copyWith(
          searchResult: updatedList,
          searchPage: updatedList.page,
          searchParams: queryParams.copyWith(page: nextPage)));
      log(state.toString());
    }
  }

  @override
  getCuratedCategoryList() async {
    List<CuratedCategoryList> curatedCategoryList =
        await dappListRepo.getCuratedCategoryList();
    emit(state.copyWith(curatedCategoryList: curatedCategoryList));
  }

  @override
  getFeaturedDappsByCategory({required String category}) async {
    DappList dappList =
        await dappListRepo.getFeaturedDappsByCategory(category: category);
    Map<String, DappList?> map = Map.of(state.featuredDappsByCategory ?? {});
    map[category] = dappList;

    emit(state.copyWith(featuredDappsByCategory: map));
  }

  @override
  getFeaturedDappsList() async {
    DappList dappList = await dappListRepo.getFeaturedDappsList();
    emit(state.copyWith(featuredDappList: dappList));
  }
}
