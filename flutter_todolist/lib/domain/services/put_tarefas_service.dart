import 'package:dartz/dartz.dart';
import 'package:flutter_todolist/core/errors/failures.dart';

import '../entities/tarefa_entity.dart';
import '../repositories/itarefa_repository.dart';

class PutTarefaService {
  final ITarefaRepository repository;

  PutTarefaService(this.repository);

  Future<Either<Failure, Null>> call(TarefaEntity tarefa) async {
    try {
      await repository.putTarefa(tarefa);
      return Right(null);
    } catch (e) {
      return Left(PutTarefasFailure());
    }
  }
}
