import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/pages/tarefa_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciamento de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Defina a página inicial como TarefaPage
      home: TarefaPage(),
    );
  }
}
