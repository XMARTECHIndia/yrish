import 'package:badges/badges.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';
// import 'package:yris/models/Locations.model.dart';
import 'package:yris/models/Slider.model.dart';
import 'package:yris/screens/products/products_screen.dart';

import '../../models/Categories.model.dart';
import '../../models/Parentcat.model.dart';
import '../../models/Products.model.dart';
import '../product/product_screen.dart';


class Body extends StatefulWidget{
  const Body({Key? key, required this.catid}) : super(key: key);
  final String catid;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //List<SlidersModel> sliders = [];
  List<ProductsModel> products = [];
  List<ParentcatModel> parents =[];
  int? _value = 0;
  bool isSelected = false;
  // List<CategoriesModel> GNdetails = [];
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

    Dio().post("$baseUrl/get_pro_api_by_cat_id",
      data:{
        "pro_cat_id": widget.catid
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.products = productsModelFromJson(data.data.toString());
        getparent(products[0].proCatId);
        //products.sort((a, b) => int.parse(a.proOffer).compareTo(int.parse(b.proOffer)));
      });
    });

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
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child:
      Column(
        children: [
          // SizedBox(
          //   height: 50,
          //   child: ListView.builder(
          //     //var choice=["price a","price b"];
          //     physics: ClampingScrollPhysics(),
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 2,
          //     itemBuilder: (BuildContext context, int index) => ChoiceChip(
          //       label: Text("price"),
          //       selected: _value == index,
          //       onSelected: (bool selected){
          //         setState(() {
          //           //_value = selected ? index : null;
          //           _value = selected ? index : index;
          //            products.sort((a, b) => int.parse(a.proOffer).compareTo(int.parse(b.proOffer)));
          //           //isloading = true;
          //         });
          //       },
          //     ),
          //   ),
          // ),
          ListTile(
            leading: Text((parents.isNotEmpty ? parents[0].catName : ''),style: TextStyle(color: Colors.cyan, fontSize: 16.0),),
            trailing: ChoiceChip(
              label: Text("Price Low to High"),
              avatar: Icon(Icons.filter_list, color: Colors.white),

              selected: isSelected,
              onSelected: (bool value){
                isSelected = value;
                if(isSelected == true){
                  setState(() {
                    products.sort((a, b) => int.parse(a.proOffer).compareTo(int.parse(b.proOffer)));
                  });
                }else{
                  setState(() {
                    products.sort((b, a) => int.parse(a.proOffer).compareTo(int.parse(b.proOffer)));
                  });
                }
                //Do whatever you want when the chip is selected
              },
              selectedColor: Colors.deepOrange,
            ),
          ),
          Center(
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: products.length ,
              itemBuilder: (ctx, i) {
                var pros = products[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductScreen(tempproid:pros.proId)),
                    );
                  },
                  child: Card(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children:[
                                  Expanded(
                                  child: Image.network(
                                    "$baseUrl/assets/productimg/"+products[i].proImg,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child:Badge(
                                        toAnimate: false,
                                        shape: BadgeShape.square,
                                        badgeColor: (products[i].inOffer == "1" ? Colors.green : Colors.cyan),
                                        borderRadius: BorderRadius.circular(2),
                                        badgeContent: Text((products[i].inOffer == "1" ? "IN OFFER" : "BESTSELLER"), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                      )
                                  ),
                                ]
                              ),
                              Text(
                                pros.proName,
                                style: const TextStyle(
                                  fontSize: 13,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              products[i].upcoming == "1" ? Text("Coming Soon", style: TextStyle(color: Colors.blue),):Row(
                                children: [
                                  Text(
                                    (products[i].inOffer == "1" ? "₹"+pros.proOffer : "₹"+pros.proSell),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                                    child: (products[i].inOffer == "1" ? Text("₹"+pros.proSell,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 13,color: Colors.black38,fontWeight: FontWeight.bold,)) : Text("")),
                                  ),
                                ],
                              ),
                              // CountDownText(
                              //   due: DateTime.parse("2023-01-01 00:00:00"),
                              //   finishedText: "Done",
                              //   showLabel: true,
                              //   longDateName: true,
                              //   daysTextLong: " Days ",
                              //   hoursTextLong: " h ",
                              //   minutesTextLong: " m ",
                              //   secondsTextLong: " s Left",
                              //   style: TextStyle(color: Colors.blue, fontSize: 12),
                              // )
                              // (products[i].proAvailable == "0" ? Text('Currently Unavailable',style: TextStyle(color: Colors.red),): Text("")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 240,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
