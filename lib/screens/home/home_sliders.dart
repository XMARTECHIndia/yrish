import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yris/models/Slider.model.dart';

import '../../../constants.dart';
class Home_Slider extends StatelessWidget {
  const Home_Slider({
    Key? key,
    required this.sliders,
  }) : super(key: key);

  final List<SlidersModel> sliders;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: sliders.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(10.0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage( "$baseUrl/assets/slidersimg/"+sliders[itemIndex].sliderImg),
              ),
            ),
          ),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.22,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.97,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
  }
}