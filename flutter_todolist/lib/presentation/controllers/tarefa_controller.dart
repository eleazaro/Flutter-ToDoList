import 'package:flutter/material.dart';
import '../../domain/entities/tarefa_entity.dart';
import '../../domain/repositories/tarefa_repository.dart';

class TarefaController extends ChangeNotifier {
  final TarefaRepository repository;
  List<TarefaEntity> _tarefas = [];

  TarefaController(this.repository);

  List<TarefaEntity> get tarefas => _tarefas;

  Future<void> carregarTarefas() async {
    _tarefas = await repository.getTarefas();
    notifyListeners();
  }

  Future<void> adicionarTarefa(TarefaEntity tarefa) async {
    await repository.postTarefa(tarefa);
    carregarTarefas();
  }

  Future<void> editarTarefa(TarefaEntity tarefa) async {
    await repository.putTarefa(tarefa);
    carregarTarefas();
  }

  Future<void> removerTarefa(int id) async {
    await repository.deleteTarefa(id);
    carregarTarefas();
  }
}
