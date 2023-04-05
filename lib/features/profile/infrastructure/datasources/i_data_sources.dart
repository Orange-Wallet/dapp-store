import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';

abstract class IDataSource {
  Future<ProfileModel?> getProfile({
    required String address,
  });
  Future<bool> postProfile({
    required ProfileModel profile,
  });
}
