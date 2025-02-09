import 'package:flutter/material.dart';
import 'package:flutter_todolist/core/data/datasources/tarefa_remote_datasource_impl.dart';
import 'package:flutter_todolist/core/data/repositories/tarefa_repository_impl.dart';
import 'package:flutter_todolist/core/network/api_client.dart';
import 'package:flutter_todolist/presentation/controllers/tarefa_controller.dart';
import 'package:flutter_todolist/presentation/pages/tarefa_page.dart';
import 'package:provider/provider.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = TarefaRemoteDataSourceImpl(apiClient);
  final repository = TarefaRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TarefaController>(
          create: (context) => TarefaController(repository),
        ),
      ],
      child: MyApp(),
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
