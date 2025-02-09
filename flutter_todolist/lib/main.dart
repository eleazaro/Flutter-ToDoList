import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/usecases/delete_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/get_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/post_tarefas.dart';
import 'package:flutter_todolist/domain/usecases/put_tarefas.dart';
import 'package:provider/provider.dart';
import 'core/data/datasources/tarefa_remote_datasource_impl.dart';
import 'core/data/repositories/tarefa_repository_impl.dart';
import 'core/network/api_client.dart';
import 'presentation/controllers/tarefa_controller.dart';
import 'presentation/pages/tarefa_page.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = TarefaRemoteDataSourceImpl(apiClient);
  final repository = TarefaRepositoryImpl(remoteDataSource: remoteDataSource);

  final getTarefasUseCase = GetTarefasUseCase(repository);
  final postTarefaUseCase = PostTarefaUseCase(repository);
  final putTarefaUseCase = PutTarefaUseCase(repository);
  final deleteTarefaUseCase = DeleteTarefaUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TarefaController>(
          create:
              (context) => TarefaController(
                getTarefasUseCase: getTarefasUseCase,
                postTarefaUseCase: postTarefaUseCase,
                putTarefaUseCase: putTarefaUseCase,
                deleteTarefaUseCase: deleteTarefaUseCase,
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TarefaPage());
  }
}
