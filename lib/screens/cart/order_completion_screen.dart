import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yris/screens/home/home_screen.dart';
import 'package:yris/screens/order/myorders_screen.dart';

import '../../main.dart';
class OrderCompletionScreen extends StatefulWidget {
  const OrderCompletionScreen({Key? key}) : super(key: key);

  @override
  _OrderCompletionScreenState createState() => _OrderCompletionScreenState();
}

class _OrderCompletionScreenState extends State<OrderCompletionScreen> {
  @override
  void initState() {
    super.initState();
    //context.read<CartProvider>().getData();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    // couponController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('Order Confirmation'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 140,
              padding: EdgeInsets.only(left: 20),
              child: Image(image: AssetImage("images/smartphone.png"),),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("Congratulations!",style: TextStyle(fontSize: 18, color: Colors.green),)
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 5,bottom: 15),
                child: Text("Your Order has been placed successfully!",style: TextStyle(fontSize: 15))
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent, // background
                        foregroundColor: Colors.white, // foreground
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                      },
                      icon: Icon(Icons.shopping_cart,),
                      label: Text('Shop Again',style: TextStyle(fontSize: 16),),
                    ),
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent, // background
                        foregroundColor: Colors.white, // foreground
                      ),
                      onPressed: () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => MyOrderScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_basket,),
                      label: Text('My Orders',style: TextStyle(fontSize: 16),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
