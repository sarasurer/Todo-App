import 'package:flutter/material.dart';
import 'package:todo_flutter/edit_page.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Cervi Todo App",
      home: HomeScreen(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
    );
  }
}
