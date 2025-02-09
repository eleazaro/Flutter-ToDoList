import '../../domain/entities/tarefa_entity.dart';
import '../../domain/repositories/tarefa_repository.dart';

class GetTarefasUseCase {
  final TarefaRepository repository;

  GetTarefasUseCase(this.repository);

  Future<List<TarefaEntity>> call() async {
    return await repository.getTarefas();
  }
}
