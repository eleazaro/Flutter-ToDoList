import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/services/delete_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/get_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/post_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/put_tarefas_service.dart';
import '../../domain/entities/tarefa_entity.dart';

class TarefaController extends ChangeNotifier {
  final GetTarefasService getTarefasService;
  final PostTarefaService postTarefaService;
  final PutTarefaService putTarefaService;
  final DeleteTarefaService deleteTarefaService;

  List<TarefaEntity> _tarefas = [];
  Set<StatusTarefa> _filtroStatus = {
    StatusTarefa.pendente,
    StatusTarefa.emProgresso,
    StatusTarefa.concluida,
  }; // Filtros padrão (todos os status)

  TarefaController({
    required this.getTarefasService,
    required this.postTarefaService,
    required this.putTarefaService,
    required this.deleteTarefaService,
  });

  List<TarefaEntity> get tarefas => _tarefas;

  Set<StatusTarefa> get filtroStatus => _filtroStatus;

  List<TarefaEntity> get tarefasFiltradas {
    return _tarefas
        .where((tarefa) => _filtroStatus.contains(tarefa.status))
        .toList();
  }

  Future<void> carregarTarefas() async {
    final serviceRequest = await getTarefasService();
    final resultado = serviceRequest.fold((l) => l, (r) => r);
    if (resultado is List<TarefaEntity>) {
      _tarefas = resultado;
      notifyListeners();
    } else {
      _tarefas = [];
    }
  }

  Future<void> adicionarTarefa(TarefaEntity tarefa) async {
    final serviceRequest = await postTarefaService(tarefa);
    final resultado = serviceRequest.fold((l) => l, (r) => r);
    if (resultado == null) {
      await carregarTarefas();
    } else {
      _tarefas = [];
    }

    notifyListeners();
  }

  Future<void> editarTarefa(TarefaEntity tarefa) async {
    final serviceRequest = await putTarefaService(tarefa);
    final resultado = serviceRequest.fold((l) => l, (r) => r);
    if (resultado == null) {
      await carregarTarefas();
    } else {
      _tarefas = [];
    }

    notifyListeners();
  }

  Future<void> removerTarefa(int id) async {
    final serviceRequest = await deleteTarefaService(id);
    final resultado = serviceRequest.fold((l) => l, (r) => r);
    if (resultado == null) {
      await carregarTarefas();
    } else {
      _tarefas = [];
    }

    notifyListeners();
  }

  void atualizarFiltro(Set<StatusTarefa> novosFiltros) {
    _filtroStatus = novosFiltros;
    notifyListeners();
  }
}
