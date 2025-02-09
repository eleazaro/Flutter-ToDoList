import '../../domain/entities/tarefa_entity.dart';
import '../../domain/repositories/tarefa_repository.dart';

class PostTarefaUseCase {
  final TarefaRepository repository;

  PostTarefaUseCase(this.repository);

  Future<void> call(TarefaEntity tarefa) async {
    await repository.postTarefa(tarefa);
  }
}
