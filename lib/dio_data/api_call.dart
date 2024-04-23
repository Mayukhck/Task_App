import 'package:task_app/dio_data/display_product.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  
  late List<dynamic> _products;
  late List<dynamic> _filteredProducts;

  @override
  void initState() {
    super.initState();
    fetchApi().then((products) {
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    });
  }

  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();
    var response = await dio.get('https://fakestoreapi.com/products');
    return response.data;
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _filteredProducts = _products.where((product) {
        return product['title']
            .toString()
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text('No products found!'),
                    )
                  : ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayProduct(
                                  productTitle:
                                      '${_filteredProducts[index]['title']}',
                                  productPrice:
                                      '${_filteredProducts[index]['price']}',
                                  productDescription:
                                      '${_filteredProducts[index]['description']}',
                                  productRating:
                                      '${_filteredProducts[index]['rating']['rate']}',
                                  productCount:
                                      '${_filteredProducts[index]['rating']['count']}',
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title:
                                  Text('${_filteredProducts[index]['title']}'),
                              subtitle:
                                  Text('${_filteredProducts[index]['price']}'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
