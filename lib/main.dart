import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_final/frontend/login_page.dart';
import 'package:provider/provider.dart';
import 'backend/calculation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => calculate(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'DMSans', brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        home: Login(),
        // home: HomePage(),
      ),
    );
  }
}
