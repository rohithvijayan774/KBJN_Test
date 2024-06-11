import 'package:flutter/material.dart';
import 'package:kjbn_test/controller/controller.dart';
import 'package:kjbn_test/view/home_screen.dart';
import 'package:kjbn_test/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(
          create: (context) => Controller(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KJBN Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
