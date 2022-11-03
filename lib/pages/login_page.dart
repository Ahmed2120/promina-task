import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:promina_task/pages/gallery_page.dart';
import 'package:promina_task/provider/user_provider.dart';
import 'package:promina_task/sevices/authintication_service.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../sevices/gallery_service.dart';
import '../widgets/background_widget.dart';
import '../widgets/glass_widget.dart';
import '../widgets/login_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File? image;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(image: 'assets/images/login_background.png',),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: dSize.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: dSize.width * 0.5,
                        child: Text(
                          'My Gallery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: dSize.width < 350 ? 30 : 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        )),
                    GlassWidget(
                      dSize: dSize,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: dSize.width * 0.1),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'LOG IN',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black45),
                              ),
                              LoginField(dSize: dSize, controller: _emailController),
                              LoginField(dSize: dSize, controller: _passwordController, isPassword: true,),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : () => submit(context),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      textStyle:
                                      const TextStyle(fontSize: 20),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15))),
                                  child: const Text(
                                      'SUBMIT',
                                      style:TextStyle(color: Colors.white, )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  submit(ctx) async{
    if(!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);

    final success = await AuthenticationService.login(ctx, email: _emailController.text, password: _passwordController.text);
    setState(() => isLoading = false);

    if (success){
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context)=> const GalleryPage()));
    }
    else{
      showDialog(
          context: ctx,
        barrierColor: Colors.transparent,
          builder: (_) => AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white24,
            title: const Text('Incorrect Details!'),
            content: const Text('Please try again'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
      );
    }
  }
}