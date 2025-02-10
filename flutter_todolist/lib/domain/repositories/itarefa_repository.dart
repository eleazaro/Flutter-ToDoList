import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/tarefa_entity.dart';

abstract class ITarefaRepository {
  Future<Either<Failure, List<TarefaEntity>>> getTarefas();
  Future<Either<Failure, void>> postTarefa(TarefaEntity tarefa);
  Future<Either<Failure, void>> putTarefa(TarefaEntity tarefa);
  Future<Either<Failure, void>> deleteTarefa(int id);
}
