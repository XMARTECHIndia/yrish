import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/constants.dart';
// import 'package:yris/models/Category.model.dart';
// import 'package:yris/models/Locations.model.dart';
import 'package:yris/models/Slider.model.dart';
// import 'package:yris/repo/categories.repo.dart';
// import 'package:yris/screens/forum/components/askinfo_screen.dart';
// import 'package:yris/screens/home/components/service_icons.dart';
// import 'package:yris/screens/home/components/title_with_more_btn.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yris/screens/home/search_section.dart';
import 'package:yris/screens/home/upcoming_section.dart';
// import 'all_services.dart';
// import 'header_with_searchbox.dart';
import '../../models/Foryou.model.dart';
import '../../models/Offer.model.dart';
import '../../models/Upcoming.model.dart';
import '../products/foryou_screen.dart';
import '../products/offer_screen.dart';
import '../products/upcoming_screen.dart';
import 'categories_section.dart';
import 'foryou_scetion.dart';
import 'home_sliders.dart';
import 'offer_section.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? uid ;
  List<SlidersModel> sliders = [];
  List<OfferModel> offers = [];
  List<UpcomingModel> upcomings = [];
  List<ForyouModel> foryou = [];
  String dropdownValue = '';
  List<String> items = <String>[];
  String selectedItem = "";
  List<String> kOptions = <String>[];
  //bool loaded = false;
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
    Dio().get("$baseUrl/sliders_api", options: Options(
      responseType: ResponseType.plain,
    ),
    ).then((data){
      setState(() {
        this.sliders = slidersModelFromJson(data.data.toString());

      });
    });

    Dio().post("$baseUrl/products_api_with_offer",
      data:{
        "limit": 4,
      },
      options: Options(
      responseType: ResponseType.plain,
    ),
    ).then((data){
      setState(() {
        this.offers = offerModelFromJson(data.data.toString());

      });
    });

    Dio().post("$baseUrl/products_api_with_upcoming",
      data:{
        "limit": 4,
      },
      options: Options(
      responseType: ResponseType.plain,
    ),
    ).then((data){
      setState(() {
        this.upcomings = upcomingModelFromJson(data.data.toString());

      });
    });

  }
  void _loaddata() async {
    final prefs = await SharedPreferences.getInstance();

    if (this.mounted) {
      setState(() {
        uid = (prefs.getString('id') != null ? prefs.getString('id') : "");
        getproductdata();
      });
    }
  }
  getproductdata(){
    Dio().post("$baseUrl/products_api_with_occupation",
      data:{
        "uid": uid,
        "limit": 0,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        this.foryou = foryouModelFromJson(data.data.toString());

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child:
      Column(
        children: [
          const SearchSection(),
          sliders.isEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(minHeight: 180,backgroundColor: Colors.cyan.shade50,color: Colors.cyan.shade200,),
          ) : Home_Slider(sliders: sliders),
          Container(
            margin: const EdgeInsets.only(top: 05.0),
            //height: size.height * 0.2,
            decoration: const BoxDecoration(
              color: myPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                //topRight: Radius.circular(25),
              ),
            ),
            ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.hotel_class,size: 18.0,color: Colors.green,),
                SizedBox(width: 10),
                Text('Best Offers',style: TextStyle(color: Colors.green, fontSize: 16.0),),
              ],
            ),
            //subtitle: Text('Popular Movies',style: TextStyle(color: Colors.white, fontSize: 13.0),),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfferScreen()),
                );
              },
              child: Ink(
                  child: Text('View All ',style: TextStyle(color: Colors.green, fontSize: 14.0),)
              ),
            ),
          ),
          offers.isEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(minHeight: 150,backgroundColor: Colors.cyan.shade50,color: Colors.cyan.shade200,),
          ) : OfferSection(offers: offers),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.alarm,size: 18.0,color: Colors.blue,),
                SizedBox(width: 10),
                Text('Upcoming Products',style: TextStyle(color: Colors.blue, fontSize: 16.0),),
              ],
            ),
            //subtitle: Text('Popular Movies',style: TextStyle(color: Colors.white, fontSize: 13.0),),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpcomingScreen()),
                );
              },
              child: Ink(
                  child: Text('View All ',style: TextStyle(color: Colors.blue, fontSize: 14.0),)
              ),
            ),
          ),
          upcomings.isEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(minHeight: 150,backgroundColor: Colors.cyan.shade50,color: Colors.cyan.shade200,),
          ) : UpcomingSection(upcomings: upcomings),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.card_travel,size: 18.0,color: Colors.orangeAccent,),
                SizedBox(width: 10),
                Text('Products For You',style: TextStyle(color: Colors.orange, fontSize: 16.0),),
              ],
            ),
            //subtitle: Text('Popular Movies',style: TextStyle(color: Colors.white, fontSize: 13.0),),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForyouScreen()),
                );
              },
              child: Ink(
                  child: Text('View All ',style: TextStyle(color: Colors.orange, fontSize: 14.0),)
              ),
            ),
          ),
          upcomings.isEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(minHeight: 150,backgroundColor: Colors.cyan.shade50,color: Colors.cyan.shade200,),
          ) : ForyouSection(foryou: foryou),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.category,size: 18.0,color: Colors.cyan,),
                SizedBox(width: 10),
                Text('More Categories For You',style: TextStyle(color: Colors.cyan, fontSize: 16.0),),
              ],
            ),
            //subtitle: Text('Popular Movies',style: TextStyle(color: Colors.white, fontSize: 13.0),),
            // trailing: InkWell(
            //   onTap: () {
            //     //Get.toNamed(LibraryPage.routeName);
            //   },
            //   child: Ink(
            //       child: Text('View All ',style: TextStyle(color: Colors.blueAccent, fontSize: 14.0),)
            //   ),
            // ),
          ),
          CategoriesSection(),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
