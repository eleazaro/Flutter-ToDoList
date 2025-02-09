import 'package:flutter/material.dart';
import '../../domain/entities/tarefa_entity.dart';
import '../../domain/repositories/tarefa_repository.dart';

class TarefaController extends ChangeNotifier {
  final TarefaRepository repository;
  List<TarefaEntity> _tarefas = [];
  Set<StatusTarefa> _filtroStatus = {
    StatusTarefa.pendente,
    StatusTarefa.emProgresso,
    StatusTarefa.concluida,
  }; // Filtros padrão (todos os status)

  TarefaController(this.repository);

  List<TarefaEntity> get tarefas => _tarefas;

  Set<StatusTarefa> get filtroStatus => _filtroStatus;

  List<TarefaEntity> get tarefasFiltradas {
    return _tarefas
        .where((tarefa) => _filtroStatus.contains(tarefa.status))
        .toList();
  }

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

  void atualizarFiltro(Set<StatusTarefa> novosFiltros) {
    _filtroStatus = novosFiltros;
    notifyListeners();
  }
}
