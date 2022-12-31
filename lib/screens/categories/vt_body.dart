import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';
import '../../models/Categories.model.dart';
import '../products/body.dart';
import '../products/products_screen.dart';

class VTBody extends StatefulWidget{
  @override
  _VTBodyState createState() => _VTBodyState();
}

class _VTBodyState extends State<VTBody> {

  List<CategoriesModel> VTdetails = [];
  List<CategoriesModel> BLdetails = [];
  List<CategoriesModel> GNdetails = [];
  // String pcat= "";
  String catn= "";
  String catid= "";
  int? _value = 0;
  bool isloading = true;
  int selectedCard = -1;
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

    // Dio().post("$baseUrl/category_api_parentcat",
    //   data:{
    //     "parentcat": "Binocular Loupe"
    //   },
    //   options: Options(
    //     responseType: ResponseType.plain,
    //   ),
    // ).then((data){
    //   setState(() {
    //     //print(data.data);
    //     this.BLdetails = categoriesModelFromJson(data.data.toString());
    //   });
    // });

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
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              itemCount: VTdetails.length ,
              itemBuilder: (ctx, i) {
                var cats = VTdetails[i];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ProductsScreen(tempparent:cats.parentCat,tempcat:cats.catName, tempcatid:cats.catId)),
                    // );
                    setState(() {
                      isloading = true;
                      selectedCard = i;
                    });
                    loadproducts(cats.catName,cats.catId);
                  },
                  child: Card(
                    color: selectedCard == i ? Colors.cyan.shade100 : Colors.white,
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
                                  "$baseUrl/assets/categoryimg/"+VTdetails[i].catImg,
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
          // Center(
          //   child: GridView.builder(
          //     physics: ScrollPhysics(),
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //     ),
          //     itemCount: VTdetails.length ,
          //     itemBuilder: (ctx, i) => ChoiceChip(
          //       label: Text(VTdetails[i].catName),
          //       selected: _value == i,
          //       onSelected: (bool selected){
          //         setState(() {
          //           //_value = selected ? index : null;
          //           _value = selected ? i : i;
          //           isloading = true;
          //         });
          //         loadproducts(VTdetails[i].catName,VTdetails[i].catId);
          //         //makelist(alllocations[0].location,index);
          //
          //       },
          //     ),
          //   ),
          // ),
          isloading == true ?
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            alignment: Alignment.center,
            child: SizedBox(
              height: 45,
              width: 200,
              child: Text(""),
            ),
          ) : Body(catid:catid),
        ],
      ),

    );
  }

 loadproducts(String catName, String catId,) {
   Future.delayed(Duration(milliseconds: 100)).then((_) {
     setState(() {
       isloading = false;
       catn=catName;
       catid = catId;

     });
   });


 }
}
