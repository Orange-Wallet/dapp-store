import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
part '../../../../generated/core/theme/store/entities/theme_storage.freezed.dart';
part '../../../../generated/core/theme/store/entities/theme_storage.g.dart';

@freezed
@HiveType(typeId: 1)
class ThemeStorage extends HiveObject with _$ThemeStorage {
  factory ThemeStorage({
    @HiveField(0) bool? isDarkEnabled,
  }) = _ThemeStorage;
  factory ThemeStorage.fromJson(Map<String, Object?> json) =>
      _$ThemeStorageFromJson(json);
}
