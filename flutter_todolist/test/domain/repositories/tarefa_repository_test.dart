import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todolist/core/errors/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/domain/repositories/itarefa_repository.dart';
import 'package:flutter_todolist/domain/services/get_tarefas_service.dart';

import 'tarefa_repository_test.mocks.dart';

// Gera um mock do ITarefaRepository
@GenerateMocks([ITarefaRepository])
void main() {
  late GetTarefasService service;
  late MockITarefaRepository mockRepository;

  setUpAll(() {
    mockRepository = MockITarefaRepository();
    service = GetTarefasService(mockRepository);
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

  test(
    'Deve retornar uma lista de tarefas quando o repositório retornar sucesso',
    () async {
      when(mockRepository.getTarefas()).thenAnswer((_) async => Right(tarefas));

      final result = await service();

      expect(result, Right(tarefas));

      verify(mockRepository.getTarefas()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Deve retornar um ServerFailure quando o repositório lançar uma exceção',
    () async {
      // Simulando um erro no repositório
      when(
        mockRepository.getTarefas(),
      ).thenThrow(Exception('Erro no servidor'));

      // Chamando o caso de uso
      final resultado = await service();

      // Verificando se um erro foi retornado corretamente
      expect(resultado, isA<Left>());
      resultado.fold(
        (falha) {
          // Verificando se a falha é do tipo GetTarefasFailure (ServerFailure)
          expect(falha, isA<GetTarefasFailure>());
        },
        (listaTarefas) =>
            fail('Esperava-se um Left, mas obteve Right: $listaTarefas'),
      );
    },
  );
}
