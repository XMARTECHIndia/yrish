import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yris/screens/categories/body.dart';
import 'package:yris/screens/home/app_footer.dart';
import '../../../main.dart';

class ParentCategoryScreen extends StatefulWidget {
  const ParentCategoryScreen({Key? key}) : super(key: key);

  @override
  _ParentCategoryScreenState createState() => _ParentCategoryScreenState();
}

class _ParentCategoryScreenState extends State<ParentCategoryScreen> {
  String? uid ;
  @override
  void initState() {
    super.initState();
    _loaddata();
  }

  void _loaddata() async {
    // final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      // setState(() {
      //   uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
      //   getuserdata();
      // });
    }
  }
  getuserdata(){
  }
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
          onPressed: () =>Navigator.pop(context,true),
              // Navigator.pushReplacement(context,MaterialPageRoute(
              // builder: (BuildContext context) => MyApp())),
        ),
        title: Row(
          children: [
            Text("Product Categories"),
          ],
        ),
      ),
      body: Body(),
      bottomNavigationBar: AppFooter(indx: 1,),
    );
  }
}
