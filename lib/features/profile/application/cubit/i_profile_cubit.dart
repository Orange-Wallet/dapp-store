import 'package:dappstore/features/profile/application/cubit/profile_cubit.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/profile_repository.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IProfileCubit extends Cubit<ProfileState> {
  final IProfileStore profileStore;
  final IProfileRepo profileRepo;
  IProfileCubit(
      {required this.profileStore, required ProfileRepoImpl this.profileRepo})
      : super(ProfileState.initial());

  started();

  initialize();
}
