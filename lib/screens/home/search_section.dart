import 'package:flutter/material.dart';
import 'package:yris/constants.dart';

import '../search/search_screen.dart';
// import 'package:expertjo/screens/servicelist/components/servicelist_screen.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    Key? key,
    //required this.size, required this.kOptions,
  }) : super(key: key);

  // final Size size;
  // final List<String> kOptions;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: myDefaultPadding * 0.15),
      padding: EdgeInsets.only(top: myDefaultPadding * 0.05),
      height: size.height * 0.055,
      //color: Colors.black,
      child: Stack(
        children: [
          Container(
            //height: size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Positioned(
            //top: 5,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: myDefaultPadding, vertical: 5),
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: myPrimaryColor.withOpacity(0.23),
                  ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Text("Search The Product You Need...",style: TextStyle(color: Colors.black.withOpacity(0.50)),),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchScreen()),
                        );
                      },
                      icon: Icon(Icons.search),
                      color: Colors.cyan,
                      padding: EdgeInsets.only(bottom: 1.0),
                    ),
                    // IconButton(
                    //   onPressed: (){
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(builder: (context) => ServiceListScreen(servicecats: kOptions)),
                    //     // );
                    //   },
                    //   icon: Icon(Icons.support_agent),
                    //   color: Colors.red,
                    //   padding: EdgeInsets.only(bottom: 02.0),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}