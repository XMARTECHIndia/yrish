import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
import 'package:yris/screens/order/invoice_screen.dart';
import '../../constants.dart';
import '../../main.dart';
import '../../models/Myorder.model.dart';
import '../home/app_footer.dart';
class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<MyOrderModel> myorders = [];
  String? uid ;
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
    _loaddata();
  }
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        getorders();
      });
    }
  }
  getorders(){
    Dio().post("$baseUrl/myorder_api",
      data:{
        "uid": uid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        myorders = myOrderModelFromJson(data.data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('My Orders'),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
          child: myorders.length > 0
              ?       ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: myorders.length,
              itemBuilder: (BuildContext context, int index) {
                String order_id = myorders[index].orderId;
                //String order_date = myorders[index].billDate;
                String order_status = myorders[index].delvStatus;
                //String formatDate(DateTime date) => new DateFormat("MMMM d").format(date);
                var dateFormate = DateFormat("y-MM-dd").format(myorders[index].billDate);
                // var dateFormat = DateFormat('y-MM-dd');
                // var date = dateFormat.parse(notifications[index].time, true);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 6.0, left: 0.0, right: 6.0, bottom: 6.0),
                    child: ExpansionTile(
                      collapsedIconColor: Colors.cyan,
                      iconColor: Colors.cyan,
                      subtitle: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor: (order_status=="Delivered" ? Colors.green : Colors.cyan),
                              borderRadius: BorderRadius.circular(4),
                              badgeContent: Text(order_status,style: const TextStyle(color: Colors.white,)),
                                //child: Icon(Icons.notifications),
                              ),
                          ),
                          Text("Ordered On: "+dateFormate.toString(),style: TextStyle(color: Colors.black54,)),
                        ],
                      ),
                      title: Text("Order #"+order_id, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Badge(
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: (Colors.blue),
                                borderRadius: BorderRadius.circular(4),
                                badgeContent: Text("View Invoice",style: const TextStyle(color: Colors.white,)),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InvoiceScreen(orderid:order_id,invoicedate:dateFormate)),
                                );
                              },
                            ),
                            SizedBox(width: 10,),
                            order_status!="Delivered" ? Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor: (Colors.red),
                              borderRadius: BorderRadius.circular(4),
                              badgeContent: Text("Cancel Order",style: const TextStyle(color: Colors.white,)),
                            ): SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              }
          ) : Text("No Order Found.."),
        ),
      ),
      bottomNavigationBar: const AppFooter(indx: 4,),
    );
  }
}
