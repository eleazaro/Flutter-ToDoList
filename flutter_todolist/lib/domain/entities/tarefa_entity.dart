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
}

enum StatusTarefa { pendente, emProgresso, concluida }
