// ignore_for_file: unnecessary_late
import 'package:d/product/router/router.dart';
import 'package:d/view/auth/signup/model/sign_up_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModelProvider>(
          create: (BuildContext context) => UserModelProvider(
              age: '',
              email: '',
              fullName: '',
              uid: '',
              dietationId: '',
              diseases: '',
              gender: '',
              height: '',
              note: '',
              profilePic: '',
              targetWeight: '',
              weight: ''),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

late final appRoutes = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: appRoutes.router);
  }
}
