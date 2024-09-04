import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/sign_up.dart';
import 'package:news_app/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements Usecase<String, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignInParams params) {
    return authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password,
  });
}
