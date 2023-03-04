import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/models/Notification.model.dart';

import '../../constants.dart';
import '../../main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];
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
        getnotifications();
      });
    }
  }
  getnotifications(){
    Dio().post("$baseUrl/notification_api",
      data:{
        "uid": uid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        notifications = notificationModelFromJson(data.data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        //title: Text("Expertlys"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyApp())),
        ),
        title: Row(
          children: [
            Text("Notifications"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: notifications.length > 0
    ?       ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    String notif_sub = notifications[index].subject;
                    String notif_msg = notifications[index].message;
                    //String formatDate(DateTime date) => new DateFormat("MMMM d").format(date);
                    var dateFormate = DateFormat("y-MM-dd").format(DateTime.parse(notifications[index].time));
                    // var dateFormat = DateFormat('y-MM-dd');
                    // var date = dateFormat.parse(notifications[index].time, true);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
                        child: ExpansionTile(
                          collapsedIconColor: Colors.cyan,
                          iconColor: Colors.cyan,
                          subtitle: Text(dateFormate.toString()),
                          title: Text(notif_sub, style: TextStyle(color: Colors.cyan),),
                          children: <Widget>[
                            Text(notif_msg),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ) : Text("No Notification Found.."),
        ),
      ),
    );
  }
}
