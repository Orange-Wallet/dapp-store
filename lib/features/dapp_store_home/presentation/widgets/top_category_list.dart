import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/category_screen.dart';
import 'package:dappstore/widgets/chip.dart';
import 'package:dappstore/widgets/dapp/dapp_list_horizantal_tile.dart';
import 'package:dappstore/widgets/dapp/dapp_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCategoriesList extends StatefulWidget {
  final bool isInExploreCategory;
  const TopCategoriesList({super.key, this.isInExploreCategory = false});

  @override
  State<TopCategoriesList> createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<TopCategoriesList> {
  late final IDappStoreHandler handler;

  @override
  void initState() {
    handler = DappStoreHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IStoreCubit, StoreState>(
        buildWhen: (previous, current) =>
            previous.featuredDappsByCategory.hashCode !=
            current.featuredDappsByCategory.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          // TODO currently using dapplist instead of curated list
          Map<String, DappList?>? list = state.featuredDappsByCategory;
          if (list == null || list.isEmpty) {
            return Container();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shrinkWrap: true,
            itemCount: list.entries.length,
            cacheExtent: 200,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              return topCategoryListWidget(
                  category: list.entries.elementAt(index).key,
                  list: list.entries.elementAt(index).value,
                  axis: widget.isInExploreCategory
                      ? (index.isEven ? Axis.horizontal : Axis.vertical)
                      : Axis.vertical);
            },
          );
        });
  }

  Widget topCategoryListWidget({
    required String category,
    required DappList? list,
    Axis axis = Axis.vertical,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 21,
        vertical: widget.isInExploreCategory ? 0 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSeeAll(category),
          const SizedBox(
            height: 20,
          ),
          axis == Axis.horizontal
              ? buildHorizontalList(axis: axis, list: list)
              : buildVerticalList(list: list),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget buildTitleAndSeeAll(String category) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (widget.isInExploreCategory)
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: CustomChip(
                      handler: handler,
                      title:
                          "${context.getLocale!.top} ${category.toUpperCase()}"),
                ),
              )
            : Text(
                "${context.getLocale!.top} ${category.toUpperCase()}",
                style: handler.theme.buttonTextStyle,
              ),
        TextButton(
            onPressed: () {
              context.pushRoute(CategoryScreen(category: category));
            },
            child: Row(
              children: [
                Text(
                  context.getLocale!.seeAll,
                  style: (widget.isInExploreCategory)
                      ? handler.theme.bodyTextStyle
                      : handler.theme.normalTextStyle,
                ),
                if (widget.isInExploreCategory)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: handler.theme.bodyTextColor,
                      size: handler.theme.bodyTextStyle.fontSize,
                    ),
                  )
              ],
            ))
      ],
    );
  }

  Widget buildHorizontalList({required Axis axis, required DappList? list}) {
    return SizedBox(
      height: 210,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.symmetric(vertical: 12),
        cacheExtent: 200,
        scrollDirection: axis,
        itemBuilder: (BuildContext context, int index) {
          if (list?.response?[index] == null) {
            return const SizedBox();
          }
          return DappListHorizantal(
            dapp: list!.response![index]!,
            handler: handler,
          );
        },
      ),
    );
  }

  Widget buildVerticalList({required DappList? list}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      itemCount: 4,
      addAutomaticKeepAlives: true,
      cacheExtent: 200,
      itemBuilder: (BuildContext context, int index) {
        if (list?.response?[index] == null) {
          return const SizedBox();
        }
        return DappListTile(
          dapp: list!.response![index]!,
          handler: handler,
          isThreeLines: widget.isInExploreCategory,
        );
      },
    );
  }
}
