import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:promina_task/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';

class AuthenticationService{
  static Future<bool> login(context, {required String email, required String password}) async {
    const uri = 'https://technichal.prominaagency.com/api/auth/login';
    http.Response result = await http.post(Uri.parse(uri), body: json.encode(
        {
          'email': email,
          'password': password
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      Provider.of<UserProvider>(context, listen: false).setUser(User.fromJson(jsonResponse));
      return true;
    }
    return false;
  }

  static logout(ctx){
    Provider.of<UserProvider>(ctx, listen: false).removeUser();
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginPage()));
  }
}