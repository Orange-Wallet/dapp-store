import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:dappstore/core/theme/theme_specs/dark_theme.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/core/theme/theme_specs/light_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../generated/core/theme/theme_cubit.freezed.dart';
part 'theme_state.dart';

@LazySingleton(as: IThemeCubit)
class ThemeCubit extends Cubit<ThemeState> implements IThemeCubit {
  final IThemeStore themeStore;
  ThemeCubit({required this.themeStore}) : super(ThemeState.initial());
  @override
  initialise() async {
    final isDark = await _isDarkEnabledStorage();
    if (isDark == true) {
      emit(state.copyWith(activeTheme: DarkTheme(), isDark: true));
    } else {
      emit(state.copyWith(activeTheme: LightTheme(), isDark: false));
    }
  }

  @override
  toggleTheme() {
    if (state.isDark!) {
      emit(state.copyWith(activeTheme: LightTheme(), isDark: false));
      _updateTheme(false);
    } else {
      emit(state.copyWith(activeTheme: DarkTheme(), isDark: true));
      _updateTheme(true);
    }
  }

  @override
  setLightTheme() {
    emit(state.copyWith(activeTheme: LightTheme(), isDark: false));
    _updateTheme(false);
  }

  @override
  setDarkTheme() {
    emit(state.copyWith(activeTheme: DarkTheme(), isDark: true));
    _updateTheme(true);
  }

  _updateTheme(bool isDark) async {
    await themeStore.setCurrentTheme(isDark);
  }

  Future<bool> _isDarkEnabledStorage() async {
    final isDarkEnabled = await themeStore.isDarkThemeEnabled();
    return isDarkEnabled;
  }
}
