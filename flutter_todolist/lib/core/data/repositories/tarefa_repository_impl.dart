import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/domain/repositories/tarefa_repository.dart';
import '../../data/datasources/tarefa_remote_datasource.dart';
import '../../data/models/tarefa_model.dart';

class TarefaRepositoryImpl implements TarefaRepository {
  final TarefaRemoteDataSource remoteDataSource;

  TarefaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TarefaEntity>> getTarefas() async {
    return await remoteDataSource.getTarefas();
  }

  @override
  Future<void> postTarefa(TarefaEntity tarefa) async {
    await remoteDataSource.postTarefa(
      TarefaModel(
        id: tarefa.id,
        titulo: tarefa.titulo,
        descricao: tarefa.descricao,
        criadoEm: tarefa.criadoEm,
        status: tarefa.status,
        concluidoEm: tarefa.concluidoEm,
      ),
    );
  }

  @override
  Future<void> putTarefa(TarefaEntity tarefa) async {
    await remoteDataSource.putTarefa(
      TarefaModel(
        id: tarefa.id,
        titulo: tarefa.titulo,
        descricao: tarefa.descricao,
        criadoEm: tarefa.criadoEm,
        status: tarefa.status,
        concluidoEm: tarefa.concluidoEm,
      ),
    );
  }

  @override
  Future<void> deleteTarefa(int id) async {
    await remoteDataSource.deleteTarefa(id);
  }
}
