import 'package:flutter/material.dart';
import '../models/photos_res.dart';
import 'info_button_page.dart';

class DetailsPage extends StatefulWidget {
  // final PhotosRes photos;
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoButtonPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.3,
                    image: AssetImage(
                      'assets/images/cat.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigate to the new page with slide transition
                        Navigator.of(context).push(_createRoute());
                      },
                      icon: Icon(Icons.info_outline_rounded),
                      color: Colors.white,
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text("Kitty Cat", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.ios_share_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            height: 50,
                            width: 50,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
