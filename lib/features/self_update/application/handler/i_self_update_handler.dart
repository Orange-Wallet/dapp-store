import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';

abstract class ISelfUpdateHandler {
  ISelfUpdateCubit get selfUpdateCubit;

  getLatestBuild();

  triggerUpdate();
}
