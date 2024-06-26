import 'package:flutter/material.dart';
import 'package:office_finances_web/components/create_pdf.dart';

import 'screens/manager.dart';
import 'screens/transations.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Office Finances',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 55, 44, 201)),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Adicione aqui os idiomas que você quer suportar
      ],
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/gerar_pdf': (context) => CreatePdf(),
        '/transations': (context) => const Dashboard(),
        '/manager': (context) => const Manager(),
      },
    );
  }
}
