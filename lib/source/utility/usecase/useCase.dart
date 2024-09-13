import 'package:equatable/equatable.dart';
import 'package:flutter_ui_helper/source/utility/data_type/either.dart';
import 'package:flutter_ui_helper/source/utility/usecase/Failure.dart';

abstract class UseCase<Type, Payload> {
  Future<Type> call(Payload payload);
}

abstract class UseCaseEither<Type, Payload> {
  Future<Either<Failure, Type>> call(Payload payload);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class NoParam {}


