import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/services/delete_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/get_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/post_tarefas_service.dart';
import 'package:flutter_todolist/domain/services/put_tarefas_service.dart';
import 'package:provider/provider.dart';
import 'data/datasources/tarefa_remote_datasource_impl.dart';
import 'data/repositories/tarefa_repository_impl.dart';
import 'core/network/api_client.dart';
import 'presentation/controllers/tarefa_controller.dart';
import 'presentation/view/tarefa_page.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = TarefaRemoteDataSourceImpl(apiClient);
  final repository = TarefaRepositoryImpl(remoteDataSource: remoteDataSource);

  final getTarefasUseCase = GetTarefasService(repository);
  final postTarefaUseCase = PostTarefaService(repository);
  final putTarefaUseCase = PutTarefaService(repository);
  final deleteTarefaUseCase = DeleteTarefaService(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TarefaController>(
          create:
              (context) => TarefaController(
                getTarefasService: getTarefasUseCase,
                postTarefaService: postTarefaUseCase,
                putTarefaService: putTarefaUseCase,
                deleteTarefaService: deleteTarefaUseCase,
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
