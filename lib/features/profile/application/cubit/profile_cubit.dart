import 'dart:developer';

import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '../../../../generated/features/profile/application/cubit/profile_cubit.freezed.dart';
part '../../../../generated/features/profile/application/cubit/profile_cubit.g.dart';
part 'profile_state.dart';

@LazySingleton(as: IProfileCubit)
class ProfileCubit extends Cubit<ProfileState> implements IProfileCubit {
  @override
  final IProfileRepo profileRepo;
  IErrorLogger errorLogger;
  @override
  final IProfileStore profileStore;
  ProfileCubit(
      {required this.errorLogger,
      required this.profileRepo,
      required this.profileStore})
      : super(ProfileState.initial());

  @override
  started() async {
    await initialize();
  }

  @override
  initialize() async {
    try {
      // log(signClient?.name ?? "error");
    } catch (e, trace) {
      log("${e.toString()}: $trace");
    }
  }
}
