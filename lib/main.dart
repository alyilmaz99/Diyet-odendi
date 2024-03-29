// ignore_for_file: unnecessary_late
import 'package:d/product/router/router.dart';
import 'package:d/view/auth/signup/model/sign_up_model.dart';
import 'package:d/view/home/create/chat/model/chat_model.dart';
import 'package:d/view/home/create/date/model/date_model.dart';
import 'package:d/view/home/create/eating/model/eating_model.dart';
import 'package:d/view/home/recipe/model/recipe_model.dart';
import 'package:d/view/home/settings/model/settings_model.dart';
import 'package:d/view/home/target/model/diyetList_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FoodsModel>(
          create: (BuildContext context) => FoodsModel(
            listFoodNames: [],
            menuItems1: [],
            menuItems2: [],
            selectedValue2: '0',
            selectedValue: '0',
            foodsCalorie: '',
            foodsName: '',
            foodsTitles: [],
            object: [],
            object2: [],
          ),
        ),
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
              chatId: '',
              profilePic: '',
              targetWeight: '',
              weight: ''),
        ),
        ChangeNotifierProvider<DateModel>(
          create: (BuildContext context) => DateModel(),
        ),
        ChangeNotifierProvider<SettingsModel>(
          create: (BuildContext context) => SettingsModel(),
        ),
        ChangeNotifierProvider<ChatModel>(
          create: (BuildContext context) => ChatModel(),
        ),
        ChangeNotifierProvider<RecipeModel>(
          create: (BuildContext context) => RecipeModel(),
        ),
        ChangeNotifierProvider<DiyetListModel>(
          create: (BuildContext context) => DiyetListModel(),
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
