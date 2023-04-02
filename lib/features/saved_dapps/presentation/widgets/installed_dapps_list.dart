import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart';
import 'package:dappstore/widgets/installed_dapps_tiles/installed_dapps_tile.dart';

class InstalledDappsList extends StatefulWidget {
  final ISavedDappsHandler handler;

  // ignore: prefer_const_constructors_in_immutables
  InstalledDappsList({
    Key? key,
    required this.handler,
  }) : super(key: key);

  @override
  State<InstalledDappsList> createState() => _InstalledDappsListState();
}

class _InstalledDappsListState extends State<InstalledDappsList> {
  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = widget.handler.themeCubit.theme;
    return BlocBuilder<ISavedDappsCubit, SavedDappsState>(
        bloc: widget.handler.savedDappsCubit,
        builder: (context, state) {
          List<DappInfo> dappsList = [...state.needUpdate!, ...state.noUpdate!];
          return ListView.builder(
              itemCount: dappsList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  child: InstalledDappsTile(
                      dappInfo: dappsList[index], theme: theme),
                );
              });
        });
  }
}
