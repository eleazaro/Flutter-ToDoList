import 'package:flutter_todolist/data/datasources/tarefa_remote_datasource.dart';
import 'package:flutter_todolist/core/network/api_client.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';

class TarefaRemoteDataSourceImpl implements TarefaRemoteDataSource {
  final ApiClient apiClient;

  TarefaRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<TarefaEntity>> getTarefas() async {
    final response = await apiClient.get('/Tarefa');
    return (response).map((json) => TarefaEntity.fromJson(json)).toList();
  }

  @override
  Future<void> postTarefa(TarefaEntity tarefa) async {
    await apiClient.post('/Tarefa', tarefa.toJson());
  }

  @override
  Future<void> putTarefa(TarefaEntity tarefa) async {
    await apiClient.put('/Tarefa/${tarefa.id}', tarefa.toJson());
  }

  @override
  Future<void> deleteTarefa(int id) async {
    await apiClient.delete('/Tarefa/$id');
  }
}
