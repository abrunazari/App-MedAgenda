import 'package:app_medagenda/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class CmsLogic<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}