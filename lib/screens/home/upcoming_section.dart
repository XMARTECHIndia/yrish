import 'package:badges/badges.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yris/constants.dart';
import 'package:yris/models/Upcoming.model.dart';

import '../product/product_screen.dart';

class UpcomingSection extends StatefulWidget {
  const UpcomingSection({
    Key? key, required this.upcomings,
  }) : super(key: key);
  final List<UpcomingModel> upcomings;
  @override
  _UpcomingSectionState createState() => _UpcomingSectionState();
}

class _UpcomingSectionState extends State<UpcomingSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: widget.upcomings
            .isEmpty /* Dont call CarouselSlider when data length is 0 or less */
            ? const SizedBox.shrink()
            :Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          height: 170.0,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.upcomings.length,
              itemBuilder: (BuildContext context, int index) {
                var upcomingitem = widget.upcomings[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductScreen(tempproid:upcomingitem.proId)),
                    );
                  },
                  child: Stack(
                      children:[
                        Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("$baseUrl/assets/productimg/"+upcomingitem.proImg)
                            )
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 5,
                            child:Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor: (upcomingitem.inOffer == "1" ? Colors.green : Colors.blue),
                              borderRadius: BorderRadius.circular(5),
                              badgeContent:
                              Row(
                                children: [
                                  Icon(Icons.alarm,size: 14.0,color: Colors.white,),
                                  Text(" Coming Soon", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)
                                  // CountDownText(
                                  //   due: DateTime.parse("2023-01-01 00:00:00"),
                                  //   finishedText: "Done",
                                  //   showLabel: true,
                                  //   longDateName: true,
                                  //   daysTextLong: " D ",
                                  //   hoursTextLong: " H ",
                                  //   minutesTextLong: " M ",
                                  //   secondsTextLong: " S ",
                                  //   style: TextStyle(color: Colors.white, fontSize: 12),
                                  // ),
                                ],
                              ),
                              //badgeContent: Text((upcomingitem.inOffer == "1" ? "IN OFFER" : "BESTSELLER"), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            )
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width: 150,
                          alignment: Alignment.bottomLeft,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.cyanAccent.withOpacity(0.0),
                                Colors.cyan.withOpacity(0.1),
                                Colors.cyan.withOpacity(0.3),
                                Colors.cyan.withOpacity(0.9)
                                //Color(0xff151d26).withOpacity(0.9)
                              ],
                            ),
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top:20.0),
                              child: Text(upcomingitem.proName,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),),
                            ),
                          ),
                        ),
                      ]
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}


