import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';

class SelfUpdateHandler implements ISelfUpdateHandler {
  @override
  ISelfUpdateCubit getSelfUpdateCubit() {
    return getIt<ISelfUpdateCubit>();
  }

  @override
  getSelfUpdate({required String address}) async {
    SelfUpdateModel? model =
        await getSelfUpdateCubit().getSelfUpdate(address: address);
    if (model == null) {
      postSelfUpdate(address: address);
    }
  }

  @override
  postSelfUpdate({required String address}) {
    getSelfUpdateCubit()
        .postSelfUpdate(model: SelfUpdateModel(address: address, name: ""));
  }
}
