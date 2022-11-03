import 'package:promina_task/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pages/gallery_page.dart';
import 'pages/login_page.dart';
import 'provider/gallery_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> UserProvider()),
        ChangeNotifierProvider(create: (context)=> GalleryProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
