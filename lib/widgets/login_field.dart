import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  LoginField(
      {super.key,
      required this.dSize,
      required TextEditingController controller,
      this.isPassword = false})
      : _controller = controller;

  final Size dSize;
  final TextEditingController _controller;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dSize.width * 0.5,
      child: TextFormField(
        controller: _controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            label: Text(
              isPassword ? 'password' : 'user name',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(50)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(50)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(50))),
        validator: (val) {
          if (_controller.text.isEmpty) {
            return isPassword ? 'please type password' : 'please type username';
          }
        },
      ),
    );
  }
}
