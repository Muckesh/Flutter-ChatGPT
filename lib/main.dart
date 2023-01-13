import 'package:chatgpt/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.montserratTextTheme((Theme.of(context).textTheme)),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}
