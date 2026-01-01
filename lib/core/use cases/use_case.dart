import 'package:bookly/core/errors/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, Parameter> {
  Future<Either<Failure, T>> call(Parameter parameter);
}
