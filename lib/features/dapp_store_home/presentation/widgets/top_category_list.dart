import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/widgets/dapp/dapp_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCategoriesList extends StatefulWidget {
  const TopCategoriesList({super.key});

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
              );
            },
          );
        });
  }

  Widget topCategoryListWidget(
      {required String category, required DappList? list}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${context.getLocale!.top} ${category.toUpperCase()}",
                style: handler.theme.buttonTextStyle,
              ),
              TextButton(
                  onPressed: () {
                    //TODO take to explore page
                  },
                  child: Text(
                    context.getLocale!.seeAll,
                    style: handler.theme.normalTextStyle,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
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
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
