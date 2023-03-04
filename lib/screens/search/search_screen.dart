import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../models/Search.model.dart';
import '../product/product_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<SearchModel> products = [];
  bool isSelected = false;
  bool isloading = false;
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
  }
  searchit(keyword){
    isloading = true;
    Dio().post("$baseUrl/searched_products",
      data:{
        "keyword": keyword
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        products = searchModelFromJson(data.data.toString());
        isloading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        title: Container(
          height: 38,
          child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    searchit(value);
                  },
                  decoration: const InputDecoration(
                    //floatingLabelBehavior:FloatingLabelBehavior.never,
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    //labelText: 'Search The Product You Need...',
                    hintText: 'Search The Product You Need...',
                  contentPadding: EdgeInsets.only(top: 10.0, left: 10.0),
                  //labelStyle: TextStyle(color: Colors.black),
                  // suffix:IconButton(
                  //   onPressed: (){
                  //     searchit(searchController.text);
                  //   },
                  //   icon: Icon(Icons.search),
                  //   color: Colors.cyan,
                  //   //padding: EdgeInsets.only(top: 10.0),
                  // ),
          ),
      ),
        ),
      ),
      body: SingleChildScrollView(
        child: isloading==true ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: CircularProgressIndicator(color: Colors.cyan,),
              ),
              Text(" Loading Products..."),
            ],
          ),
        ):Column(
          children: [

            ListTile(
              leading: Text("Searched Products ",style: TextStyle(color: Colors.cyan, fontSize: 16.0),),
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
      ),
    );
  }
}
