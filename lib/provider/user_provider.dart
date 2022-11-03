import 'package:flutter/material.dart';
import 'package:promina_task/model/user.dart';

class UserProvider with ChangeNotifier{
  User? _user;

  setUser(user){
    _user = user;
    print('user ff: ${user.name}');
    notifyListeners();
  }

  User getUser(){
    return _user!;
  }

  String getToken(){
    return _user!.token;
  }

  void removeUser(){
     _user = null;
     notifyListeners();
  }
}