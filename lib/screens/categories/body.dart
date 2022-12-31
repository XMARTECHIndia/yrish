import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';
import 'package:yris/screens/categories/vt_category_screen.dart';
import '../../models/Categories.model.dart';
import '../products/products_screen.dart';
import 'sp_category_screen.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //List<SlidersModel> sliders = [];
  List<CategoriesModel> VTdetails = [];
  List<CategoriesModel> BLdetails = [];
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

    Dio().post("$baseUrl/category_api_parentcat",
      data:{
        "parentcat": "Vision testing"
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.VTdetails = categoriesModelFromJson(data.data.toString());
      });
    });

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
        this.BLdetails = categoriesModelFromJson(data.data.toString());
      });
    });

    Dio().post("$baseUrl/category_api_parentcat",
      data:{
        "parentcat": "General"
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.GNdetails = categoriesModelFromJson(data.data.toString());
      });
    });
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
            child: GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (150 / 80),
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VTCategoryScreen()),
                        );
                      },
                  child: Card(
                    color: Colors.cyan,
                    child: Container(
                      // height: 200,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.visibility,size: 50.0,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Vision Testing",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SPCategoryScreen()),
                    );
                  },
                  child: Card(
                    color: Colors.cyan,
                    child: Container(
                      // height: 200,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              RotatedBox(
                                quarterTurns: 0,
                                child: Icon(Icons.miscellaneous_services,size: 50.0,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Service Parts",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: GNdetails.length ,
              itemBuilder: (ctx, i) {
                var cats = GNdetails[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
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
                                child: Image.network(
                                  "$baseUrl/assets/categoryimg/"+GNdetails[i].catImg,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Center(
                                child: Text(
                                  cats.catName,
                                  style: const TextStyle(
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
