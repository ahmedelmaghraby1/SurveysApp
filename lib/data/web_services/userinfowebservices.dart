import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants/strings.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWebServices {
  Future savepref(String variable, String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(variable, "$token");
  }

  Future getuserinfo(
      String username, String password, BuildContext context) async {
    try {
      Uri loginbaseurl = Uri.parse(
          "${enigma_baseurl}/${login_endpoint}?ServiceKey=${services_key}&u=${username}&p=${password}");

      Response response = await get(
        loginbaseurl,
      );
      print(response.statusCode);
      switch (jsonDecode(response.body)['Success']) {
        case true:
          {
            final authenticationtoken = response.headers['authorization'];

            print(jsonDecode(response.body)['Success']);

            return jsonDecode(response.body);
          }
        case false:
          {
            print(jsonDecode(response.body)['Success']);
            return jsonDecode(response.body)['Success'];
          }
      }
    } catch (e) {
      print("$e");
    }
  }

  void sendEmail(String userEmail) async {
    final smtpServer =
        gmail('ahmedelmaghraby2014@gmail.com', 'jcayduuulchovsgw');
    String recipientEmail = 'ahmedelmaghraby796@gmail.com';
    String emailBody = 'the user ${userEmail} forgot his password password';

    final message = Message()
      ..from = Address(userEmail)
      ..recipients.add(recipientEmail)
      ..subject = 'Hello from Flutter'
      ..text = emailBody;

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
