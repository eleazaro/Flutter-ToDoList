import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';

class TarefaController extends ChangeNotifier {
  List<TarefaEntity> _tarefas = [
    TarefaEntity(titulo: 'Tarefa 1', descricao: 'Descrição da Tarefa 1'),
    TarefaEntity(titulo: 'Tarefa 2', descricao: 'Descrição da Tarefa 2'),
    TarefaEntity(titulo: 'Tarefa 3', descricao: 'Descrição da Tarefa 3'),
    TarefaEntity(titulo: 'Tarefa 4', descricao: 'Descrição da Tarefa 4'),
  ];

  List<TarefaEntity> get tarefas => _tarefas;

  void adicionarTarefa(TarefaEntity tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void editarTarefa(int index, TarefaEntity tarefa) {
    _tarefas[index] = tarefa;
    notifyListeners();
  }

  void removerTarefa(int index) {
    _tarefas.removeAt(index);
    notifyListeners();
  }
}
