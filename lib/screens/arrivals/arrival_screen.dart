import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../arrivals/body.dart';
import '../home/app_footer.dart';

class ArrivalScreen extends StatefulWidget {
  const ArrivalScreen({Key? key}) : super(key: key);

  @override
  _ArrivalScreenState createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        //title: Text("Expertlys"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        title: Row(
          children: [
            Text("New Arrivals"),
          ],
        ),
      ),
      body: Body(),
      bottomNavigationBar: AppFooter(indx: 3,),
    );
  }
}
