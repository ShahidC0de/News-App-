import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, String>> call(Params params);
}
