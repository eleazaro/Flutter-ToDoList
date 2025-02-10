import 'package:dartz/dartz.dart';
import 'package:flutter_todolist/core/errors/failures.dart';

import '../entities/tarefa_entity.dart';
import '../repositories/itarefa_repository.dart';

class PostTarefaService {
  final ITarefaRepository repository;

  PostTarefaService(this.repository);

  Future<Either<Failure, Null>> call(TarefaEntity tarefa) async {
    try {
      await repository.postTarefa(tarefa);
      return Right(null);
    } catch (e) {
      return Left(PostTarefasFailure());
    }
  }
}
