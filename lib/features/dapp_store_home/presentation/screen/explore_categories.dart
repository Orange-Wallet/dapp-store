import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/custom_search_delegate.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_by_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/top_category_list.dart';
import 'package:flutter/material.dart';

class ExploreCategories extends StatefulScreen {
  const ExploreCategories({super.key});

  @override
  State<ExploreCategories> createState() => _ExploreCategoriesState();

  @override
  String get route => Routes.home;
}

class _ExploreCategoriesState extends State<ExploreCategories> {
  late final IDappStoreHandler storeHandler;
  late final IStoreCubit storeCubit;
  @override
  void initState() {
    super.initState();
    storeHandler = DappStoreHandler();
    storeHandler.started();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: storeHandler.theme.backgroundColor,
      appBar: const NormalAppBar(),
      body: ListView(
        addAutomaticKeepAlives: true,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 20,
        children: const [
          ExploreBycategories(
            useSmallGrid: true,
          ),
          TopCategoriesList(isInExploreCategory: true),
        ],
      ),
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NormalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: handler.theme.appBarBackgroundColor,
      automaticallyImplyLeading: true,
      leading: InkWell(
        onTap: context.popRoute,
        child: Icon(
          Icons.arrow_back,
          color: handler.theme.whiteColor,
        ),
      ),
      title: Text(
        context.getLocale!.categories,
        style: handler.theme.headingTextStyle,
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate:
                      CustomSearchDelegate(handler: handler, context: context));
            },
            icon: Icon(Icons.search, color: handler.theme.whiteColor)),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: handler.theme.whiteColor,
            ))
      ],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
