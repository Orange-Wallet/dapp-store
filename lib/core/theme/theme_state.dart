part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    IThemeSpec? activeTheme,
    bool? isDark,
    bool? shouldFollowSystem,
  }) = _ThemeState;

  factory ThemeState.initial() => ThemeState(
      activeTheme: DarkTheme(), isDark: true, shouldFollowSystem: false);
}
