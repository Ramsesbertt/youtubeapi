import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Importa HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube API App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(), // Muestra directamente HomePage
      debugShowCheckedModeBanner: false,
    );
  }
}
