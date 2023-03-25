import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBycategories extends StatefulWidget {
  const ExploreBycategories({super.key});

  @override
  State<ExploreBycategories> createState() => _ExploreBycategoriesState();
}

class _ExploreBycategoriesState extends State<ExploreBycategories> {
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
            previous.curatedCategoryList.hashCode !=
            current.curatedCategoryList.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          List<CuratedCategoryList?>? list = state.curatedCategoryList;
          if (list == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.getLocale!.exploreByCategories,
                  style: handler.theme.buttonTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  cacheExtent: 200,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return getGridTile(list[index]);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        });
  }

  Widget getGridTile(CuratedCategoryList? curatedCategory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      height: 100,
      width: 100,
      child: InkWell(
        onTap: () {
          //TODO add onclick redirection to category page
        },
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
        child: Stack(
          children: [
            ImageWidgetCached(
              curatedCategory?.image ?? "",
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: handler.theme.secondaryBackgroundColor.withOpacity(0.7),
                width: double.maxFinite,
                child: Text(
                  curatedCategory?.category?.toUpperCase() ?? "",
                  style: handler.theme.buttonTextStyle,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
