import 'package:flutter/material.dart';
import 'package:resepmakanan_5a/ui/home_screen.dart';
import 'package:resepmakanan_5a/ui/login_screen.dart';
import 'package:resepmakanan_5a/ui/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=> LoginScreen(),
        '/register': (context)=> RegisterScreen(),
        '/home': (context)=> HomeScreen()
      },
    );
  }
}