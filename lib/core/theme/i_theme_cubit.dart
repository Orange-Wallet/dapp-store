import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IThemeCubit extends Cubit<ThemeState> {
  IThemeCubit() : super(ThemeState.initial());

  initialise();

  toggleTheme();

  setLightTheme();

  setDarkTheme();

  IThemeSpec get theme;

  toggleShouldFollowSystem(bool shouldFollowSystem);
}
