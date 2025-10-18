import 'package:app_distribuidora/pages/home_massage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Massagem',
      theme: ThemeData(
            primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: FlorDeLotusApp(), // aguardando a classe
    );
  }
}

