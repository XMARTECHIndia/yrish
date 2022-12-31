import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../main.dart';


class AppHeader extends StatelessWidget {
//   const AppHeader({Key? key}) : super(key: key);
//
//   @override
//   _AppHeaderState createState() => _AppHeaderState();
// }
//
// class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.cyan,
      title: Row(
        children: [
          //Text("Yris"),
          Image.asset(
            "images/yrislgo.png",
            fit: BoxFit.fitWidth,
            height: 50,
            width: 50,
          ),
          Spacer(),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: MediaQuery.of(context).size.width-90,
              //height: 200,
              color: Colors.cyan,
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                        // );
                      },
                      icon: Icon(Icons.favorite)
                  ),
                  // IconButton(
                  //     onPressed: () async {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                  //       // );
                  //     },
                  //     icon: Icon(Icons.perm_phone_msg)
                  // ),
                  IconButton(
                      onPressed: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                        // );
                      },
                      icon: Icon(Icons.notifications)
                  ),
                  Badge(
                    badgeContent: Text('3'),
                    child: Icon(Icons.shopping_cart),
                  ),
                  // IconButton(
                  //     onPressed: () async {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                  //       // );
                  //     },
                  //     icon: Icon(Icons.shopping_cart)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      //iconTheme: IconThemeData(color: Colors.green,),
    );
   }
}
class CustomClipPath extends CustomClipper<Path> {
  var radius=5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.height , size.height);
    //path.quadraticBezierTo(0, size.width, 50, size.width);
    path.lineTo(size.width , size.height);
    //path.quadraticBezierTo(0, size.width, 50, size.width);
    path.lineTo(size.width , 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}