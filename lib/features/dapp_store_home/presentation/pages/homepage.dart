import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IStoreCubit cubit = getIt<StoreCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IStoreCubit, StoreState>(
      bloc: cubit,
      builder: (context, webViewState) {
        return Scaffold(
          appBar: AppBar(title: const Text("test")),
          body: Column(
            children: [
              Center(
                child: ElevatedButton(
                  child: const Text("getdappList"),
                  onPressed: () {
                    cubit.getDappList();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("nextPageList"),
                  onPressed: () {
                    cubit.getDappListNextPage();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getDappInfo"),
                  onPressed: () {
                    cubit.getDappInfo(
                        queryParams: GetDappInfoQueryDto(
                            dappId: "com.crypteriors.dapp"));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getCuratedList"),
                  onPressed: () {
                    cubit.getCuratedList();
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getSearchResult"),
                  onPressed: () {
                    cubit.getSearchDappList(
                        queryParams: GetDappQueryDto(search: "cryp"));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("getSearchResultNextPage"),
                  onPressed: () {
                    cubit.getSearchDappListNextPage();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
