import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/usecases/delete_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/get_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/post_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/put_tarefas.dart';
import '../../domain/entities/tarefa_entity.dart';

class TarefaController extends ChangeNotifier {
  final GetTarefasUseCase getTarefasUseCase;
  final PostTarefaUseCase postTarefaUseCase;
  final PutTarefaUseCase putTarefaUseCase;
  final DeleteTarefaUseCase deleteTarefaUseCase;

  List<TarefaEntity> _tarefas = [];
  Set<StatusTarefa> _filtroStatus = {
    StatusTarefa.pendente,
    StatusTarefa.emProgresso,
    StatusTarefa.concluida,
  }; // Filtros padrão (todos os status)

  TarefaController({
    required this.getTarefasUseCase,
    required this.postTarefaUseCase,
    required this.putTarefaUseCase,
    required this.deleteTarefaUseCase,
  });

  List<TarefaEntity> get tarefas => _tarefas;

  Set<StatusTarefa> get filtroStatus => _filtroStatus;

  List<TarefaEntity> get tarefasFiltradas {
    return _tarefas
        .where((tarefa) => _filtroStatus.contains(tarefa.status))
        .toList();
  }

  Future<void> carregarTarefas() async {
    _tarefas = await getTarefasUseCase();
    notifyListeners();
  }

  Future<void> adicionarTarefa(TarefaEntity tarefa) async {
    await postTarefaUseCase(tarefa);
    await carregarTarefas(); // Recarrega as tarefas após adicionar
  }

  Future<void> editarTarefa(TarefaEntity tarefa) async {
    await putTarefaUseCase(tarefa);
    await carregarTarefas(); // Recarrega as tarefas após editar
  }

  Future<void> removerTarefa(int id) async {
    await deleteTarefaUseCase(id);
    await carregarTarefas(); // Recarrega as tarefas após remover
  }

  void atualizarFiltro(Set<StatusTarefa> novosFiltros) {
    _filtroStatus = novosFiltros;
    notifyListeners();
  }
}
