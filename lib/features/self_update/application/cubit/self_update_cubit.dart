import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part '../../../../generated/features/self_update/application/cubit/self_update_cubit.freezed.dart';
part '../../../../generated/features/self_update/application/cubit/self_update_cubit.g.dart';
part 'self_update_state.dart';

@LazySingleton(as: ISelfUpdateCubit)
class SelfUpdateCubit extends Cubit<SelfUpdateState>
    implements ISelfUpdateCubit {
  @override
  final ISelfUpdateRepo selfUpdateRepo;
  IErrorLogger errorLogger;

  SelfUpdateCubit({
    required this.errorLogger,
    required this.selfUpdateRepo,
  }) : super(SelfUpdateState.initial());

  @override
  getLatestBuild() async {
    SelfUpdateDataModel? model = await selfUpdateRepo.getLatestBuild();
    if (model != null) {
      emit(
        state.copyWith(
          url: model.url,
          latestVersion: model.latestVersion,
          minimumSupportedVersion: model.minimumSupportedVersion,
        ),
      );
      return model;
    } else {
      return null;
    }
  }

  @override
  getCurrentAppVersion() async {
    PackageInfo? pacakge = await selfUpdateRepo.getAppVersion();
    if (pacakge != null) {
      emit(
        state.copyWith(
          currentAppVersion: pacakge.version,
        ),
      );
      return pacakge;
    } else {
      return null;
    }
  }
}
