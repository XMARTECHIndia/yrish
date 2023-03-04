import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yris/models/Invoice.model.dart';
import 'package:yris/screens/order/myorders_screen.dart';

import '../../constants.dart';
import '../../models/Orderdetails.model.dart';
class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key, required  this.orderid, required this.invoicedate}) : super(key: key);
  final String orderid;
  final String invoicedate;
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<InvoiceModel> myinvoice = [];
  List<OrderDetailsModel> orderdeatils = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinvoice();
    getorderdetails();
  }

  getinvoice(){
    Dio().post("$baseUrl/get_order_api",
      data:{
        "orderid": widget.orderid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        myinvoice = invoiceModelFromJson(data.data.toString());
      });
    });
  }
  getorderdetails(){
    Dio().post("$baseUrl/checkorder_api",
      data:{
        "oid": widget.orderid,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    ).then((data){
      setState(() {
        orderdeatils = orderDetailsModelFromJson(data.data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (BuildContext context) => MyOrderScreen())),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('INVOICE',style: TextStyle(color: Colors.cyan),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invoice #: "+widget.orderid,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),),
                  Text("Order On: "+widget.invoicedate,style: TextStyle(color: Colors.black54),),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bill To",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),textAlign: TextAlign.left,),
                    myinvoice.isEmpty ? Text("") :Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Badge(
                        toAnimate: false,
                        shape: BadgeShape.square,
                        badgeColor: (myinvoice[0].delvStatus=="Delivered" ? Colors.green : Colors.cyan),
                        borderRadius: BorderRadius.circular(4),
                        badgeContent: Text(myinvoice[0].delvStatus,style: const TextStyle(color: Colors.white,)),
                        //child: Icon(Icons.notifications),
                      ),
                    ),
                  ],
              ),
              Container(
                //mainAxisAlignment: MainAxisAlignment.start,
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((myinvoice.isEmpty?"":myinvoice[0].billToName)),
                      Text((myinvoice.isEmpty?"":myinvoice[0].billToAddress)),
                      Text((myinvoice.isEmpty?"":"+91-"+myinvoice[0].billToPhone)),
                      Text((myinvoice.isEmpty?"":"GSTIN: "+myinvoice[0].billToGstin)),
                    ],
                  ),

              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Table(
                  //defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width*0.19),
                  columnWidths: {
                    0: FlexColumnWidth(4.5),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(3),
                    4: FlexColumnWidth(3),
                  },
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1),
                  children: [
                    TableRow( children: [
                      Column(children:[Text('Item', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))]),
                      Column(children:[Text('Rate', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))]),
                      Column(children:[Text('Qty', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))]),
                      Column(children:[Text('GST', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))]),
                      Column(children:[Text('Amount', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))]),
                    ]),
                    for (var odetails in orderdeatils)
                      TableRow(children: [
                        Column(children: [
                          Text(odetails.itemName),
                          Text("HSN: "+odetails.itemHsn,style: TextStyle(color: Colors.black54),),
                        ]),
                        Column(children: [Text(odetails.itemRate)]),
                        Column(children: [Text(odetails.itemQty)]),
                        Column(children: [
                          Text("CGST " + odetails.itemCgst),
                          Text("SGST " + odetails.itemSgst)
                        ]),
                        Column(children: [Text("₹"+odetails.itemAmount)]),
                      ]),
                  ],
                ),
              ),
              Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),),
                  Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].invoiceTotal+".00"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold, ),),
                ],
              ),
              Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CGST",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, ),),
                  Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].invoiceCgst),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400, ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SGST",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, ),),
                  Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].invoiceSgst),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400, ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, ),),
                  Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].discountAmt+".00"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400, ),),
                ],
              ),
              Divider(thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Payable",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),),
                  Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].payableAmt+".00"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold, ),),
                ],
              ),
              Divider(thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delevery Details",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),),
                  //Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].payableAmt+".00"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold, ),),
                ],
              ),
              Container(
                //mainAxisAlignment: MainAxisAlignment.start,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text((myinvoice.isEmpty?"":"Address: "+myinvoice[0].delvAddress)),
                    myinvoice.isEmpty?Text(""):Text((myinvoice[0].delvStatus=="Delivered" ? "Delived on: "+DateFormat("y-MM-dd").format(myinvoice[0].delvStatusOn): "Expected Date of Delivery: "+DateFormat("y-MM-dd").format(myinvoice[0].expDelvOn))),
                    Text((myinvoice.isEmpty?"":"Delivery Note: "+myinvoice[0].delvStatusNote)),
                  ],
                ),

              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Details",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, ),),
                  //Text((myinvoice.isEmpty?"":"₹"+myinvoice[0].payableAmt+".00"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold, ),),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((myinvoice.isEmpty?"":"Payment Method: "+myinvoice[0].payMode)),
                      Text((myinvoice.isEmpty?"":"Payment Status: "+myinvoice[0].payStatus)),
                      Text((myinvoice.isEmpty?"":"Transaction ID: "+myinvoice[0].transactionId)),

                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
