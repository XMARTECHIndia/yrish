import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yris/screens/categories/parent_category_screen.dart';
import 'package:yris/screens/home/app_footer.dart';
import '../../../main.dart';
import 'sp_body.dart';

class SPCategoryScreen extends StatefulWidget {
  const SPCategoryScreen({Key? key}) : super(key: key);

  @override
  _SPCategoryScreenState createState() => _SPCategoryScreenState();
}

class _SPCategoryScreenState extends State<SPCategoryScreen> {
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
        //title: Text("yris"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => ParentCategoryScreen())),
        ),
        title: Row(
          children: [
            Text("Service Parts"),
          ],
        ),
      ),
      body: SPBody(),
      bottomNavigationBar: AppFooter(indx: 1,),
    );
  }
}
