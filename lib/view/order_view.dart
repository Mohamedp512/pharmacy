import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/order_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/models/order_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/order_details_view.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: CustomText(
            text: 'My Order',
            color: Colors.white,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back(result: 'order');
            },
          ),
        ),
        body: GetBuilder<OrderViewModel>(
          init:Get.find(),
          builder: (controller) => controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.orders.length == 0
                  ? Center(
                      child: Text('No orders'),
                    )
                  : Container(
                      child: ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) =>
                            _orderCard(controller.orders[index]),
                      ),
                    ),
        ));
  }

  Widget _orderCard(OrderModel order) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    text: DateFormat('dd/MM/yyy hh:mm').format(order.dateTime),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.black))
              ]),
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: order.products.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.network(order.products[index].img),
                      title: Text(order.products[index].name),
                      subtitle:
                          Text.rich(TextSpan(text: 'Quantity: ', children: [
                        TextSpan(
                            text: order.products[index].quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ])),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.defaultSize,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status'),
                            Row(
                              children: [
                                CustomText(
                                  text: order.status,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            CustomText(
                              text: 'Rate this product',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.defaultSize * 1.6,
                            ),
                            /* IconButton(icon: Icon(Icons.star_border,color: Colors.amberAccent[700],),onPressed: (){},) */
                            GetBuilder<OrderViewModel>(
                              init: Get.find(),
                              builder: (controller) => Row(
                                children: List<Widget>.generate(5, (pos) {
                                  return GestureDetector(
                                    child: pos <
                                            order.products[index].currentRating
                                        ? Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          )
                                        : Icon(Icons.star_border_outlined),
                                    onTap: () async {
                                      print(pos + 1);
                                      print(order.products[index].productId);
                                      print(order.id);
                                     //print(controller.reviews.length) ;
                                    // controller.addReview(orderId: order.id,product: order.products[index]);
                                     
                                      controller.addReview(orderId: order.id,
                                          product: order.products[index],
                                          rate: pos + 1);
                                          print('rating');
                                          print(order.products[index].currentRating);
                                     
                                     // controller.getRate(order.id,order.products[index].productId);
                                     
                                     /*  await controller.rateProduct(
                                          product: order.products[index],
                                          rate: pos + 1,
                                          orderId: order.id,
                                          index: index); */
                                    },
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Get.to(OrderDetailsView(
                  order: order,
                ));
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View order details',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.chevron_right)
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
