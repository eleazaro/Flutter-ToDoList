import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/presentation/widgets/tarefa_form_modal.dart';
import '../controllers/tarefa_controller.dart';

class TarefaListItem extends StatelessWidget {
  final TarefaEntity tarefa;
  final TarefaController controller;
  final int index;

  const TarefaListItem({
    required this.tarefa,
    required this.controller,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tarefa.titulo),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        controller.removerTarefa(index);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Tarefa removida')));
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(tarefa.titulo),
        subtitle: Text(tarefa.descricao),
        trailing: Icon(Icons.check_circle_outline),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => TarefaFormModal(
                    controller: controller,
                    tarefaEditada: tarefa,
                    index: index,
                  ),
            ),
          );
        },
      ),
    );
  }
}
