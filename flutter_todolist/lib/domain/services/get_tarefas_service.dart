import 'package:dartz/dartz.dart';
import 'package:flutter_todolist/core/errors/failures.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/domain/repositories/itarefa_repository.dart';

class GetTarefasService {
  final ITarefaRepository repository;

  GetTarefasService(this.repository);

  Future<Either<Failure, List<TarefaEntity>>> call() async {
    try {
      return await repository.getTarefas();
    } catch (e) {
      return Left(GetTarefasFailure());
    }
  }
}
