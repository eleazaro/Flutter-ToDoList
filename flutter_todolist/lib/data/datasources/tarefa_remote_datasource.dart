import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';

abstract class TarefaRemoteDataSource {
  Future<List<TarefaEntity>> getTarefas();
  Future<void> postTarefa(TarefaEntity tarefa);
  Future<void> putTarefa(TarefaEntity tarefa);
  Future<void> deleteTarefa(int id);
}
