import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';

class TarefaModel extends TarefaEntity {
  TarefaModel({
    required super.id,
    required super.titulo,
    required super.descricao,
    required super.criadoEm,
    super.concluidoEm,
    required super.status,
  });

  factory TarefaModel.fromJson(Map<String, dynamic> json) {
    return TarefaModel(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      criadoEm: DateTime.parse(
        json['criadoEm'],
      ), // Converte a string para DateTime
      concluidoEm:
          json['concluidoEm'] != null
              ? DateTime.parse(json['concluidoEm'])
              : null,
      status:
          StatusTarefa.values[json['status']], // Mapeia o número para o enum
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'criadoEm': criadoEm.toIso8601String(), // Converte DateTime para string
      'concluidoEm': concluidoEm?.toIso8601String(),
      'status': status.index, // Converte o enum para número (índice)
    };
  }
}
