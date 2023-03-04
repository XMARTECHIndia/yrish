import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/screens/cart/checkout_screen.dart';

import '../../constants.dart';
import '../../database/db_helper.dart';
import '../../models/Cart.model.dart';
import '../../provider/cart_provider.dart';
class CartScreen extends StatefulWidget { const CartScreen({
  Key? key,
}) : super(key: key);

@override
State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  TextEditingController couponController = TextEditingController();
  TextEditingController coinController = TextEditingController();
  int discount = 0  ;
  int total = 0  ;
  String usercupone = "";
  int usedcoin = 0;
  DBHelper? dbHelper = DBHelper();
  String? uid ;
  String balance = "";

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
    _loaddata();
  }
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        getuserdata();
      });
    }
  }
  getuserdata(){
    Dio().post("$baseUrl/wallet_bal_api",
      data:{
        "uid": uid
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        this.balance = data.data.toString();
        //print(data.data.toString());
      });
    });
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    couponController.dispose();
    super.dispose();
  }
  setcoupone(cup , subtotal){
    setState(() {
      usercupone = cup!;
      total = subtotal - discount;
    });
  }
  setcoin(useableamt , subtotal){
    setState(() {
      discount = useableamt;
      usedcoin = useableamt!*2;
      total = subtotal - discount;
    });
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    //print(cart.totalPrice);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('My Shopping Cart'),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CartProvider>(
                builder: (BuildContext context, provider, widget) {
                  if (provider.cart.isEmpty) {
                    return const Center(
                        child: Text(
                          'Your Cart is Empty',
                          style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.cart.length,
                        itemBuilder: (context, index) {
                          return Card(
                            //color: Colors.blueGrey.shade200,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                    height: 80,
                                    width: 80,
                                    image:NetworkImage( "$baseUrl/assets/productimg/"+provider.cart[index].image!),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Product: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:'${provider.cart[index].productName!}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: 'Unit: ',
                                                      style: TextStyle(
                                                          color: Colors.blueGrey.shade800,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                            '${provider.cart[index].unitTag!}\n',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                      ]),
                                                ),
                                                RichText(
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: 'Price: ' r"₹",
                                                      style: TextStyle(
                                                          color: Colors.blueGrey.shade800,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                            '${provider.cart[index].productPrice!}\n',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ValueListenableBuilder<int>(
                                              valueListenable:
                                              provider.cart[index].quantity!,
                                              builder: (context, val, child) {
                                                return PlusMinusButtons(
                                                  addQuantity: () {
                                                    cart.addQuantity(provider.cart[index].id!);
                                                    dbHelper!.updateQuantity(Cart(
                                                        id: index,
                                                        productId: index.toString(),
                                                        productName: provider.cart[index].productName,
                                                        initialPrice: provider.cart[index].initialPrice,
                                                        productPrice: provider.cart[index].productPrice,
                                                        quantity: ValueNotifier(provider.cart[index].quantity!.value),
                                                        unitTag: provider.cart[index].unitTag,
                                                        image: provider.cart[index].image))
                                                        .then((value) {
                                                      setState(() {
                                                        cart.addTotalPrice(double.parse(provider.cart[index].productPrice.toString()));
                                                      });
                                                    });
                                                  },
                                                  deleteQuantity: () {
                                                    cart.deleteQuantity(provider.cart[index].id!);
                                                    cart.removeTotalPrice(double.parse(provider.cart[index].productPrice.toString()));
                                                  },
                                                  text: val.toString(),
                                                );
                                              }),
                                          IconButton(
                                              onPressed: () {
                                                dbHelper!.deleteCartItem(
                                                    provider.cart[index].id!);
                                                provider
                                                    .removeItem(provider.cart[index].id!);
                                                provider.removeCounter();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade800,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            cart.cart.isEmpty ? Text("") : Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                for (var element in value.cart) {
                  totalPrice.value =
                      (element.productPrice! * element.quantity!.value) +
                          (totalPrice.value ?? 0);
                }
                return Column(
                  children: [
                    ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          val = val ?? 0;
                          int temp = (val*0.2).floor();
                          int tempbal = int.tryParse(balance) ?? 0;
                          int coinincash = (tempbal*0.5).floor();
                          int useablecoinamt = (coinincash <= temp ? coinincash : temp);
                          return Column(
                            children: [
                              Divider(thickness: 2),
                              ReusableWidget(
                                  title: 'Sub-Total',
                                  value: r'₹' + (val?.toStringAsFixed(2) ?? '0')
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount", style: TextStyle(fontSize: 16),),
                                    SizedBox(width: 5,),
                                    discount == 0 ? GestureDetector(
                                      onTap: (){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        Text('Enter The Coupon Code'),
                                                        discount > 0   ? Text("Hey! you will get ₹" +discount.toString() +" discount on this Coupon",style: TextStyle(fontSize: 12,color: Colors.green),)
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                    content: TextField(
                                                      onChanged: (text) async {
                                                        Dio().post("$baseUrl/chkcoupon",
                                                          data:{
                                                            "coupon_name" : text
                                                          },
                                                          options: Options(
                                                            responseType: ResponseType.plain,
                                                          ),
                                                        ).then((data){
                                                          setState(() {
                                                            //print(data.data);
                                                            if(data.data!="") {
                                                              discount = int.parse(data.data);
                                                            }else{
                                                              discount = 0;
                                                            }
                                                          });
                                                        });
                                                      },
                                                      controller: couponController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: const InputDecoration(
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.cyan,
                                                              width: 1.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.cyan,
                                                              width: 2.0),
                                                        ),
                                                        border: OutlineInputBorder(),
                                                        labelText: 'Enter Coupon Code',
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: discount > 0 ? () async {
                                                          //getverified(phoneController.text!, OTPController.text!);
                                                          await setcoupone(couponController.text, val);
                                                          Navigator.pop(context,'Use') ;
                                                        }:null,
                                                        child: const Text('Use'),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              );
                                           },
                                        );
                                      },
                                      child: Badge(
                                        toAnimate: false,
                                        shape: BadgeShape.square,
                                        borderRadius: BorderRadius.circular(4),
                                        badgeColor: Colors.green,
                                        badgeContent: Text("Use Coupon", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ),
                                    ):(usercupone !="" ? Text("Coupon: "+usercupone+" Applied", style: TextStyle(fontSize: 12, color: Colors.green),): Text("")),
                                    SizedBox(width: 5,),
                                    discount == 0 ? GestureDetector(
                                      onTap: (){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Column(
                                                  children: [
                                                    Text('Use Yrish Coin'),
                                                    Text("You have "+balance+" YCion", style: TextStyle(fontSize: 14),),
                                                  ],
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text("You Can use "+(useablecoinamt*2).toString()+" YCoin"),
                                                      Text("Get ₹"+useablecoinamt.toString()+" discount"),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: useablecoinamt > 0 ? () async {
                                                      await setcoin(useablecoinamt, val);
                                                      Navigator.pop(context, 'Use');
                                                    }:null,
                                                    child: const Text('Use'),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: Badge(
                                        toAnimate: false,
                                        shape: BadgeShape.square,
                                        borderRadius: BorderRadius.circular(4),
                                        badgeColor: Colors.orange,
                                        badgeContent: Text("Use Coin", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ),
                                    ):(usedcoin !=0 ? Text("You have used "+(useablecoinamt*2).toString()+" YCoin" ,style: TextStyle(fontSize: 12, color: Colors.green),): Text("")),
                                    Spacer(),
                                    Text(
                                      r'- ₹' +discount.toStringAsFixed(2)!,
                                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount", style: TextStyle(fontSize: 16),),
                                    Text(
                                      discount > 0 ? r' ₹' +(val!-discount).toStringAsFixed(2) : r'₹' + (val?.toStringAsFixed(2) ?? '0'),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: cart.cart.isEmpty ? Text(""):Consumer<CartProvider>(
        builder: (BuildContext context, value, Widget? child) {
          final ValueNotifier<int?> totalPrice = ValueNotifier(null);
          for (var element in value.cart) {
            totalPrice.value =
                (element.productPrice! * element.quantity!.value) +
                    (totalPrice.value ?? 0);
          }
          return ValueListenableBuilder<int?>(
              valueListenable: totalPrice,
              builder: (context, val, child) {
                return
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CheckoutScreen(totalamt:val!,discount: discount,coupontxt:couponController.text,coinused:usedcoin, mycart:value.cart)),
                    );
                  },
                  child: Container(
                    color: Colors.cyan.shade600,
                    alignment: Alignment.center,
                    height: 50.0,
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                );
              }
          );
        }
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}