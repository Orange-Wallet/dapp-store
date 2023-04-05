import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart';

class SelfUpdateHandler implements ISelfUpdateHandler {
  @override
  ISelfUpdateCubit get selfUpdateCubit => getIt<ISelfUpdateCubit>();

  @override
  getLatestBuild() async {
    selfUpdateCubit.getLatestBuild();
  }

  @override
  triggerUpdate() {}
}
