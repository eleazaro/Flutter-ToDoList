import 'package:flutter_todolist/core/data/datasources/tarefa_remote_datasource.dart';
import 'package:flutter_todolist/core/data/models/tarefa_model.dart';
import 'package:flutter_todolist/core/network/api_client.dart';

class TarefaRemoteDataSourceImpl implements TarefaRemoteDataSource {
  final ApiClient apiClient;

  TarefaRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<TarefaModel>> getTarefas() async {
    final response = await apiClient.get('/Tarefa');
    return (response).map((json) => TarefaModel.fromJson(json)).toList();
  }

  @override
  Future<void> postTarefa(TarefaModel tarefa) async {
    await apiClient.post('/Tarefa', tarefa.toJson());
  }

  @override
  Future<void> putTarefa(TarefaModel tarefa) async {
    await apiClient.put('/Tarefa/${tarefa.id}', tarefa.toJson());
  }

  @override
  Future<void> deleteTarefa(int id) async {
    await apiClient.delete('/Tarefa/$id');
  }
}
