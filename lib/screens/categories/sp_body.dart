import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';
import '../../models/Categories.model.dart';
import '../products/products_screen.dart';

class SPBody extends StatefulWidget{
  @override
  _SPBodyState createState() => _SPBodyState();
}

class _SPBodyState extends State<SPBody> {
  //List<SlidersModel> sliders = [];
  List<CategoriesModel> VTdetails = [];
  List<CategoriesModel> SPdetails = [];
  List<CategoriesModel> GNdetails = [];
  //bool loaded = false;
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Dio().post("$baseUrl/category_api_parentcat",
    //   data:{
    //     "parentcat": "Vision testing"
    //   },
    //   options: Options(
    //     responseType: ResponseType.plain,
    //   ),
    // ).then((data){
    //   setState(() {
    //     //print(data.data);
    //     this.VTdetails = categoriesModelFromJson(data.data.toString());
    //   });
    // });

    Dio().post("$baseUrl/category_api_parentcat",
      data:{
        "parentcat": "Binocular Loupe"
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.SPdetails = categoriesModelFromJson(data.data.toString());
      });
    });

    // Dio().post("$baseUrl/category_api_parentcat",
    //   data:{
    //     "parentcat": "General"
    //   },
    //   options: Options(
    //     responseType: ResponseType.plain,
    //   ),
    // ).then((data){
    //   setState(() {
    //     //print(data.data);
    //     this.GNdetails = categoriesModelFromJson(data.data.toString());
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child:
      Column(
        children: [

          Center(
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: SPdetails.length ,
              itemBuilder: (ctx, i) {
                var cats = SPdetails[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsScreen(tempcatid:cats.catId)),
                    );
                  },
                  child: Card(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                // child: Image.asset(
                                //   "images/yrislgo.png",
                                //   fit: BoxFit.fill,
                                // ),
                                child: Image.network(
                                  "$baseUrl/assets/categoryimg/"+SPdetails[i].catImg,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Center(
                                child: Text(
                                  cats.catName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
