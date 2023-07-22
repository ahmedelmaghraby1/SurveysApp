import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/data/models/User.dart';
import 'package:graduation_project/data/web_services/userinfowebservices.dart';

class AuthRepository {
  final AuthWebServices authWebServices;

  AuthRepository(this.authWebServices);
  Future getuserinfo(
      String username, String password, BuildContext context) async {
    final ui = await authWebServices.getuserinfo(username, password, context);
    if (ui == false) {
      return false;
    } else {
      User userinfo = User.fromJson(ui);
      return userinfo;
    }
  }
}
