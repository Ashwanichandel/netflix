import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:netflix/constant/utils.dart';

bool httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  // required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      return true;
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      return false;
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      return false;
      break;
    default:
      showSnackBar(context, response.body);
      return false;
  }
}
