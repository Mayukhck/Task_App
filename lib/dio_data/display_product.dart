import 'package:flutter/material.dart';

class DisplayProduct extends StatelessWidget {
  const DisplayProduct(
      {super.key,
      required this.productTitle,
      required this.productPrice,
      required this.productDescription,
      required this.productRating,
      required this.productCount});

  final String? productTitle;
  final String? productPrice;
  final String? productDescription;
  final String? productRating;
  final String? productCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Dio Data'),),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Text(productTitle.toString()),
              Text(productPrice.toString()),
              Text(productDescription.toString()),
              Text(productRating.toString()),
              Text(productCount.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
