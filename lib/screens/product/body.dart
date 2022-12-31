import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';
import '../../models/Product.model.dart';
import '../../models/Slider.model.dart';


class Body extends StatefulWidget{
  const Body({Key? key, required this.tproid}) : super(key: key);
  final String tproid;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProductModel> product = [];
  List<SlidersModel> sliders = [];
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
    Dio().get("$baseUrl/sliders_api", options: Options(
      responseType: ResponseType.plain,
    ),
    ).then((data){
      setState(() {
        this.sliders = slidersModelFromJson(data.data.toString());

      });
    });
    product = [];
    Dio().post("$baseUrl/product_api_by_id",
      data:{
        "pro_id": widget.tproid
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        //print(data.data);
        if(productModelFromJson(data.data.toString()).length > 0) {
          product = productModelFromJson(data.data.toString());
        }
      });
    });

    // Dio().post("$baseUrl/category_api_parentcat",
    //   data:{
    //     "parentcat": "General"
    //   },
    //   options: Options(
    //     responseType: ResponseType.plain,
    //   ),
    // ).then((data){
    //   setState(() {
    //     //print(data.data);
    //     this.GNdetails = categoriesModelFromJson(data.data.toString());
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child:
      Column(
        children: [
          CarouselSlider.builder(
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
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new NetworkImage(
                    "$baseUrl/assets/productimg/"+product.first.proImg),
                  fit: BoxFit.fill,
                ),
                borderRadius:
                BorderRadius.circular(80.0),
              ),
            ),
          ),
          Center(
            child: Text(product.first.proName),
          ),
        ],
      ),
    );
  }
}
