import '../../domain/entities/tarefa_entity.dart';
import '../../domain/repositories/tarefa_repository.dart';

class PutTarefaUseCase {
  final TarefaRepository repository;

  PutTarefaUseCase(this.repository);

  Future<void> call(TarefaEntity tarefa) async {
    await repository.putTarefa(tarefa);
  }
}
