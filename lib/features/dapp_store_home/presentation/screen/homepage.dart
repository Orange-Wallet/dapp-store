import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_by_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/expolre_more_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/featured_dapp_infinite_scroll.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/featured_dapps_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/home_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/saved_dapps_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/top_category_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/update_available_card.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/self_update_handler/soft_update_popup_widget.dart';
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
  @override
  void initState() {
    super.initState();
    storeHandler = DappStoreHandler();
    storeHandler.started();
    storeHandler.selfUpdateCubit.checkUpdate().then(
      (value) {
        bool dismissable = true;
        if (value == UpdateType.hardUpdate) {
          dismissable = false;
        }
        if (value != UpdateType.noUpdate) {
          context.showBottomSheet(
            child: UpdateWidget(
              isHardUpdate: !dismissable,
            ),
            theme: storeHandler.theme,
            dismissable: dismissable,
          );
        }
      },
    );
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
        children: [
          Stack(
            children: [
              Positioned.fill(
                right: -200,
                top: -300,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: storeHandler.theme.wcBlue,
                      gradient: RadialGradient(
                        colors: [
                          storeHandler.theme.wcBlue.withOpacity(0.4),
                          storeHandler.theme.wcBlue.withOpacity(0),
                        ],
                      )),
                  height: 500,
                ),
              ),
              Column(
                children: const [
                  ExploreCard(),
                  FeaturedDappsList(),
                ],
              ),
            ],
          ),
          const SavedDappscard(),
          const ExploreBycategories(),
          const ExploreMoreCard(),
          const UpdateAvailableCard(),
          const TopCategoriesList(),
          const FeaturedDappInfiniteScroll(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              ImageConstants.htcLogo,
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }
}
