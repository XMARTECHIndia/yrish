import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../main.dart';
import '../../constants.dart';
import 'login_screen.dart';
const List<String> list = <String>['Student', 'Optometry', 'Optical', 'Opthalmologist'];
const List<String> genderlist = <String>["Male","Female","Others"];
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
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  bool _namevalidate = false;
  bool _dobvalidate = false;
  bool _emailvalidate = false;
  bool _phonevalidate = false;
  bool _addressvalidate = false;
  bool _pincodevalidate = false;
  bool _passvalidate = false;

  String dropdownValue = list.first;
  String dropdownstate = statelist.elementAt(28);
  String dropdowngender = genderlist.first;
  String _currentSelectedValue ="";
  late final void Function()? onChanged;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    phoneController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

  }

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
            child: ListView(
              children: <Widget>[
                // Container(
                //   height: 140,
                //   child: Image(image: AssetImage("images/yrislgo.png"),),
                // ),
                // Container(
                //     alignment: Alignment.center,
                //     padding: const EdgeInsets.all(10),
                //     child: const Text(
                //       'A unit of Three Instruments',
                //       style: TextStyle(
                //         //color: Colors.white,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 16),
                //     )
                // ),
                Container(
                    alignment: Alignment.center,
                    //color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up',
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
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Full Name',
                      errorText: _namevalidate ? 'Name Field Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                //       child: Icon(Icons.wc,color: Colors.cyan,size: 20,),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 8.0, left: 0.0),
                //       child: Text("Gender",style: TextStyle(
                //         fontSize: 16,
                //       ),),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                //       //color: Colors.white,
                //       //height: 65,
                //       child: DropdownButton<String>(
                //         value: dropdowngender,
                //         icon: const Icon(Icons.arrow_drop_down),
                //         elevation: 16,
                //         style: const TextStyle(color: Colors.black54),
                //         underline: Container(
                //           height: 2,
                //           color: Colors.cyan,
                //         ),
                //         onChanged: (String? value) {
                //           // This is called when the user selects an item.
                //           setState(() {
                //             dropdowngender = value!;
                //           });
                //         },
                //         items: genderlist.map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //
                //   ],
                // ),
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
                            icon: Icon(Icons.wc),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select Gender',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        //isEmpty: dropdowngender == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdowngender,
                            isDense: true,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdowngender = value!;
                              });
                            },
                            items: genderlist.map((String value) {
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  height: 65,
                  child: TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_today),
                      labelText: 'Date of Birth',
                      errorText: _dobvalidate ? 'DOB Field Can\'t Be Empty' : null,
                    ),
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dobController.text = formattedDate; //set output date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 65,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                            suffix: GestureDetector(
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title:  Column(
                                    children: [
                                      Text('Enter The OTP'),
                                      Text("has been send to +91"+phoneController.text!, style: TextStyle(fontSize: 15),),
                                    ],
                                  ),
                                  content: TextField(
                                    controller: OTPController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(hintText: "XXXX",),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                                child: Text("Verify",style: TextStyle(color: Colors.blue),)
                            ),
                            // suffixIcon: IconButton(
                            //   onPressed: phoneController.clear,
                            //   icon: Icon(Icons.done_all),
                            //   tooltip: "Verify",
                            // ),
                            errorText: _phonevalidate ? 'Mobile Number Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //     padding: const EdgeInsets.all(10),
                    //     child: Text("Get Verified")
                    // ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //color: Colors.white,
                  height: 65,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                      errorText: _phonevalidate ? 'Mobile Number Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //color: Colors.white,
                  height: 65,
                  child: TextField(
                    controller: whatsappController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'WhatsApp Number',
                      errorText: _phonevalidate ? 'WhatsApp Number Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //color: Colors.white,
                  height: 65,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Id',
                      errorText: _emailvalidate ? 'Email Id Can\'t Be Empty' : null,
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
                            icon: Icon(Icons.pin_drop),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select State',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        //isEmpty: dropdowngender == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownstate,
                            isDense: true,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownstate = value!;
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
                //
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   //color: Colors.white,
                //   //height: 65,
                //   child: TextField(
                //     controller: addressController,
                //     keyboardType: TextInputType.text,
                //     maxLines: 2,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Full Address',
                //       errorText: _addressvalidate ? 'Address Can\'t Be Empty' : null,
                //     ),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //color: Colors.white,
                  height: 65,
                  child: TextField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pincode',
                      errorText: _pincodevalidate ? 'Pincode Can\'t Be Empty' : null,
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
                            icon: Icon(Icons.medical_services),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select Occupation',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        //isEmpty: dropdowngender == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isDense: true,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list.map((String value) {
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
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                //       child: Icon(Icons.medical_services,color: Colors.cyan,size: 20,),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                //       child: Text("Occupation",style: TextStyle(
                //         fontSize: 16,
                //       ),),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                //       //color: Colors.white,
                //       //height: 65,
                //       child: DropdownButton<String>(
                //         value: dropdownValue,
                //         icon: const Icon(Icons.arrow_downward),
                //         elevation: 16,
                //         style: const TextStyle(color: Colors.black54),
                //         underline: Container(
                //           height: 2,
                //           color: Colors.cyan,
                //         ),
                //         onChanged: (String? value) {
                //           // This is called when the user selects an item.
                //           setState(() {
                //             dropdownValue = value!;
                //           });
                //         },
                //         items: list.map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ],
                // ),
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
                    controller: referralController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Referral Code (If any)',
                      //errorText: _namevalidate ? 'Name Field Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                //   decoration: BoxDecoration(
                //     //color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //       bottomRight: Radius.circular(10),
                //       bottomLeft: Radius.circular(10),
                //     ),
                //   ),
                //   height: 65,
                //   child: TextField(
                //     obscureText: true,
                //     controller: passwordController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Password',
                //       errorText: _passvalidate ? 'Password Can\'t Be Empty' : null,
                //     ),
                //   ),
                // ),

                Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.cyan,),
                      child: const Text('Register'),
                      onPressed: () {
                        // print(nameController.text);
                        // print(passwordController.text);
                        setState(() {
                          nameController.text.isEmpty ? _namevalidate = true : _namevalidate = false;
                          emailController.text.isEmpty ? _emailvalidate = true : _emailvalidate = false;
                          phoneController.text.isEmpty ? _phonevalidate = true : _phonevalidate = false;
                          addressController.text.isEmpty ? _addressvalidate = true : _addressvalidate = false;
                          pincodeController.text.isEmpty ? _pincodevalidate = true : _pincodevalidate = false;
                          passwordController.text.isEmpty ? _passvalidate = true : _passvalidate = false;
                        });
                        if(!_namevalidate && !_emailvalidate && !_phonevalidate && !_addressvalidate && !_pincodevalidate && !_passvalidate) {
                          Dio().post("$baseUrl/setuser_api",
                            data: {
                              "name": nameController.text,
                              "email": emailController.text,
                              "phone": phoneController.text,
                              "altphone": whatsappController.text,
                              "address": addressController.text,
                              "pincode": pincodeController.text,
                              "occupation": dropdownValue,
                              "refbycode": referralController.text,
                              "password": passwordController.text
                            },
                            options: Options(
                              responseType: ResponseType.plain,
                            ),
                          ).then((data) async {
                            final prefs = await SharedPreferences.getInstance();
                            //await prefs.setString('id', uitem.id);
                            await prefs.setString('id', data.data);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyApp()
                                ));
                          });
                        }
                      },
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20,color: Colors.cyan),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()
                        ));
                      },
                    )
                  ],
                ),

              ],
            )),
      ),
    );

  }
}
