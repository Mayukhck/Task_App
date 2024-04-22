import 'package:task_app/dio_data/display_product.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:task_app/dio_data/product.dart';

class ApiCall extends StatelessWidget {
  const ApiCall({super.key});

  Future<List<Product>> fextchApi() async {
    Dio dio = Dio();
    var response = await dio.get('https://fakestoreapi.com/products');
    final List<dynamic> responseData = response.data;

    List<Product> products = responseData.map((json) => Product.fromJson(json)).toList();
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fextchApi(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayProduct(
                              productTitle: '${snapshot.data![index]['title']}',
                              productPrice: '${snapshot.data![index]['price']}',
                              productDescription:
                                  '${snapshot.data![index]['description']}',
                              productRating:
                                  '${snapshot.data![index]['rating']['rate']}',
                              productCount:
                                  '${snapshot.data![index]['rating']['count']}'),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('${snapshot.data![index]['title']}'),
                        subtitle: Text('${snapshot.data![index]['price']}'),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
