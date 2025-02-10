import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todolist/core/errors/failures.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/domain/services/get_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/delete_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/post_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/put_tarefas_service.dart';
import 'package:flutter_todolist/presentation/controllers/tarefa_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tarefas_test.mocks.dart';

// Adicione a anotação para gerar mocks automaticamente
@GenerateMocks([
  GetTarefasService,
  DeleteTarefaService,
  PostTarefaService,
  PutTarefaService,
])
void main() {
  late TarefaController controller;

  late MockGetTarefasService mockGetTarefasService;
  late MockDeleteTarefaService mockDeleteTarefasService;
  late MockPostTarefaService mockPostTarefasService;
  late MockPutTarefaService mockPutTarefasService;

  setUpAll(() {
    mockGetTarefasService = MockGetTarefasService();
    mockPostTarefasService = MockPostTarefaService();
    mockPutTarefasService = MockPutTarefaService();
    mockDeleteTarefasService = MockDeleteTarefaService();

    controller = TarefaController(
      getTarefasService: mockGetTarefasService,
      postTarefaService: mockPostTarefasService,
      putTarefaService: mockPutTarefasService,
      deleteTarefaService: mockDeleteTarefasService,
    );
  });

  List<TarefaEntity> tarefas = [
    TarefaEntity(
      id: 1,
      titulo: 'Ler livro',
      descricao: 'Terminar capítulo 4',
      criadoEm: DateTime(2024, 2, 9, 12, 0),
      status: StatusTarefa.pendente,
    ),
    TarefaEntity(
      id: 2,
      titulo: 'Treinar Flutter',
      descricao: 'Praticar testes unitários',
      criadoEm: DateTime(2024, 2, 8, 18, 30),
      status: StatusTarefa.emProgresso,
    ),
  ];

  test('Deve carregar tarefas com sucesso', () async {
    when(mockGetTarefasService()).thenAnswer((_) async => Right(tarefas));

    await controller.carregarTarefas();

    // Verificando se o controller armazenou as tarefas corretamente
    expect(controller.tarefas, equals(tarefas));
    expect(controller.tarefas.length, 2);
    expect(controller.tarefas[0].titulo, 'Ler livro');
    expect(controller.tarefas[1].titulo, 'Treinar Flutter');
  });

  test('Deve lidar com falha ao carregar tarefas', () async {
    // Simulando um erro no caso de uso
    when(
      mockGetTarefasService(),
    ).thenAnswer((_) async => Left(GetTarefasFailure()));

    await controller.carregarTarefas();

    // Verificando se a lista de tarefas está sem tarefas após a falha
    expect(controller.tarefas.length, 0);
  });
}
