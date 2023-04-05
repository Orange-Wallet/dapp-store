import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/profile/application/handler/i_profile_handler.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dappstore/features/profile/random_name.dart';

class ProfileHandler implements IProfileHandler {
  @override
  IProfileCubit getProfileCubit() {
    return getIt<IProfileCubit>();
  }

  @override
  getProfile({required String address}) async {
    ProfileModel? model = await getProfileCubit().getProfile(address: address);
    if (model == null) {
      postProfile(address: address);
    }
  }

  @override
  postProfile({required String address}) {
    getProfileCubit().postProfile(
        model:
            ProfileModel(address: address, name: RandomName().generateName()));
  }
}
