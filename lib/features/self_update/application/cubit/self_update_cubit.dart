import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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
  getSelfUpdate({required String address}) async {
    SelfUpdateModel? model =
        await selfUpdateRepo.getSelfUpdate(address: address);
    if (model != null) {
      emit(state.copyWith(name: model.name, address: model.address));
      return model;
    } else {
      return null;
    }
  }

  @override
  postSelfUpdate({required SelfUpdateModel model}) async {
    bool res = await selfUpdateRepo.postSelfUpdate(selfUpdateModel: model);
    if (res) {
      emit(state.copyWith(address: model.address, name: model.name));
    }
    return res;
  }
}
