import 'package:badges/badges.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yris/constants.dart';
import 'package:yris/models/Foryou.model.dart';
import 'package:yris/models/Upcoming.model.dart';

import '../product/product_screen.dart';

class ForyouSection extends StatefulWidget {
  const ForyouSection({
    Key? key, required this.foryou,
  }) : super(key: key);
  final List<ForyouModel> foryou;
  @override
  _ForyouSectionState createState() => _ForyouSectionState();
}

class _ForyouSectionState extends State<ForyouSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: widget.foryou
            .isEmpty /* Dont call CarouselSlider when data length is 0 or less */
            ? const SizedBox.shrink()
            :Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          height: 170.0,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.foryou.length,
              itemBuilder: (BuildContext context, int index) {
                var foryouitem = widget.foryou[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductScreen(tempproid:foryouitem.proId)),
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
                                  image: NetworkImage("$baseUrl/assets/productimg/"+foryouitem.proImg)
                              )
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 5,
                            child:Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor: Colors.orange,
                              borderRadius: BorderRadius.circular(2),
                              badgeContent:
                              Row(
                                children: [
                                  //Icon(Icons.alarm,size: 14.0,color: Colors.white,),
                                  Text(" You May Like", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)
                                ],
                              ),
                              //badgeContent: Text((foryouitem.inOffer == "1" ? "IN OFFER" : "BESTSELLER"), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                              child: Text(foryouitem.proName,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),),
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


