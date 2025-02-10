class TarefaEntity {
  final int id;
  final String titulo;
  final String descricao;
  final DateTime criadoEm;
  final DateTime? concluidoEm;
  final StatusTarefa status;

  TarefaEntity({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.criadoEm,
    this.concluidoEm,
    required this.status,
  });

  factory TarefaEntity.fromJson(Map<String, dynamic> json) {
    return TarefaEntity(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      criadoEm: DateTime.parse(json['criadoEm']),
      concluidoEm:
          json['concluidoEm'] != null
              ? DateTime.parse(json['concluidoEm'])
              : null,
      status: StatusTarefa.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'criadoEm': criadoEm.toIso8601String(),
      'concluidoEm': concluidoEm?.toIso8601String(),
      'status': status.index,
    };
  }
}

enum StatusTarefa { pendente, emProgresso, concluida }
