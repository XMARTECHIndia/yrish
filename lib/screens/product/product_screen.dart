import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../constants.dart';
import 'package:yris/database/db_helper.dart';
import '../../models/Cart.model.dart';
import '../../models/Parentcat.model.dart';
import '../../models/Product.model.dart';
import '../../models/Slider.model.dart';
import '../../provider/cart_provider.dart';
import '../categories/parent_category_screen.dart';
import 'package:flutter_html/flutter_html.dart';

import '../categories/vt_category_screen.dart';
import '../home/app_footer.dart';
import '../products/products_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.tempproid}) : super(key: key);
  final String tempproid;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<ProductModel> product = [];
  List<SlidersModel> sliders = [];
  List<String> imglist = [""];
  List<ParentcatModel> parents =[];
  String productimg0 = "";
  String productimg1 = "";
  String productimg2 = "";
  String productimg3 = "";
  String productimg4 = "";
  String productname = "";
  String availabilty ="";
  String upcome ="";
  String inoff ="";
  String specification ="";
  String description ="";
  int productprice = 0;
  int productOfferprice = 0;
  double offerpercent = 0.0;
  @override
  void initState() {
    // TODO: implement initState

    Dio().get("$baseUrl/sliders_api", options: Options(
      responseType: ResponseType.plain,
    ),
    ).then((data){
      setState(() {
        this.sliders = slidersModelFromJson(data.data.toString());

      });
    });
    Dio().post("$baseUrl/product_api_by_id",
      data: {
        "pro_id": widget.tempproid
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data) {
      setState(() {
          product = productModelFromJson(data.data.toString());
          this.productimg0 = (product[0].proImg != null ? product[0].proImg : "");
          this.productimg1 = (product[0].proImg_p1 != null ? product[0].proImg_p1 : "");
          this.productimg2 = (product[0].proImg_p2 != null ? product[0].proImg_p2 : "");
          this.productimg3 = (product[0].proImg_p3 != null ? product[0].proImg_p3 : "");
          this.productimg4 = (product[0].proImg_p4 != null ? product[0].proImg_p4 : "");
          this.productname = (product[0].proName != null ? product[0].proName : "");
          this.availabilty = (product[0].proAvailable != null ? product[0].proAvailable : "");
          this.upcome = (product[0].upcoming != null ? product[0].upcoming : "");
          this.inoff = (product[0].inOffer != null ? product[0].inOffer : "");
          this.specification = (product[0].proSpec != null ? product[0].proSpec : "");
          this.description = (product[0].proDesc != null ? product[0].proDesc : "");
          this.productprice = (int.parse(product[0].proSell) != 0 ? int.parse(product[0].proSell) : 0) ;
          this.productOfferprice = (int.parse(product[0].proOffer) != 0 ? int.parse(product[0].proOffer) : 0);
          this.offerpercent = ((100*(int.parse(product[0].proSell) - int.parse(product[0].proOffer)))/int.parse(product[0].proSell));
          imglist=[this.productimg0,this.productimg1,this.productimg2,this.productimg3,this.productimg4];
          imglist.removeWhere( (item) => item.isEmpty );
          getparent(product[0].proCatId);
      });
    });
    super.initState();
  }
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  DBHelper dbHelper = DBHelper();
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
    final cart = Provider.of<CartProvider>(context);

    void saveData(int index) {
      dbHelper.insert(
        Cart(
          id: index,
          productId: product[0].proId,
          productName: productname,
          initialPrice: productprice,
          productPrice: productprice,
          quantity: ValueNotifier(1),
          unitTag: "piece",
          image: productimg0,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productprice.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
        Fluttertoast.showToast(
            msg: "This item is already added to Cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        //title: Text("Expertlys"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () =>Navigator.pop(context,true),
              // Navigator.pushReplacement(context,MaterialPageRoute(
              // builder: (BuildContext context) => (parents[0].parentCat == "Vision Testing")? VTCategoryScreen():ProductsScreen(tempcatid:product[0].proCatId))
              // ),
              ),
        // title: Center(
        //   child: Text(" "+widget.tempcatname.toUpperCase(),style: TextStyle(color: Colors.cyan,fontSize: 15),textAlign: TextAlign.center,),
        // ),
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 0, end: -6),
            //badgeContent: Text('3',style: const TextStyle(color: Colors.white,)),
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            child: Icon(Icons.shopping_cart,color: Colors.cyan,),
          ),
          SizedBox(width: 18),
        ],
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Stack(
              children:[
                CarouselSlider.builder(
                itemCount: imglist.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: BorderRadius.circular(10.0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage( "$baseUrl/assets/productimg/"+imglist[itemIndex]),
                        ),
                      ),
                    ),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width * 0.85,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.97,
                  aspectRatio: 2.0,
                  //initialPage: 2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                ),
              ),
                Positioned(
                  top: 2,
                    right: 10,
                    child:GestureDetector(
                      onTap: () async {
                        //Share.share('Yrish Product : '+productname+' Offer Price: '+"₹"+this.productOfferprice.toString());
                        // final RenderBox box = context.findRenderObject() as RenderBox;
                        // await Share.share("text",
                        //     subject: "subject",
                        //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black26,
                        child: Icon(Icons.favorite, color: Colors.white,),
                      ),
                    )
                ),
                 Positioned(
                    top: 50,
                    right: 10,
                    child:
                    GestureDetector(
                      onTap: () async {
                        Share.share('Yrish Product : '+productname+' Offer Price: '+"₹"+this.productOfferprice.toString());
                        // final RenderBox box = context.findRenderObject() as RenderBox;
                        // await Share.share("text",
                        //     subject: "subject",
                        //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black26,
                        child: Icon(Icons.share, color: Colors.white,),
                      ),
                    )
                ),
                Positioned(
                    top: 2,
                    left: 10,
                    child:Badge(
                      toAnimate: false,
                      shape: BadgeShape.square,
                      badgeColor: (inoff!="0" ? Colors.green : Colors.blue),
                      borderRadius: BorderRadius.circular(4),
                      badgeContent: Text((inoff!="0" ? "IN OFFER" : "BESTSELLER"), style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imglist.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            ListTile(
                title:Text(this.productname, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              trailing: Badge(
                toAnimate: false,
                shape: BadgeShape.square,
                badgeColor: (availabilty!="0" ? Colors.green : Colors.red),
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text((availabilty!="0" ? "Available" : "NotAvailable"), style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 60,
                  decoration: const BoxDecoration(
                      //color: Color(0xffb2ebf2),
                    color: Colors.cyan,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: upcome!="1" ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("₹"+this.productOfferprice.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 2,right: 8),
                          child: Text("₹"+this.productprice.toString(),style: TextStyle(fontSize:19 ,decoration: TextDecoration.lineThrough,fontWeight:FontWeight.bold,color: Colors.white60),),
                        ),
                        Text(this.offerpercent.ceil().toString()+"% Off", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.lightGreenAccent),),
                      ],
                    ),
                  ): Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Coming Soon",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
              ),
            ),
            const Divider(
              height: 15,
              thickness: 4,
              color: Colors.black12
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left:15,right: 15),
                    child: Icon(Icons.local_shipping, color: Colors.blue,),
                  ),
                  Text("Cash On Delivery Available",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            const Divider(
                height: 15,
                thickness: 4,
                color: Colors.black12
            ),
            ListTile(
              title: Text("Specification",style: TextStyle(fontWeight: FontWeight.bold),),
              //
               subtitle: Html(data:"$specification"),
            ),
            ListTile(
              title: Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
              //
              subtitle: Html(data:"$description"),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             primary: Colors.deepOrangeAccent, // background
            //             onPrimary: Colors.white, // foreground
            //           ),
            //           onPressed: () { },
            //           child: Text('Add to Cart',style: TextStyle(fontSize: 16),),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child:Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             primary: Colors.orangeAccent, // background
            //             onPrimary: Colors.white, // foreground
            //           ),
            //           onPressed: () { },
            //           child: Text('Buy Now',style: TextStyle(fontSize: 16),),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

          ],
        ),
      ),
      //bottomNavigationBar: AppFooter(indx: 1,),
      persistentFooterButtons: [
        availabilty!="0" ?
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () { saveData(int.parse(product[0].proId));},
                  child: Text('Add to Cart',style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
            Expanded(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () { },
                  child: Text('Buy Now',style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
          ],
        )
        : Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () { },
                  child: Text('Notify Me',style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
