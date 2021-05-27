
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/models/order_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel order;

  OrderDetailsView({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(text: 'Order ID: ', children: [
                      TextSpan(
                          text: order.id,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  Text.rich(
                    TextSpan(text: 'Order Time: ', children: [
                      TextSpan(
                          text: DateFormat('dd/MM/yyy hh:mm')
                              .format(order.dateTime),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  Text.rich(
                    TextSpan(text: 'Total: ', children: [
                      TextSpan(
                          text: order.total.toStringAsFixed(2) + ' LE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  Text.rich(
                    TextSpan(text: 'Payment method: ', children: [
                      TextSpan(
                          text: 'Cash',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Text('${order.address.mobile}\n${order.address.address}',style: TextStyle(color: Colors.black),)
                  /* Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: SizeConfig.defaultSize*3,
                          child: FlatButton(
                        child: Text('Show details',style: TextStyle(color: Colors.blue),),
                        onPressed: () {},
                      ))
                    ],
                  ) */
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize,
                  vertical: SizeConfig.defaultSize * 2),
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: 'Shipment Details',
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                size: SizeConfig.defaultSize * 1.8,
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey.shade400,
                    spreadRadius: 0.5,
                    offset: Offset(0.9, 0))
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(text: 'Shipment Status\n', children: [
                      TextSpan(
                          text: order.status,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.8,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize,
                  ),
                  StatusRow(
                    status: order.status.toLowerCase(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.defaultSize * 0.5,
                        bottom: SizeConfig.defaultSize * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'InProcessing',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.defaultSize * 1.4),
                        ),
                        Text('Shipped    ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.defaultSize * 1.4)),
                        Text('Delivered ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.defaultSize * 1.4))
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(text: 'Shipment Fees: \n', children: [
                      TextSpan(
                          text: '0.00 LE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.black))
                    ]),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 3,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: order.products.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    itemBuilder: (context, index) => OrderDetailCard(
                      img: order.products[index].img,
                      name: order.products[index].name,
                      price: order.products[index].price.toStringAsFixed(2),
                      qty: order.products[index].quantity.toString(),
                      delivered: order.status,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize*2,)
          ],
        ),
      ),
    );
  }
}

class OrderDetailCard extends StatelessWidget {
  final String name;
  final String img;
  final String qty;
  final String price;
  final String delivered;
  OrderDetailCard({this.name, this.img, this.qty, this.price,this.delivered});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: SizeConfig.defaultSize * 5,
                    right: SizeConfig.defaultSize * 2),
                height: SizeConfig.defaultSize * 7,
                width: SizeConfig.defaultSize * 7,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(img))),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black),
              ),
              Text('Qty:' + qty,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Colors.black)),
              Text(price + ' LE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Colors.black)),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              delivered=='Delivered'? RaisedButton(
                onPressed: () {},
                child: Text(
                  'Return item',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ):Container()
            ],
          )
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String status;

  StatusRow({this.status = 'inprocess'});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 12,
            backgroundColor: Colors.greenAccent.shade400,
            child: Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 20,
            )),
        Container(
          height: 5,
          color: (status == 'shipped' || status == 'delivered')
              ? Colors.greenAccent.shade400
              : Colors.grey.shade400,
          width: SizeConfig.defaultSize * 15,
        ),
        CircleAvatar(
            radius: 12,
            backgroundColor: (status == 'shipped' || status == 'delivered')
                ? Colors.greenAccent.shade400
                : Colors.grey.shade400,
            child: Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 20,
            )),
        Container(
          height: 5,
          color: (status == 'delivered')
              ? Colors.greenAccent.shade400
              : Colors.grey.shade400,
          width: SizeConfig.defaultSize * 15,
        ),
        CircleAvatar(
            radius: 12,
            backgroundColor: (status == 'delivered')
                ? Colors.greenAccent.shade400
                : Colors.grey.shade400,
            child: Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 20,
            )),
      ],
    );
  }
}
