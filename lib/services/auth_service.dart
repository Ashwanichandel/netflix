import 'dart:convert';
import 'dart:developer';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix/common/widgets/bottom_bar.dart';
import 'package:netflix/constant/error_handlimg.dart';
import 'package:netflix/constant/global_variables.dart';
import 'package:netflix/constant/utils.dart';
import 'package:netflix/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> sigUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: ' ',
        //type: '',
        token: '',
      );
      // print("hello jk");
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      log(res.body);
      bool result = httpErrorHandle(
        response: res,
        context: context,
      );
      if (result) {
        showSnackBar(
            context, 'Account created ! Login with the same credential');
        return true;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return false;
  }

  Future<bool> sigInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    print(context);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
      bool result = httpErrorHandle(
        response: res,
        context: context,
      );
      if (result) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);

        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        return true;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
    return false;
  }

  Future<void> GetUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //to get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
