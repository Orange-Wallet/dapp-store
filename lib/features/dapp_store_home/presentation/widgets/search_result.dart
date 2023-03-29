import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/widgets/dapp/big_dapp_card.dart';
import 'package:dappstore/widgets/dapp/dapp_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResult extends StatefulWidget {
  final IDappStoreHandler handler;
  final String query;
  const SearchResult({super.key, required this.handler, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late ScrollController controller;
  @override
  void initState() {
    widget.handler
        .getSearchDappList(queryParams: GetDappQueryDto(search: widget.query));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchResult oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.extentAfter <= 0) {
      debugPrint("Next search page");
      widget.handler.getSearchDappListNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.handler.theme.appBarBackgroundColor,
      height: double.maxFinite,
      child: BlocBuilder<IStoreCubit, StoreState>(
          buildWhen: (previous, current) =>
              (previous.searchResult.hashCode !=
                  current.searchResult.hashCode) &&
              (widget.query == current.searchParams?.search),
          bloc: widget.handler.getStoreCubit(),
          builder: (context, state) {
            List<DappInfo?>? list = state.searchResult?.response;
            if ((list == null)) {
              return Container();
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shrinkWrap: true,
              itemCount: (list.isEmpty) ? 0 : (list.length + 1),
              controller: controller,
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == list.length) {
                  if ((state.isLoadingNextSearchPage ?? false) ||
                      (state.searchResult?.page ==
                          state.searchResult?.pageCount)) {
                    return const SizedBox();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: widget.handler.theme.bodyTextColor,
                      ),
                    );
                  }
                }
                if (list[index] == null) {
                  return const SizedBox();
                }
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: InkWell(
                      onTap: () {
                        widget.handler
                            .setActiveDappId(dappId: list[index]!.dappId ?? "");
                        context.pushRoute(const DappInfoPage());
                      },
                      child: BigDappCard(
                        dapp: list[index]!,
                        handler: widget.handler,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      widget.handler
                          .setActiveDappId(dappId: list[index]!.dappId ?? "");
                      context.pushRoute(const DappInfoPage());
                    },
                    child: DappListTile(
                      dapp: list[index]!,
                      handler: widget.handler,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
