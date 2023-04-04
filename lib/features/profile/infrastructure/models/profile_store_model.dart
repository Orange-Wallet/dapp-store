import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

@freezed
@HiveType(typeId: 5)
class ProfileStoreModel with _$ProfileStoreModel {
  const factory ProfileStoreModel({
    @HiveField(1) required String topidID,
    @HiveField(2) required String signature,
  }) = _ProfileStoreModel;
  factory ProfileStoreModel.fromJson(Map<String, Object?> json) =>
      _$ProfileStoreModelFromJson(json);
}
