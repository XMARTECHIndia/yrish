import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/screens/startup/registration_screen.dart';

import '../../../main.dart';
import '../../constants.dart';
import '../../models/Login.model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _loaddata();
  }

  //Loading counter value on start
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //backgroundColor: myPrimaryColor,
      body: MyStatefulWidget(),
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //List<LoginModel> useritems=[];

  late LoginModel uitem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/app_background1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.only(left: 10,right:10,top: 50),
          child: ListView(
            children: <Widget>[
              Container(
                height: 140,
                child: Image(image: AssetImage("images/yrislgo.png"),),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'A unit of Three Instruments',
                    style: TextStyle(
                        //color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )
              ),
              Container(
                  alignment: Alignment.center,
                  //color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20,),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                      ),
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login', style: TextStyle(fontSize: 16),),
                    //style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18,),primary: Colors.orangeAccent),
                    onPressed: () {
                      Dio().post("$baseUrl/userlogin_api",
                        data:{
                          "phone": nameController.text,
                          "password": passwordController.text
                        },
                        options: Options(
                          responseType: ResponseType.plain,
                        ),
                      ).then((data) async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('id', data.data);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyApp()
                        ));
                        setState(() {

                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.cyan,)
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20,color: Colors.cyan,),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegistrationScreen()
                      ));
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
