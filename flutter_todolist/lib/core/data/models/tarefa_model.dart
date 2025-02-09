import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';

class TarefaModel extends TarefaEntity {
  TarefaModel({
    required super.id,
    required super.titulo,
    required super.descricao,
  });

  factory TarefaModel.fromJson(Map<String, dynamic> json) {
    return TarefaModel(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'titulo': titulo, 'descricao': descricao};
  }
}
