import '../repositories/itarefa_repository.dart';

class DeleteTarefaService {
  final ITarefaRepository repository;

  DeleteTarefaService(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTarefa(id);
  }
}
