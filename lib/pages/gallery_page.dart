import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:promina_task/provider/user_provider.dart';
import 'package:promina_task/sevices/gallery_service.dart';
import 'package:provider/provider.dart';

import '../provider/gallery_provider.dart';
import '../sevices/authintication_service.dart';
import '../widgets/background_widget.dart';
import '../widgets/pick_image_widget.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  List images = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getImages();
  }

  getImages() async{
    setState(() {
      isLoading = true;
    });
    await GalleryService.getGallery(context);
    images = Provider.of<GalleryProvider>(context, listen: false).getImages();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false).getUser();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(image: 'assets/images/gallery–background.png'),
          SafeArea(
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text('WELCOME ${user.name}', style: TextStyle(fontSize: 18),),
                          ),
                          Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/person.jpg'),
                                fit: BoxFit.cover
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildElevatedButton(IconlyBold.arrow_left_square, 'log out', Colors.red, ()=>AuthenticationService.logout(context)),
                        buildElevatedButton(IconlyBold.arrow_up_square, 'upload', Colors.yellow, ()=> showUpload(context)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: isLoading ? CircularProgressIndicator() : GridView.builder(
                        shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                          ),
                        itemCount: images.length,
                        itemBuilder: (context, index)=>Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: FancyShimmerImage(
                                imageUrl: images[index],
                                boxFit: BoxFit.fill,
                                height: 100,
                              ),
                            ),
                          )
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton(IconData icon, String title, Color color, Function function) {
    return ElevatedButton(
                  onPressed: () => function(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                      elevation: 0,
                      textStyle:
                      const TextStyle(fontSize: 15),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15))),
                  child: Row(
                    children: [
                      Icon(icon, color: color,),
                      const SizedBox(width: 5,),
                      Text(
                          title,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
  }

  showUpload(context){
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.white70,
        contentPadding: EdgeInsets.all(30),
        content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PickImageWidget(title: 'GALLERY', function: ()=>GalleryService.pickImage(context).then((value) => setState(() {})),),
              PickImageWidget(title: 'CAMERA', function: ()=>GalleryService.pickImage(context, isByCamera: true).then((value) => setState(() {})), isByCamera: true,),
            ],
          ),
        ),
      ),
    );
  }
}