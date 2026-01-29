import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/controller/ui/MovieScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
    runApp(
    const ProviderScope( 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Paradise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieScreen(),
    );
  }
}