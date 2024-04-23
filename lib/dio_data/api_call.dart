import 'package:task_app/dio_data/display_product.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiCall extends StatelessWidget {
  const ApiCall({super.key, required this.searchQuery});

  final String searchQuery;

  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();
    var response = await dio.get('https://fakestoreapi.com/products');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchApi(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          List<dynamic> filteredData = snapshot.data!
              .where((product) => product['title']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          if (filteredData.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }

          return ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayProduct(
                        productTitle: '${filteredData[index]['title']}',
                        productPrice: '${filteredData[index]['price']}',
                        productDescription:
                            '${filteredData[index]['description']}',
                        productRating:
                            '${filteredData[index]['rating']['rate']}',
                        productCount:
                            '${filteredData[index]['rating']['count']}',
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text('${filteredData[index]['title']}'),
                    subtitle: Text('${filteredData[index]['price']}'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
