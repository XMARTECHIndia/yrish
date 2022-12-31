import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yris/screens/products/body.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../models/Parentcat.model.dart';
import '../categories/parent_category_screen.dart';
import '../home/app_footer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.tempcatid}) : super(key: key);
  final String tempcatid;
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ParentcatModel> parents =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getparent(widget.tempcatid);
  }
  getparent(id){
    Dio().post("$baseUrl/parent_cat_api",
      data:{
        "cat_id": id
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.parents = parentcatModelFromJson(data.data.toString());
        //products.sort((a, b) => int.parse(a.proOffer).compareTo(int.parse(b.proOffer)));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
              // Navigator.pushReplacement(context,MaterialPageRoute(
              // builder: (BuildContext context) => ParentCategoryScreen())),
        ),
        title: Row(
          children: [
            //Icon(Icons.category),
            //Text("${widget.tempparent}: ${widget.tempcat}"),
            Text("${(parents.isNotEmpty ? parents[0].catName : '')} Collections"),
          ],
        ),
      ),
      body: Body(catid:widget.tempcatid),
      bottomNavigationBar: AppFooter(indx: 1,),
    );
  }
}
