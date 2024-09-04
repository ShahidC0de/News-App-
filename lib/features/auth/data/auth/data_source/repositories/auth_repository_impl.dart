import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/auth/data/auth/data_source/auth_remote_datasource.dart';
import 'package:news_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  const AuthRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final response = await remoteDatasource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
