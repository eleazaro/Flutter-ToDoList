import '../entities/tarefa_entity.dart';
import '../repositories/itarefa_repository.dart';

class PostTarefaService {
  final ITarefaRepository repository;

  PostTarefaService(this.repository);

  Future<void> call(TarefaEntity tarefa) async {
    await repository.postTarefa(tarefa);
  }
}
