import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yris/constants.dart';
import 'package:yris/models/Offer.model.dart';

import '../product/product_screen.dart';

class OfferSection extends StatefulWidget {
  const OfferSection({
    Key? key, required this.offers,
  }) : super(key: key);
  final List<OfferModel> offers;
  @override
  _OfferSectionState createState() => _OfferSectionState();
}

class _OfferSectionState extends State<OfferSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: widget.offers
              .isEmpty /* Dont call CarouselSlider when data length is 0 or less */
              ? const SizedBox.shrink()
              :Container(
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            height: 170.0,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.offers.length,
                itemBuilder: (BuildContext context, int index) {
                  var offeritem = widget.offers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen(tempproid:offeritem.proId)),
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
                                  image: NetworkImage("$baseUrl/assets/productimg/"+offeritem.proImg)
                              )
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 5,
                              child:Badge(
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: (offeritem.inOffer == "1" ? Colors.green : Colors.blue),
                                borderRadius: BorderRadius.circular(2),
                                badgeContent: Text((offeritem.inOffer == "1" ? "IN OFFER" : "BESTSELLER"), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                                ],
                              ),
                            ),
                            child: ListTile(
                              //leading: FlutterLogo(size: 72.0),
                              title: Padding(
                                padding: const EdgeInsets.only(top:20.0),
                                child: Text(offeritem.proName,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),),
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


