import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/auth/domain/usecase/sign_in.dart';
import 'package:news_app/features/auth/domain/usecase/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignupEvent>((event, emit) async {
      final response = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(
          AuthSuccess(r),
        ),
      );
    });
    on<AuthSignInEvent>((event, emit) async {
      final response = await _userSignIn(
        UserSignInParams(
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });
  }
}
