import 'package:dartz/dartz.dart';
import 'package:flutter_todolist/core/errors/failures.dart';

import '../repositories/itarefa_repository.dart';

class DeleteTarefaService {
  final ITarefaRepository repository;

  DeleteTarefaService(this.repository);

  Future<Either<Failure, Null>> call(int id) async {
    try {
      await repository.deleteTarefa(id);
      return Right(null);
    } catch (e) {
      return Left(DeleteTarefasFailure());
    }
  }
}
