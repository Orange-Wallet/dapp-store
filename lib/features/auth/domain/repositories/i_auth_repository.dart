import 'package:dappstore/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<bool> isSignedIn();

  Future<Either<NetworkFailure, Unit>> signIn();

  Future<Either<NetworkFailure, Unit>> signOut();
}
