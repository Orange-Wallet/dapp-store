import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part '../../../../generated/features/self_update/infrastructure/models/self_update_store_model.freezed.dart';
part '../../../../generated/features/self_update/infrastructure/models/self_update_store_model.g.dart';

@freezed
@HiveType(typeId: 5)
class SelfUpdateStoreModel with _$SelfUpdateStoreModel {
  const factory SelfUpdateStoreModel({
    @HiveField(1) required String address,
    @HiveField(2) required String name,
  }) = _SelfUpdateStoreModel;
  factory SelfUpdateStoreModel.fromJson(Map<String, Object?> json) =>
      _$SelfUpdateStoreModelFromJson(json);

  // SelfUpdateModel toModel() {
  //   return SelfUpdateModel(name: name, address: address);
  // }
}
