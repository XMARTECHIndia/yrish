import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yris/constants.dart';
import 'package:yris/screens/cart/cart_screen.dart';
import 'package:yris/screens/home/body.dart';
import 'package:yris/screens/home/app_footer.dart';

import '../../database/db_helper.dart';
import '../../provider/cart_provider.dart';
import '../notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   // label: const Text(''),
      //   child: const Icon(Icons.support_agent),
      //   backgroundColor: Colors.pink,
      // ),
      bottomNavigationBar: AppFooter(indx: 0,),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      //title: Text("Expertlys"),
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
          // ClipPath(
          //   clipper: CustomClipPath(),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width-90,
          //     //height: 200,
          //     color: Colors.cyan,
          //     child: Row(
          //       children: [
          //         Spacer(),
          //
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationScreen()),
              // );
            },
            icon: Icon(Icons.favorite)
        ),
        IconButton(
            onPressed: () async {
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationScreen()),
                      );
            },
            icon: Icon(Icons.notifications)
        ),
        // GestureDetector(
        //   onTap: (){
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => NotificationScreen()),
        //     );
        //   },
        //   child: Badge(
        //     position: BadgePosition.topEnd(top: 0, end: -6),
        //     badgeContent: Text('3',style: const TextStyle(color: Colors.white,)),
        //     child: Icon(Icons.notifications),
        //   ),
        // ),
        SizedBox(width: 5),
        Badge(
          badgeContent: Consumer<CartProvider>(
            builder: (context, value, child) {
              return Text(
                value.getCounter().toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
          position: const BadgePosition(start: 30, bottom: 30),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart, ),
          ),
        ),
        SizedBox(width: 15),
      ],
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