import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/presentation/view/tarefa_form_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Importando a biblioteca intl
import '../controllers/tarefa_controller.dart';

class TarefaCard extends StatelessWidget {
  final TarefaEntity tarefa;

  const TarefaCard({super.key, required this.tarefa});

  String formatarData(DateTime data) {
    final formatador = DateFormat('HH:mm dd/MM/yyyy');
    return formatador.format(data);
  }

  Color _getStatusColor(StatusTarefa status) {
    switch (status) {
      case StatusTarefa.concluida:
        return const Color(0xFFB4F6C6);
      case StatusTarefa.emProgresso:
        return const Color(0xFFEDFFA7);
      case StatusTarefa.pendente:
        return const Color(0xFFFF8484);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TarefaController>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => TarefaFormPage(
                  controller: controller,
                  tarefaEditada: tarefa,
                ),
          ),
        );
      },
      child: Card(
        color: _getStatusColor(tarefa.status),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                // Adicionando o SingleChildScrollView
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tarefa.titulo,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(tarefa.descricao),
                    const SizedBox(height: 8),
                    Text('Criado em: ${formatarData(tarefa.criadoEm)}'),
                    // Exibe a data de conclusão somente se o status for 'concluida'
                    if (tarefa.status == StatusTarefa.concluida &&
                        tarefa.concluidoEm != null)
                      Text(
                        'Concluído em: ${formatarData(tarefa.concluidoEm!)}',
                      ),
                  ],
                ),
              ),
              // Ícone de lixeira no canto inferior direito
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black54),
                  onPressed: () {
                    // Mostra um diálogo de confirmação antes de deletar
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Deletar Tarefa'),
                          content: const Text(
                            'Tem certeza que deseja deletar esta tarefa?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.removerTarefa(tarefa.id);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Tarefa "${tarefa.titulo}" removida',
                                    ),
                                    action: SnackBarAction(
                                      label: 'Desfazer',
                                      onPressed: () {
                                        controller.adicionarTarefa(tarefa);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Deletar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
