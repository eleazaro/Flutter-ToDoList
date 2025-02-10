import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/presentation/view/tarefa_page.dart';
import 'package:flutter_todolist/presentation/controllers/tarefa_controller.dart';
import 'package:flutter_todolist/presentation/widgets/tarefa_card.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../services/get_tarefas_test.mocks.dart';

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

  testWidgets('Verifica widgets que deve ter em tela caso de sucesso', (
    WidgetTester tester,
  ) async {
    when(mockGetTarefasService()).thenAnswer((_) async => Right(tarefas));
    await controller.carregarTarefas();

    // Construir o widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<TarefaController>.value(
          value: controller,
          child: const TarefaPage(),
        ),
      ),
    );

    expect(find.byType(TarefaCard), findsExactly(2));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Verifica modal de pesquisa quando tap no icone', (
    WidgetTester tester,
  ) async {
    when(mockGetTarefasService()).thenAnswer((_) async => Right(tarefas));
    await controller.carregarTarefas();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<TarefaController>.value(
          value: controller,
          child: const TarefaPage(),
        ),
      ),
    );

    //Valida antes de tap que nao tem o texto
    expect(find.text('Filtrar por Status'), findsNothing);

    await tester.tap(find.byIcon(Icons.search));

    //Espera o modal abrir
    await tester.pumpAndSettle(const Duration(seconds: 1));

    //Valida se tem um texto da busca por status
    expect(find.text('Filtrar por Status'), findsOneWidget);
  });

  testWidgets('Golden test da página de tarefas', (WidgetTester tester) async {
    when(mockGetTarefasService()).thenAnswer((_) async => Right(tarefas));
    await controller.carregarTarefas();

    // Construir o widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<TarefaController>.value(
          value: controller,
          child: const TarefaPage(),
        ),
      ),
    );

    // Verificar se o widget renderizado corresponde ao arquivo de referência
    await expectLater(
      find.byType(TarefaPage),
      matchesGoldenFile('golden/tarefa_page.png'),
    );
  });
}
