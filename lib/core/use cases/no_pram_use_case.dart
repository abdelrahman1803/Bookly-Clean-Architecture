import 'package:bookly/core/errors/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T> {
  Future<Either<Failure, T>> call();
}
