import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../models/Userdata.model.dart';
import '../home/app_footer.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  String? uid ;
  String balance = "";
  List<UserdataModel> details=[];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
                        child: ListTile(
                          leading: Icon(Icons.shopping_basket,color: Colors.blue,),
                          title: Text('My Orders'),
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
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:15.0),
                    child: Text("Reset Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),textAlign: TextAlign.left,),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                  ),
                ),
              ),
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Update Now'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Dio().post("$baseUrl/updateuser_api",
                        data:{
                          "uid":this.uid,
                          "name":nameController.text,
                          "phone":phoneController.text,
                          "password":passwordController.text
                        },
                        options: Options(
                          responseType: ResponseType.plain,
                        ),
                      ).then((data) async {
                        setState(() {

                        });
                        final scaffold = ScaffoldMessenger.of(context);
                        await scaffold.showSnackBar(
                          SnackBar(
                            content: const Text('Your Profile has been Updated Successfully'),
                            action: SnackBarAction(label: 'X', onPressed: scaffold.hideCurrentSnackBar),
                          ),
                        );
                        Navigator.pushReplacement(context,MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));

                      });
                    },
                  )
              ),
              Divider(
                thickness: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black38, // background
                      onPrimary: Colors.white, // foreground
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
