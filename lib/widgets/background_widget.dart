import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key, required this.image}) : super(key: key);
  final image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
