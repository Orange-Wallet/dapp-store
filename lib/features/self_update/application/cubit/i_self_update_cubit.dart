import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/self_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ISelfUpdateCubit extends Cubit<SelfUpdateState> {
  final ISelfUpdateRepo selfUpdateRepo;
  ISelfUpdateCubit({required SelfUpdateRepoImpl this.selfUpdateRepo})
      : super(SelfUpdateState.initial());

  getLatestBuild();
  getCurrentAppVersion();
}
