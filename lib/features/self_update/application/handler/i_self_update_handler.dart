import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';

abstract class ISelfUpdateHandler {
  ISelfUpdateCubit getSelfUpdateCubit();

  getSelfUpdate({required String address});

  postSelfUpdate({required String address});
}
