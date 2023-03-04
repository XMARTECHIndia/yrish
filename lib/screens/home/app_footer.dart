import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yris/screens/order/myorders_screen.dart';

import '../../../main.dart';
import '../arrivals/arrival_screen.dart';
import '../categories/parent_category_screen.dart';
import '../profile/profile_screen.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key, required this.indx}) : super(key: key);
  final int indx;

  @override
  _AppFooterState createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.indx;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0){
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (BuildContext context) => MyApp()));
    }
    if(index==1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParentCategoryScreen()),
      );
    }
    if(index==2){
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (BuildContext context) => Profile_Screen()));
    }
    if(index==3){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArrivalScreen()),
      );
    }
    if(index==4){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyOrderScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_module),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rocket_launch),
          label: 'New Arrival',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'My Orders',
        ),
      ],
      currentIndex: _selectedIndex == -1 ? 0: _selectedIndex,
      //selectedItemColor: Colors.amber[800],

      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.cyan,
      selectedItemColor: _selectedIndex == -1 ? Colors.white60 : Colors.white,
      unselectedItemColor: Colors.white60,
    );
  }
}
