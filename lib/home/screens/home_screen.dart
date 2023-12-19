import 'package:flutter/material.dart';
import 'package:netflix/common/widgets/bottom_bar.dart';
import 'package:netflix/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: Center(
        child: Text(user.toJson()),
      ),
    );
  }
}
