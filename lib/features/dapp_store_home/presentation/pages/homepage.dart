import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          body: Container(
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    child: Text("getdappList"),
                    onPressed: () {
                      cubit.getDappList();
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text("nextPageList"),
                    onPressed: () {
                      cubit.getDappListNextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
