import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/core/permissions/permissions_cubit.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
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
import 'package:dappstore/features/profile/application/handler/profile_handler.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/self_update_handler/update_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulScreen {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  String get route => Routes.home;
}

class _HomePageState extends State<HomePage> {
  late final IDappStoreHandler storeHandler;
  late final IPermissions permissions;
  bool isShowingDialog = false;
  @override
  void initState() {
    super.initState();
    storeHandler = DappStoreHandler();
    permissions = getIt<IPermissions>();
    storeHandler.started();
    ProfileHandler()
        .getProfile(address: getIt<IWalletConnectCubit>().state.activeAddress!);
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
    getPermission();
  }

  getPermission() async {
    await permissions.checkAllPermissions();

    // PermissionStatus? notificationStatus =
    //     await permissions.checkNotificationPermission();
    // if (notificationStatus != PermissionStatus.granted) {
    //   await permissions.requestNotificationPermission();
    // }

    // PermissionStatus? storageStatus =
    //     await permissions.checkStoragePermission();
    // if (storageStatus != PermissionStatus.granted) {
    //   await permissions.requestStoragePermission();
    // }

    // PermissionStatus? installStatus =
    //     await permissions.checkAppInstallationPermissions();
    // if (installStatus != PermissionStatus.granted) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IPermissions, PermissionsState>(
      bloc: permissions,
      listenWhen: (previous, current) =>
          previous.appInstallation != current.appInstallation,
      listener: (context, state) async {
        // if (state.storagePermission != PermissionStatus.granted) {
        //   await permissions.requestStoragePermission();
        // }
        // if (state.notificationPermission != PermissionStatus.granted) {
        //   await permissions.requestNotificationPermission();
        // }
        if (!isShowingDialog &&
            state.appInstallation != PermissionStatus.granted) {
          setState(() {
            isShowingDialog = true;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                backgroundColor: storeHandler.theme.cardColor,
                shape: storeHandler.theme.cardShape,
                title: Text(
                  context.getLocale!.allowAppInstall,
                  style: storeHandler.theme.biggerTitleTextStyle,
                ),
                content: Text(
                  context.getLocale!.allowAppInstallDesc,
                  style: storeHandler.theme.bodyTextStyle,
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        PermissionStatus? status = await permissions
                            .requestAppInstallationPermission();
                        if (status == PermissionStatus.granted) {
                          context.popRoute();
                          setState(() {
                            isShowingDialog = false;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: storeHandler.theme.wcBlue,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: storeHandler.theme.appGreen,
                          ),
                          borderRadius: BorderRadius.circular(
                            storeHandler.theme.buttonRadius,
                          ),
                        ),
                      ),
                      child: Text(context.getLocale!.goToSettings,
                          style: storeHandler.theme.buttonTextStyle)),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
