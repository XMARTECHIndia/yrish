import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/provider/cart_provider.dart';
import 'package:yris/screens/home/home_screen.dart';
import 'package:yris/screens/startup/login_screen.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? uid ;
  @override
  void initState() {
    super.initState();
    _loaddata();
  }

  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();
    //print(prefs.getString('id'));
    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        print(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Service App",
        theme: ThemeData(
          scaffoldBackgroundColor: myBackgroundColor,
          primaryColor: myPrimaryColor,
          textTheme: Theme
              .of(context)
              .textTheme
              .apply(bodyColor: myTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: HomeScreen(),
        home: (uid!="" ? HomeScreen(): LoginScreen()),
      );
      }),
    );
  }
}