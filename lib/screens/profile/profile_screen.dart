import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../models/DeliveryAddress.model.dart';
import '../../models/Userdata.model.dart';
import '../home/app_footer.dart';
import '../order/myorders_screen.dart';

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

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  String? uid ;
  String balance = "";
  List<DeliveryAddressModel> delvaddress = [] ;
  List<UserdataModel> details=[];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController addline1Controller = TextEditingController();
  TextEditingController addline2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController addphoneController = TextEditingController();
  TextEditingController addpinController = TextEditingController();
  TextEditingController addcityController = TextEditingController();
  String addstateController = statelist.elementAt(28);


  @override
  void initState() {
    super.initState();
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
    Dio().post("$baseUrl/users_api_details",
      data:{
        "uid": uid
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        // print(data);
        this.details = userdataModelFromJson(data.data.toString());
        //print(details);
        nameController.text = (details.length > 0 ? this.details[0].usrName : "your name");
        phoneController.text = (details.length > 0 ? this.details[0].usrPhone : "your phone");
      });
    });
    getUserdeliveryAdd();
    // Dio().post("$baseUrl/user_delivery_address_api",
    //   data:{
    //     "uid": uid,
    //   },
    //   options: Options(
    //     responseType: ResponseType.plain,
    //   ),
    // ).then((data){
    //   var temp = jsonDecode(data.data);
    //   setState(() {
    //     delvaddress = deliveryAddressModelFromJson(data.data.toString());
    //   });
    // });

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
  getUserdeliveryAdd(){
    Dio().post("$baseUrl/user_delivery_address_api",
      data:{
        "uid": uid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      var temp = jsonDecode(data.data);
      setState(() {
        delvaddress = deliveryAddressModelFromJson(data.data.toString());
      });
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
                      "a_phone" : phoneController.text,
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        title: Row(
          children: [
            Text("Hey! ", style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic, color: Colors.cyan),),
            Text((details.length > 0 ? this.details[0].usrName : "your name"), style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic, color: Colors.black),),
            Spacer(),
            Icon(Icons.medical_services,color: Colors.cyan,size: 18,),
            Text(" "+(details.length > 0 ? this.details[0].userOccupation : "your occupation"), style: TextStyle(color: Colors.black54,fontSize: 15),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: balance.isEmpty ?
            Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              color: Colors.white70,
              child: CircularProgressIndicator(),
            ): Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 180.0,
                    height: 60.0,
                    child: Card(
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.heart, color: Colors.redAccent, size: 22,),
                        title: Text('Wishlist'),
                      ),
                    ),
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 180.0,
                      height: 60.0,
                      child: Card(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => MyOrderScreen(),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.shopping_basket,color: Colors.blue,),
                            title: Text('My Orders'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 6.0),
                    child: SizedBox(
                      width: 190.0,
                      height: 60.0,
                      child: Card(
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.y, color: Colors.cyan,size: 20,),
                          title: Text(balance+' YCoin'),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 6.0,right: 8.0),
                    child: SizedBox(
                      width: 190.0,
                      height: 60.0,
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.support_agent, color: Colors.red,),
                          title: Text('Help Center'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:15.0),
                    child: Text("Contact Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),textAlign: TextAlign.left,),
                  ),
                  Spacer(),
                  Icon(FontAwesomeIcons.userPen,color: Colors.black54,size: 16,),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 4),
                    child: Text(" Edit", style: TextStyle(color: Colors.black54,fontSize: 16),),
                  )
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.email,color: Colors.cyan,size: 18,),
                        Text("  "+(details.length > 0 ? this.details[0].usrEmailId : "your email"),style: TextStyle(fontSize: 16,color: Colors.black45),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.phone,color: Colors.cyan,size: 18,),
                        Text("  "+(details.length > 0 ? this.details[0].usrPhone : "your phone numbers"),style: TextStyle(fontSize: 16,color: Colors.black45),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.whatsapp,color: Colors.cyan,size: 18,),
                        Text("  "+(details.length > 0 ? this.details[0].usrAlt : "your whatsapp numbers"),style: TextStyle(fontSize: 16,color: Colors.black45),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.mapLocationDot,color: Colors.cyan,size: 18,),
                        Text("  "+(details.length > 0 ? this.details[0].usrState : "your sate"),style: TextStyle(fontSize: 16,color: Colors.black45),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.locationDot,color: Colors.cyan,size: 18,),
                        Text("  "+(details.length > 0 ? this.details[0].usrPincode : "your pincode"),style: TextStyle(fontSize: 16,color: Colors.black45),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 5,
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:15.0),
                    child: const Text("Delivery Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),textAlign: TextAlign.left,),
                  ),
                  Spacer(),


                ],
              ),
              Card(
                child: ListTile(
                  leading: Column(
                    children: [
                      Icon(FontAwesomeIcons.house,),
                      Text("Home")
                    ],
                  ),
                  title: Text(delvaddress.isEmpty ? "" :delvaddress[0].haLineOne!+', '+delvaddress[0].haLineTwo!+','+delvaddress[0].haCity+', Pin-'+delvaddress[0].haPinCode+', '+delvaddress[0].haState),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(delvaddress.isEmpty ? "" :"Landmark: "+delvaddress[0].haLandMark!),
                      Text(delvaddress.isEmpty ? "" :"Contact: "+delvaddress[0].haPhone!),
                    ],
                  ),
                  trailing:ElevatedButton(
                    onPressed: (){
                      saveAddress("homeAddress");
                    },
                    child: Text(delvaddress.isEmpty ? "Add" :"Edit"),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Column(
                    children: [
                      Icon(FontAwesomeIcons.briefcase,),
                      Text("Work")
                    ],
                  ),
                  title: Text(delvaddress.isEmpty ? "" :delvaddress[0].waLineOne!+', '+delvaddress[0].waLineTwo!+','+delvaddress[0].waCity+', Pin-'+delvaddress[0].waPinCode+', '+delvaddress[0].waState),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(delvaddress.isEmpty ? "" :"Landmark: "+delvaddress[0].waLandMark!),
                      Text(delvaddress.isEmpty ? "" :"Contact: "+delvaddress[0].waPhone!),
                    ],
                  ),
                  trailing:ElevatedButton(
                    onPressed: (){
                      saveAddress("workAddress");
                    },
                    child: Text(delvaddress.isEmpty ? "Add" :"Edit"),
                  ),
                ),
              ),
              const Divider(
                thickness: 5,
              ),
              Card(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.userGroup,),
                  title: Text('Invite Your Friends'),
                  subtitle: Text('Your Reference Id: '+(details.length > 0 ? details[0].usrRefCode : '')),
                  trailing:Icon(FontAwesomeIcons.shareNodes),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.android,),
                  title: Text('Share the App Now'),
                  subtitle: Text('Invite your friends to download the App'),
                  trailing:Icon(FontAwesomeIcons.share),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Divider(
                thickness: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black38, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('id');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyApp()
                  ));
                }, child: Text("Logout")),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppFooter(indx: 2,),
    );
  }
}
