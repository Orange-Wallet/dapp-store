import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/domain/package_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../../generated/features/saved_dapps/application/saved_dapps_cubit.freezed.dart';
part 'saved_dapps_state.dart';

@LazySingleton(as: ISavedDappsCubit)
class SavedDappsCubit extends Cubit<SavedDappsState>
    implements ISavedDappsCubit {
  final IPackageManager packageManager;
  final IStoreCubit storeCubit;
  SavedDappsCubit({
    required this.packageManager,
    required this.storeCubit,
  }) : super(SavedDappsState.initial());

  @override
  initialise() async {
    emit(state.copyWith(loading: true));
    final installedApps = packageManager.installedAppsList();
    final dappList = await storeCubit.queryWithPackageId(
        pacakgeIds: installedApps.values.map((e) => e.packageName!).toList());
    final nonNullDappInfo = dappList.response?.where((e) => e != null).toList()
            as List<DappInfo>? ??
        [];
    final List<DappInfo> toUpdate = [];
    final List<DappInfo> notToUpdate = [];
    for (var element in nonNullDappInfo) {
      double deviceVersion =
          installedApps[element.androidPackage!]?.versionCode ?? 0;
      double availableVersion = double.tryParse(element.version ?? "0") ?? 0;
      if (deviceVersion < availableVersion) {
        toUpdate.add(element);
      } else {
        notToUpdate.add(element);
      }
    }
    emit(state.copyWith(
      dappInfoList: nonNullDappInfo,
      loading: false,
      noUpdate: notToUpdate,
      needUpdate: toUpdate,
    ));
  }

  @override
  List<DappInfo> get toUpdate => state.needUpdate!;
  @override
  int get updateAppCount => state.needUpdate!.length;
  @override
  List<DappInfo> get noUpdate => state.noUpdate!;
  @override
  List<DappInfo> get allApps => state.dappInfoList!;
}
