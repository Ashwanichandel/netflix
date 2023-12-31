import 'package:flutter/material.dart';
import 'package:netflix/common/widgets/bottom_bar.dart';
import 'package:netflix/constant/global_variables.dart';
import 'package:netflix/features/auth/screens/auth_screen.dart';
import 'package:netflix/home/screens/home_screen.dart';
import 'package:netflix/provider/user_provider.dart';
import 'package:netflix/router.dart';
import 'package:netflix/services/auth_service.dart';
import 'package:netflix/widgets/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazon clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: MainScreen());
  }
}
