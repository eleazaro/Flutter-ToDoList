import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';
import '../widgets/tarefa_list_item.dart';
import '../widgets/tarefa_form_modal.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  TarefaPageState createState() => TarefaPageState();
}

class TarefaPageState extends State<TarefaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final controller = Provider.of<TarefaController>(context, listen: false);
      controller.carregarTarefas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TarefaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciamento de Tarefas"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TarefaFormModal(controller: controller),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return ListView.builder(
            itemCount: controller.tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = controller.tarefas[index];
              return TarefaListItem(
                tarefa: tarefa,
                controller: controller,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
