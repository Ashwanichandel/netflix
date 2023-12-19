import 'package:flutter/material.dart';
import 'package:netflix/common/widgets/bottom_bar.dart';
import 'package:netflix/features/auth/screens/auth_screen.dart';
import 'package:netflix/provider/user_provider.dart';
import 'package:netflix/services/auth_service.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService authService = AuthService();
  bool lodded = false;
  @override
  void initState() {
    super.initState();

    authService.GetUserData(context).then((value) => setState(() {
          lodded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: lodded
            ? Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? const BottomBar()
                : const AuthScreen()
            : CircularProgressIndicator());
  }
}
