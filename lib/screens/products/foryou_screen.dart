import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../models/Foryou.model.dart';
import '../home/app_footer.dart';
import '../product/product_screen.dart';

class ForyouScreen extends StatefulWidget {
  const ForyouScreen({Key? key}) : super(key: key);

  @override
  _ForyouScreenState createState() => _ForyouScreenState();
}

class _ForyouScreenState extends State<ForyouScreen> {
  List<ForyouModel> products = [];
  int? _value = 0;
  bool isSelected = false;
  String? uid ;
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
    _loaddata();
  }
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        getproductdata();
      });
    }
  }
  getproductdata(){
    Dio().post("$baseUrl/products_api_with_occupation",
      data:{
        "uid": uid,
        "limit": 0,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        this.products = foryouModelFromJson(data.data.toString());
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
        //title: Text("Expertlys"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        title: Row(
          children: [
            Text("Your Choicefull Collection"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            ListTile(
              leading: Text("Products You May Like",style: TextStyle(color: Colors.cyan, fontSize: 16.0),),
              trailing: ChoiceChip(
                label: Text("Price Low to High"),
                avatar: Icon(Icons.filter_list, color: Colors.white),

                selected: isSelected,
                onSelected: (bool value){
                  isSelected = value;
                  if(isSelected == true){
                    setState(() {
                      products.sort((a, b) => int.parse(a.proSell).compareTo(int.parse(b.proSell)));
                    });
                  }else{
                    setState(() {
                      products.sort((b, a) => int.parse(a.proSell).compareTo(int.parse(b.proSell)));
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
                                            badgeColor: (products[i].inOffer == "1" ? Colors.green : Colors.blue),
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
                                Row(
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
      ),
      bottomNavigationBar: AppFooter(indx: -1,),
    );
  }
}
