part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.isLoggedIn = false,
  });

  final bool isLoggedIn;

  factory AuthState.initial() => const AuthState();

  @override
  List<Object> get props => [isLoggedIn];
}
