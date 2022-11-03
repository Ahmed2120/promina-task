import 'package:flutter/material.dart';

class GalleryProvider with ChangeNotifier{
  List? _images;

  setImage(img){
    _images!.add(img);
    notifyListeners();
  }

  setImages(List imgs){
    _images = imgs;
    print('immmmm ${_images}');
    notifyListeners();
  }

  List getImages(){
    print(_images);
    return _images!;
  }

}