import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import '../controllers/tarefa_controller.dart';

class TarefaFormPage extends StatefulWidget {
  final TarefaController controller;
  final TarefaEntity? tarefaEditada;

  const TarefaFormPage({
    required this.controller,
    this.tarefaEditada,
    super.key,
  });

  @override
  TarefaFormPageState createState() => TarefaFormPageState();
}

class TarefaFormPageState extends State<TarefaFormPage> {
  late final TextEditingController _tituloController;
  late final TextEditingController _descricaoController;
  late StatusTarefa _status;
  DateTime? _concluidoEm;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(
      text: widget.tarefaEditada?.titulo ?? '',
    );
    _descricaoController = TextEditingController(
      text: widget.tarefaEditada?.descricao ?? '',
    );
    _status = widget.tarefaEditada?.status ?? StatusTarefa.pendente;
    _concluidoEm = widget.tarefaEditada?.concluidoEm;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Color _getStatusColor(StatusTarefa status) {
    switch (status) {
      case StatusTarefa.concluida:
        return const Color(0xFFE1F9E3);
      case StatusTarefa.emProgresso:
        return const Color(0xFFF7FFDB);
      case StatusTarefa.pendente:
        return const Color(0xFFFFD1D1);
    }
  }

  Future<void> _selectConcluidoEm(BuildContext buildContext) async {
    final DateTime? picked = await showDatePicker(
      context: buildContext,
      initialDate: _concluidoEm ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: buildContext,
        initialTime: TimeOfDay.fromDateTime(_concluidoEm ?? DateTime.now()),
      );
      if (time != null) {
        setState(() {
          _concluidoEm = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatarData(DateTime data) {
    return '${data.hour}:${data.minute.toString().padLeft(2, '0')} ${data.day}/${data.month}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getStatusColor(_status),
      appBar: AppBar(
        title: Text(
          widget.tarefaEditada == null ? 'Nova Tarefa' : 'Editar Tarefa',
        ),
        backgroundColor: _getStatusColor(_status),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título da Tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição da Tarefa',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<StatusTarefa>(
              value: _status,
              onChanged: (StatusTarefa? newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
              items:
                  StatusTarefa.values.map((StatusTarefa status) {
                    return DropdownMenuItem<StatusTarefa>(
                      value: status,
                      child: Text(
                        status == StatusTarefa.pendente
                            ? 'Pendente'
                            : status == StatusTarefa.emProgresso
                            ? 'Em Progresso'
                            : 'Concluída',
                      ),
                    );
                  }).toList(),
              decoration: const InputDecoration(labelText: 'Status da Tarefa'),
            ),
            const SizedBox(height: 16),
            if (widget.tarefaEditada != null)
              Text(
                'Criado em: ${_formatarData(widget.tarefaEditada!.criadoEm)}',
              ),
            const SizedBox(height: 16),
            if (_status == StatusTarefa.concluida)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Data de Conclusão:'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _selectConcluidoEm(context),
                    child: Text(
                      _concluidoEm == null
                          ? 'Selecionar Data e Hora'
                          : 'Concluído em: ${_formatarData(_concluidoEm!)}',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_tituloController.text.isNotEmpty &&
                        _descricaoController.text.isNotEmpty) {
                      final novaTarefa = TarefaEntity(
                        id: widget.tarefaEditada?.id ?? 0,
                        titulo: _tituloController.text,
                        descricao: _descricaoController.text,
                        criadoEm:
                            widget.tarefaEditada?.criadoEm ?? DateTime.now(),
                        concluidoEm: _concluidoEm,
                        status: _status,
                      );

                      if (widget.tarefaEditada != null) {
                        widget.controller.editarTarefa(novaTarefa);
                      } else {
                        widget.controller.adicionarTarefa(novaTarefa);
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos!'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.tarefaEditada == null ? 'Salvar' : 'Atualizar',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
