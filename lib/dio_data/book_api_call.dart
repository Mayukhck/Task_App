import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/dio_data/fetch_books.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  late final Future<List<BooksListModel>> books;

  late List<BooksListModel> _books;
  late List<BooksListModel> _filteredBooks;

  @override
  void initState() {
    super.initState();
    books = fetchBooks(http.Client());
    fetchBooks(http.Client()).then((products) {
      setState(() {
        _books = products;
        _filteredBooks = products;
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _filteredBooks = [];
      if (enteredKeyword.isNotEmpty) {
        _filteredBooks = _books
            .where((book) =>
                book.name
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()) ||
                book.author
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
            .toList();
      } else {
        _filteredBooks = _books;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
              child: FutureBuilder<List<BooksListModel>>(
                future: books,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final List<BooksListModel> books = _filteredBooks.isNotEmpty
                        ? _filteredBooks
                        : snapshot.data!;
                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final BooksListModel book = books[index];
                        return Card(
                          child: ListTile(
                            title: Text(book.name),
                            subtitle: Text(book.author),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data found.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
