import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/sign_up.dart';
import 'package:news_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
