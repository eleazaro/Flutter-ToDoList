import 'package:flutter_todolist/core/data/models/tarefa_model.dart';

abstract class TarefaRemoteDataSource {
  Future<List<TarefaModel>> getTarefas();
  Future<void> postTarefa(TarefaModel tarefa);
  Future<void> putTarefa(TarefaModel tarefa);
  Future<void> deleteTarefa(int id);
}
