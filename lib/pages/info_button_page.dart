import 'package:flutter/material.dart';

class InfoButtonPage extends StatefulWidget {
  const InfoButtonPage({super.key});

  @override
  State<InfoButtonPage> createState() => _InfoButtonPageState();
}

class _InfoButtonPageState extends State<InfoButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.keyboard_arrow_down_sharp, size: 30,),
                  color: Colors.white,
                ),
                Text("Kitty Cat Info", style: TextStyle(color: Colors.white),),
                SizedBox(width: 50,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
