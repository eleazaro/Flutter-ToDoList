import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/pages/tarefa_form_page.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';
import '../widgets/tarefa_card.dart';
import '../../domain/entities/tarefa_entity.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tarefaController = Provider.of<TarefaController>(
        context,
        listen: false,
      );
      tarefaController.carregarTarefas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tarefaController = Provider.of<TarefaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciamento de Tarefas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _abrirModalFiltro(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) =>
                          TarefaFormPage(controller: tarefaController),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: tarefaController,
        builder: (context, child) {
          final tarefasFiltradas = tarefaController.tarefasFiltradas;

          if (tarefasFiltradas.isEmpty) {
            return const Center(child: Text("Nenhuma tarefa encontrada"));
          }

          final firstTarefa = tarefasFiltradas.first;
          final remainingTarefas = tarefasFiltradas.sublist(1);

          return Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: TarefaCard(tarefa: firstTarefa),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: remainingTarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = remainingTarefas[index];
                    return SizedBox(
                      width: 200,
                      child: TarefaCard(tarefa: tarefa),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _abrirModalFiltro(BuildContext context) {
    final tarefaController = Provider.of<TarefaController>(
      context,
      listen: false,
    );
    final filtroTemporario = Set<StatusTarefa>.from(
      tarefaController.filtroStatus,
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtrar por Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...StatusTarefa.values.map((status) {
                    return CheckboxListTile(
                      title: Text(
                        status == StatusTarefa.pendente
                            ? 'Pendente'
                            : status == StatusTarefa.emProgresso
                            ? 'Em Progresso'
                            : 'Concluída',
                      ),
                      value: filtroTemporario.contains(status),
                      onChanged: (value) {
                        setModalState(() {
                          if (value == true) {
                            filtroTemporario.add(status);
                          } else {
                            filtroTemporario.remove(status);
                          }
                        });
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        tarefaController.atualizarFiltro(filtroTemporario);
                      },
                      child: const Text('Aplicar Filtros'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
