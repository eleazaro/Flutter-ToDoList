import '../../domain/repositories/tarefa_repository.dart';

class DeleteTarefaUseCase {
  final TarefaRepository repository;

  DeleteTarefaUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTarefa(id);
  }
}
