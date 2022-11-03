import 'package:flutter/material.dart';

class PickImageWidget extends StatelessWidget {
  PickImageWidget(
      {Key? key,
      this.isByCamera = false,
      required this.function,
      required this.title})
      : super(key: key);

  final Function function;
  final String title;
  bool isByCamera;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
          backgroundColor: isByCamera ? Colors.green[50] : Colors.pink[50],
          elevation: 0,
          textStyle: const TextStyle(fontSize: 15),
          // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          fixedSize: const Size(120, 50)),
      child: Row(
        children: [
          SizedBox(
            width: 20,
              height: 20,
              child: isByCamera
                  ? Image.asset('assets/images/camera.png')
                  : Image.asset('assets/images/gallery.png')),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
