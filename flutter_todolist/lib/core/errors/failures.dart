import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTarefasFailure extends Failure {}

class PostTarefasFailure extends Failure {}

class DeleteTarefasFailure extends Failure {}

class PutTarefasFailure extends Failure {}
