import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/models/Cart.model.dart';
import 'package:yris/screens/cart/order_completion_screen.dart';

import '../../constants.dart';
import '../../database/db_helper.dart';
import '../../models/DeliveryAddress.model.dart';
import '../../provider/cart_provider.dart';
enum SingingCharacter { workAddress, homeAddress }
enum PayCharacter { online, cod }
const List<String> statelist = <String>[ "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  "Uttar Pradesh",
  "West Bengal",
  "Andaman and Nicobar Islands",
  "Chandigarh",
  "Dadra and Nagar Haveli",
  "Daman and Diu",
  "Delhi",
  "Lakshadweep",
  "Puducherry"];

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.discount,required this.totalamt, required this.coupontxt, required this.mycart, required this.coinused}) : super(key: key);
  final int discount;
  final int totalamt;
  final int coinused;
  final String coupontxt;
  final List<Cart> mycart;
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  SingingCharacter? _address = SingingCharacter.homeAddress;
  PayCharacter? _paymethod = PayCharacter.cod;
  DBHelper? dbHelper = DBHelper();
  List<DeliveryAddressModel> delvaddress = [] ;
  String? uid ;
  bool inprogress = false;
  TextEditingController addline1Controller = TextEditingController();
  TextEditingController addline2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController addphoneController = TextEditingController();
  TextEditingController addpinController = TextEditingController();
  TextEditingController addcityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController gstinController = TextEditingController();
  String addstateController = statelist.elementAt(28);
  //final cart = Provider.of<CartProvider>(context);
  @override
  void initState() {
    super.initState();
    _loaddata();
    context.read<CartProvider>().getData();
    //print(context.read<CartProvider>().getData());
    //inspect(context.read<CartProvider>().getData());

  }
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        getUserdeliveryAdd();
      });
    }
  }
  getUserdeliveryAdd(){

    Dio().post("$baseUrl/user_delivery_address_api",
      data:{
        "uid": uid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        delvaddress = deliveryAddressModelFromJson(data.data.toString());
        if(delvaddress[0].waFlag == "1"){
          _address = SingingCharacter.workAddress;
        }else if(delvaddress[0].haFlag == "1"){
          _address = SingingCharacter.homeAddress;
        }
        //print(delvaddress[0].haFlag);
      });
    });
  }
  _saveOrder(CartProvider cart){
    //print(cart.cart.length);
    inprogress = true;
    int counter = 0;
    Dio().post("$baseUrl/order_api",
      data:{
        "uid": uid,
        "bill_to_gstin": gstinController.text,
        "invoice_total": widget.totalamt,
        "discount_amt":widget.discount,
        "payable_amt":widget.totalamt-widget.discount,
        "coin_amt": widget.coinused, //need to change
        "pay_mode": _paymethod.toString(),
        "coupon_name": widget.coupontxt,
        "delv_address":_address.toString()
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      //print(data);
      String orderid = data.toString();
      widget.mycart.forEach((item) {
        _saveOrderdetails(orderid,item.id,item.productPrice,item.productId,item.quantity!.value,cart);
        counter++;
        //print(item.quantity!.value);
      });
      if(counter==widget.mycart.length) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => OrderCompletionScreen(),
          ),
        );
      }
    });
  }
  _saveOrderdetails(orderid,itemslno,itemprice,itemid,itemqty, CartProvider cart){

    Dio().post("$baseUrl/order_details_api",
      data:{
        "orderid": orderid,
        "itemid": itemid,
        "itemqty": itemqty
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      //print(itemslno);
      dbHelper!.deleteCartItem(itemslno!);
      cart.removeItem(itemslno!);
      cart.removeCounter();

    });
  }
  saveAddress(type){
    //print(uid);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Column(
              children: [
                type=="homeAddress" ? Text('Enter Home Address') : Text('Enter Work Address'),
              ],
            ),
            content: Container(
              width: 300,
              height: 400,
              child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: addline1Controller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Address Line 1',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: addline2Controller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Address Line 2',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: landmarkController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Landmark',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: addphoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: addpinController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Pincode',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 55,
                      child: TextField(
                        controller: addcityController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          height: 60,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              //labelStyle: textStyle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                                ),
                                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Please select State',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                            //isEmpty: dropdowngender == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: addstateController,
                                isDense: true,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    addstateController = value!;
                                  });
                                },
                                items: statelist.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ]
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Dio().post("$baseUrl/updateuser_address_api",
                    data:{
                      "uid":uid,
                      "addresstype" : type,
                      "a_line_one" : addline1Controller.text,
                      "a_line_two" : addline2Controller.text,
                      "a_land_mark" : landmarkController.text,
                      "a_phone" : addphoneController.text,
                      "a_pin_code": addpinController.text,
                      "a_city" : addcityController.text,
                      "a_state" : addstateController
                    },
                    options: Options(
                      responseType: ResponseType.plain,
                    ),
                  ).then((data){
                    Navigator.pop(context, 'Save');
                    setState(() {
                      getUserdeliveryAdd();
                    });
                  });

                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('CheckOut'),

      ),
      body: SingleChildScrollView(
        child: Consumer<CartProvider>(
          builder: (BuildContext context, value, Widget? child) {
            final ValueNotifier<int?> totalPrice = ValueNotifier(null);
            for (var element in value.cart) {
              totalPrice.value =
                  (element.productPrice! * element.quantity!.value) +
                      (totalPrice.value ?? 0);
            }
            return Column(
              children: [
                ListTile(
                  title: Row(
                    children: const [
                      // Icon(Icons.delivery,size: 18.0,color: Colors.cyan,),
                      // SizedBox(width: 10),
                      Text('Order Summery',style: TextStyle(color: Colors.cyan, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  subtitle: Text('Amounts at a Glance',style: TextStyle(color: Colors.black38, fontSize: 13.0),),
                  // trailing: InkWell(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => OfferScreen()),
                  //     // );
                  //   },
                  //   child: Ink(
                  //       child: Text('Edit ',style: TextStyle(color: Colors.cyan, fontSize: 14.0),)
                  //   ),
                  // ),
                ),
                ValueListenableBuilder<int?>(
                    valueListenable: totalPrice,
                    builder: (context, val, child) {
                      return Column(
                        children: [
                          ReusableWidget(
                              title: 'Total Amount',
                              value: r'₹' + (widget.totalamt.toStringAsFixed(2) ?? '0')
                          ),
                          ReusableWidget(
                              title: 'Discount',
                              value: r'- ₹' + (widget.discount.toStringAsFixed(2) ?? '0')
                          ),
                          Divider(
                            thickness: 3,
                            indent: 15,
                            endIndent: 15,
                          ),
                          ReusableWidget(
                              title: 'Payable Amount',
                              value: widget.discount > 0 ? r' ₹' +(widget.totalamt-widget.discount).toStringAsFixed(2) : r'₹' + (widget.totalamt.toStringAsFixed(2) ?? '0'),
                          ),
                        ],
                      );
                    }
                    ),
                Divider(
                  thickness: 3,
                  indent: 15,
                  endIndent: 15,
                ),
                ListTile(
                  title: Row(
                    children: const [
                      // Icon(Icons.delivery,size: 18.0,color: Colors.cyan,),
                      // SizedBox(width: 10),
                      Text('GST Number (If Applicable)',style: TextStyle(color: Colors.cyan, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  //subtitle: Text('If Applicable',style: TextStyle(color: Colors.black38, fontSize: 13.0),),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TextField(
                    controller: gstinController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      // labelText: 'If Applicable',
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const [
                      // Icon(Icons.delivery,size: 18.0,color: Colors.cyan,),
                      // SizedBox(width: 10),
                      Text('Delivery Address',style: TextStyle(color: Colors.cyan, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  subtitle: Text('Select Your Delivery Address',style: TextStyle(color: Colors.black38, fontSize: 13.0),),
                  trailing: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => OfferScreen()),
                      // );
                    },
                    child: Ink(
                        child: Text('Edit ',style: TextStyle(color: Colors.cyan, fontSize: 14.0),)
                    ),
                  ),
                ),
                delvaddress.isEmpty || delvaddress[0].haFlag=="0" ? ElevatedButton(
                  child: Text("Add Home Address"),
                  onPressed: () {
                    saveAddress("homeAddress");
                  },
                ):
                Card(
                  child: RadioListTile<SingingCharacter>(
                    title: Text(delvaddress.isEmpty ? "" :delvaddress[0].haLineOne!+', '+delvaddress[0].haLineTwo!+','+delvaddress[0].haCity+', Pin-'+delvaddress[0].haPinCode+', '+delvaddress[0].haState),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(delvaddress.isEmpty ? "" :"Landmark: "+delvaddress[0].haLandMark!),
                        Text(delvaddress.isEmpty ? "" :"Contact: "+delvaddress[0].haPhone!),
                      ],
                    ),
                    secondary: ElevatedButton(
                                  child: Text("Edit"),
                                  onPressed: () {
                                    saveAddress("homeAddress");
                                  },
                                ),
                    value: SingingCharacter.homeAddress,
                    groupValue: _address,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                ),
                delvaddress.isEmpty || delvaddress[0].waFlag=="0" ? ElevatedButton(
                  child: Text("Add Work Address"),
                  onPressed: () {
                    saveAddress("workAddress");
                  },
                ):
                Card(
                  child: RadioListTile<SingingCharacter>(
                    title: Text(delvaddress.isEmpty ? "PLease Add Work Address" :delvaddress[0].waLineOne!+', '+delvaddress[0].waLineTwo!+','+delvaddress[0].waCity+', Pin-'+delvaddress[0].waPinCode+', '+delvaddress[0].waState),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(delvaddress.isEmpty ? "" :"Landmark: "+delvaddress[0].waLandMark!),
                        Text(delvaddress.isEmpty ? "" :"Contact: "+delvaddress[0].waPhone!),
                      ],
                    ),
                    secondary: ElevatedButton(
                      child: Text("Edit"),
                      onPressed: (){
                        saveAddress("workAddress");
                      },
                    ),
                    value: SingingCharacter.workAddress,
                    groupValue: _address,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _address = value;

                      });
                    },
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const [
                      // Icon(Icons.delivery,size: 18.0,color: Colors.cyan,),
                      // SizedBox(width: 10),
                      Text('Payment Method',style: TextStyle(color: Colors.cyan, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  subtitle: Text('Choose any of the payment methods',style: TextStyle(color: Colors.black38, fontSize: 13.0),),

                ),
                Card(
                  child: RadioListTile<PayCharacter>(
                    title: const Text('Pay Online'),
                    subtitle: const Text('Net Banking/ UPI/ Cards'),
                    secondary: Icon(FontAwesomeIcons.creditCard, color: Colors.blue.shade400,),
                    value: PayCharacter.online,
                    groupValue: _paymethod,
                    onChanged: (PayCharacter? value) {
                      setState(() {
                        _paymethod = value;
                      });
                    },
                  ),
                ),
                Card(
                  child: RadioListTile<PayCharacter>(
                    title: const Text('Cash On Delivery'),
                    subtitle: const Text('Choose COD to pay after delivery'),
                    secondary: Icon(FontAwesomeIcons.moneyBill1Wave, color: Colors.green,),
                    value: PayCharacter.cod,
                    groupValue: _paymethod,
                    onChanged: (PayCharacter? value) {
                      setState(() {
                        _paymethod = value;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: delvaddress.isEmpty ? Text("Please Add a Delivery Address") :  inprogress ? CircularProgressIndicator() :InkWell(
        onTap: () {
          _saveOrder(cart);
        },
        child: Container(
          color: Colors.cyan.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Place Order',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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