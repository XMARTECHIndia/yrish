// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../main.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.mobile}) : super(key: key);
  final String mobile;
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  TextEditingController OTPController = TextEditingController();
  // TextEditingController textEditingController1 = TextEditingController();
  //
  String _comingSms = 'Unknown';
  @override
  void initState() {
    super.initState();
    //textEditingController1 = TextEditingController();
    //initSmsListener();
    _loaddata();
  }
  @override
  void dispose() {
    //textEditingController1.dispose();
    //AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  //Loading counter value on start
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();
  }

  // Future<void> initSmsListener() async {
  //
  //   String comingSms;
  //   try {
  //     comingSms = (await AltSmsAutofill().listenForSms)!;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms;
  //     print("====>Message: ${_comingSms}");
  //     print("${_comingSms[32]}");
  //     textEditingController1.text = _comingSms[32] + _comingSms[33] + _comingSms[34] + _comingSms[35]
  //         + _comingSms[36] + _comingSms[37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/app_background1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 10,right:10,top: 20),
            child: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    height: 140,
                    child: Image(image: AssetImage("images/yrislgo.png"),),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'A 4 digit OTP has been send to your Phone Number',
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
                      child: Text(
                        '+91-'+widget.mobile,
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
                    height: 65,
                    child: TextField(
                      controller: OTPController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your OTP',
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: PinCodeTextField(
                  //     appContext: context,
                  //     pastedTextStyle: TextStyle(
                  //       color: Colors.green.shade600,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     length: 4,
                  //     obscureText: false,
                  //     animationType: AnimationType.fade,
                  //     pinTheme: PinTheme(
                  //         shape: PinCodeFieldShape.box,
                  //         borderRadius: BorderRadius.circular(10),
                  //         fieldHeight: 50,
                  //         fieldWidth: 40,
                  //         inactiveFillColor: Colors.white,
                  //         inactiveColor: Colors.cyan,
                  //         selectedColor: Colors.cyanAccent,
                  //         selectedFillColor: Colors.white,
                  //         activeFillColor: Colors.white,
                  //         activeColor: Colors.cyan
                  //     ),
                  //     cursorColor: Colors.black,
                  //     animationDuration: Duration(milliseconds: 300),
                  //     enableActiveFill: true,
                  //     controller: textEditingController1,
                  //     keyboardType: TextInputType.number,
                  //     boxShadows: [
                  //       BoxShadow(
                  //         offset: Offset(0, 1),
                  //         color: Colors.black12,
                  //         blurRadius: 10,
                  //       )
                  //     ],
                  //     onCompleted: (v) {
                  //       //do something or move to next screen when code complete
                  //     },
                  //     onChanged: (value) {
                  //       print(value);
                  //       setState(() {
                  //         print('$value');
                  //       });
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                    child: Row(
                      children:[
                        Spacer(),
                        GestureDetector(
                            child: Text("Resend OTP", style: TextStyle(color: Colors.cyan),)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: const Text('Submit & Login', style: TextStyle(fontSize: 16),),
                        onPressed: (){
                          print('login');
                          Dio().post("$baseUrl/userlogin_api",
                            data:{
                              "phone": widget.mobile,
                              "otp": OTPController.text
                            },
                            options: Options(
                              responseType: ResponseType.plain,
                            ),
                          ).then((data) async {
                            print(data.data);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('id', data.data);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => MyApp()
                            ));
                            setState(() {

                            });
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => OtpScreen()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan,)
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}
