import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IThemeCubit extends Cubit<ThemeState> {
  IThemeCubit() : super(ThemeState.initial());

  initialise();

  toggleTheme();

  setLightTheme();

  setDarkTheme();

  toggleShouldFollowSystem(bool shouldFollowSystem);
}
