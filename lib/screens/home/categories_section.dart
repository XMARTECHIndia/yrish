import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yris/constants.dart';

import '../../models/Categories.model.dart';
import '../products/products_screen.dart';
class CategoriesSection extends StatefulWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  _CategoriesSectionState createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  List<CategoriesModel> GNdetails = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Dio().post("$baseUrl/category_api_parentcat",
      data: {
        "parentcat": "General"
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data) {
      setState(() {
        //print(data.data);
        this.GNdetails = categoriesModelFromJson(data.data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: GNdetails.length ,
          itemBuilder: (ctx, i) {
            var cats = GNdetails[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductsScreen(tempcatid:cats.catId)),
                );
              },
              child: Card(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              "$baseUrl/assets/categoryimg/"+GNdetails[i].catImg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Center(
                            child: Text(
                              cats.catName,
                              style: const TextStyle(
                                fontSize: 12,
                                //fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: 150,
          ),
        ),
      ),
    );
  }
}
