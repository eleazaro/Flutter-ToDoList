import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import '../controllers/tarefa_controller.dart';

class TarefaFormModal extends StatefulWidget {
  final TarefaController controller;
  final TarefaEntity? tarefaEditada;
  final int? index;

  const TarefaFormModal({
    required this.controller,
    this.tarefaEditada,
    this.index,
    Key? key,
  }) : super(key: key);

  @override
  _TarefaFormModalState createState() => _TarefaFormModalState();
}

class _TarefaFormModalState extends State<TarefaFormModal> {
  late final TextEditingController _tituloController;
  late final TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(
      text: widget.tarefaEditada?.titulo ?? '',
    );
    _descricaoController = TextEditingController(
      text: widget.tarefaEditada?.descricao ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tarefaEditada == null ? 'Nova Tarefa' : 'Editar Tarefa',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título da Tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_tituloController.text.isNotEmpty &&
                    _descricaoController.text.isNotEmpty) {
                  final novaTarefa = TarefaEntity(
                    titulo: _tituloController.text,
                    descricao: _descricaoController.text,
                  );

                  if (widget.tarefaEditada != null && widget.index != null) {
                    widget.controller.editarTarefa(widget.index!, novaTarefa);
                  } else {
                    widget.controller.adicionarTarefa(novaTarefa);
                  }
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha todos os campos!')),
                  );
                }
              },
              child: Text(
                widget.tarefaEditada == null ? 'Salvar' : 'Atualizar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
