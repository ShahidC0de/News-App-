import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';

abstract class Usecase<SuccessType, Params> {
  Future<Either<Failure, String>> call(Params params);
}
