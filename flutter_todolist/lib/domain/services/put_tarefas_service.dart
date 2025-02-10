import '../entities/tarefa_entity.dart';
import '../repositories/itarefa_repository.dart';

class PutTarefaService {
  final ITarefaRepository repository;

  PutTarefaService(this.repository);

  Future<void> call(TarefaEntity tarefa) async {
    await repository.putTarefa(tarefa);
  }
}
