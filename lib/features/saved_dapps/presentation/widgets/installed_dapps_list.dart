import 'package:dappstore/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart';
import 'package:dappstore/widgets/installed_dapps_tiles/installed_dapps_tile.dart';

class InstalledDappsList extends StatelessWidget {
  final ISavedDappsHandler handler;

  // ignore: prefer_const_constructors_in_immutables
  InstalledDappsList({
    Key? key,
    required this.handler,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = handler.themeCubit.theme;
    return BlocBuilder<ISavedDappsCubit, SavedDappsState>(
        bloc: handler.savedDappsCubit,
        builder: (context, state) {
          final List<DappInfo>? dappsList = state.needUpdate;
          dappsList!.addAll(state.noUpdate!);
          return ListView.builder(itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
              child:
                  InstalledDappsTile(dappInfo: dappsList[index], theme: theme),
            );
          });
        });
  }
}
