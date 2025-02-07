import 'package:flutter/material.dart';
import '../controllers/tarefa_controller.dart';
import '../widgets/tarefa_list_item.dart';
import '../widgets/tarefa_form_modal.dart';

class TarefaPage extends StatefulWidget {
  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  final TarefaController _controller = TarefaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciamento de Tarefas"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => TarefaFormModal(controller: _controller),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return ListView.builder(
            itemCount: _controller.tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = _controller.tarefas[index];
              return TarefaListItem(
                tarefa: tarefa,
                controller: _controller,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
