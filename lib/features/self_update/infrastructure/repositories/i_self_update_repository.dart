import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';
import 'package:dappstore/features/self_update/infrastructure/store/i_self_update_store.dart';

abstract class ISelfUpdateRepo {
  final ISelfUpdateStore SelfUpdateStore;

  ISelfUpdateRepo({required this.SelfUpdateStore});

  Future<SelfUpdateModel?> getSelfUpdate({required String address});
  Future<bool> postSelfUpdate({required SelfUpdateModel selfUpdateModel});
}
