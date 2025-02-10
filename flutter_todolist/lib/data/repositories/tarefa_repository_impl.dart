import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_todolist/core/errors/exceptions.dart';
import 'package:flutter_todolist/core/errors/failures.dart';
import 'package:flutter_todolist/domain/entities/tarefa_entity.dart';
import 'package:flutter_todolist/domain/repositories/itarefa_repository.dart';
import 'package:http/http.dart' as http;
import '../datasources/tarefa_remote_datasource.dart';

class TarefaRepositoryImpl implements ITarefaRepository {
  final TarefaRemoteDataSource remoteDataSource;
  final String baseUrl = "http://10.0.2.2:5131/api";

  TarefaRepositoryImpl({required this.remoteDataSource});

  //Nao estou usando data source para facilitar os testes e mostrar uma forma mais simples
  @override
  Future<Either<Failure, List<TarefaEntity>>> getTarefas() async {
    final String endpoint = '/Tarefa';

    try {
      try {
        var url = Uri.parse('$baseUrl$endpoint');
        final result = await http.get(url);

        if (result.statusCode != 200) {
          throw GetTarefasException(
            StackTrace.current,
            'GetTarefa',
            "StatusCode: ${result.statusCode}",
          );
        }

        var jsonResponse = json.decode(result.body);

        List<TarefaEntity> tarefas =
            (jsonResponse as List)
                .map(
                  (json) => TarefaEntity.fromJson(json as Map<String, dynamic>),
                )
                .toList();

        return Right(tarefas);
      } catch (exception, stacktrace) {
        throw GetTarefasException(stacktrace, 'GetTarefa', exception);
      }
    } catch (e) {
      return Left(GetTarefasFailure());
    }
  }

  @override
  Future<Either<Failure, void>> postTarefa(TarefaEntity tarefa) async {
    final String endpoint = '/Tarefa';

    try {
      try {
        var url = Uri.parse('$baseUrl$endpoint');
        final result = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(tarefa.toJson()),
        );

        if (result.statusCode != 200) {
          throw PostTarefasException(
            StackTrace.current,
            'PostTarefa',
            "StatusCode: ${result.statusCode}",
          );
        }

        return Right(null);
      } catch (exception, stacktrace) {
        throw PostTarefasException(stacktrace, 'PostTarefa', exception);
      }
    } catch (e) {
      return Left(PostTarefasFailure());
    }
  }

  @override
  Future<Either<Failure, void>> putTarefa(TarefaEntity tarefa) async {
    try {
      await remoteDataSource.putTarefa(
        TarefaEntity(
          id: tarefa.id,
          titulo: tarefa.titulo,
          descricao: tarefa.descricao,
          criadoEm: tarefa.criadoEm,
          status: tarefa.status,
          concluidoEm: tarefa.concluidoEm,
        ),
      );
      return Right(null);
    } catch (e) {
      return Left(PutTarefasFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTarefa(int id) async {
    try {
      await remoteDataSource.deleteTarefa(id);
      return Right(null);
    } catch (e) {
      return Left(DeleteTarefasFailure());
    }
  }
}
