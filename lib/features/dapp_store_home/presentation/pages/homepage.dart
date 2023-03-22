import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final IDappStoreHandler storeHandler;
  late final IStoreCubit storeCubit;
  IDownloader downloaderCubit = getIt<IDownloader>();
  IPermissions permissiosnCubit = getIt<IPermissions>();
  IForegroundService foregroundService = getIt<IForegroundService>();
  IInstalledAppsCubit installedApps = getIt<IInstalledAppsCubit>();
  IThemeCubit themeCubit = getIt<IThemeCubit>();
  @override
  void initState() {
    storeHandler = DappStoreHandler();
    storeCubit = storeHandler.getStoreCubit();
    downloaderCubit.initializeStorageDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IStoreCubit, StoreState>(
      bloc: storeCubit,
      builder: (context, webViewState) {
        return Scaffold(
          appBar: AppBar(title: const Text("test")),
          body: ListView(
            children: [
              Center(
                child: ElevatedButton(
                  child: const Text("getdappList"),
                  onPressed: () {
                    storeHandler.getDappList();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("nextPageList"),
                  onPressed: () {
                    storeHandler.getDappListNextPage();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getDappInfo"),
                  onPressed: () {
                    storeHandler.getDappInfo(
                        queryParams: GetDappInfoQueryDto(
                            dappId: "com.crypteriors.dapp"));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getCuratedList"),
                  onPressed: () {
                    storeHandler.getCuratedList();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getSearchResult"),
                  onPressed: () {
                    storeHandler.getSearchDappList(
                        queryParams: GetDappQueryDto(search: "cryp"));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getSearchResultNextPage"),
                  onPressed: () {
                    storeHandler.getSearchDappListNextPage();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Request Permission"),
                  onPressed: () {
                    permissiosnCubit.requestStoragePermission();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("download APK"),
                  onPressed: () {
                    downloaderCubit.requestDownload(const TaskInfo(
                      name: "Test",
                      link:
                          "https://github.com/bartekpacia/spitfire/releases/download/v1.2.0/spitfire.apk",
                    ));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("START FG"),
                  onPressed: () {
                    foregroundService.startForegroundService();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Foreground service"),
                  onPressed: () {
                    foregroundService.stopForegroundService();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Status"),
                  onPressed: () {
                    final status = foregroundService.statusForegroundService();
                    debugPrint("Status: $status");
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Packages"),
                  onPressed: () async {
                    final status = await installedApps.getInstalledApps(
                        excludeSystemApps: true,
                        withIcon: true,
                        packageNamePrefix: "");
                    debugPrint("Status: ${status![0].name}");
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Test Theme toggle"),
                  onPressed: () async {
                    await themeCubit.toggleShouldFollowSystem(true);
                  },
                ),
              ),
              const WCTestWidget(),
            ],
          ),
        );
      },
    );
  }
}
