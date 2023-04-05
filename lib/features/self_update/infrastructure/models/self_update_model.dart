import 'package:dappstore/features/self_update/infrastructure/models/self_update_store_model.dart';

class SelfUpdateModel {
  final String name;
  final String address;
  SelfUpdateModel({required this.name, required this.address});
  Map<String, dynamic> toJson() {
    return {address: name};
  }

  SelfUpdateStoreModel toStoreModel() {
    return SelfUpdateStoreModel(address: address, name: name);
  }

  factory SelfUpdateModel.fromStoreModel(SelfUpdateStoreModel model) {
    return SelfUpdateModel(name: model.name, address: model.address);
  }
}
