import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/connect_and_explore_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_by_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/featured_dapps_grid.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/home_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/top_category_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulScreen {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  String get route => Routes.home;
}

class _HomePageState extends State<HomePage> {
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
      appBar: const HomeAppbar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        cacheExtent: 20,
        children: const [
          ConnectAndExploreCard(),
          FeaturedDappsGrid(),
          ExploreBycategories(),
          TopCategoriesList(),
        ],
      ),
    );
  }
}
