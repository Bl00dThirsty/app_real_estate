import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/villa_model.dart';
import '../utils/helpers/helper_functions.dart';
import '../views/detail/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
      routes: {
        '/detail': (context) => AppartDetail(),
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<DocumentSnapshot> _allResults = [];
  List<DocumentSnapshot> _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getClientStream();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    searchResultList();
  }

  void searchResultList() {
    List<DocumentSnapshot> showResults = [];
    if (_searchController.text.isNotEmpty) {
      for (var clientSnapShot in _allResults) {
        var name = clientSnapShot['appartName'].toString().toLowerCase();
        var location = clientSnapShot['appartLocation'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase()) ||
            location.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  Future<void> getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('apparts').orderBy('appartName').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ? Colors.black : Colors.white,
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
      ),
      body: ListView.builder(
        itemCount: _resultList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: dark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ListTile(
              leading: _resultList[index]['appartUrlImgs'] != null && _resultList[index]['appartUrlImgs'].isNotEmpty
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                                    _resultList[index]['appartUrlImgs'][0],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                                    },
                                  ),
                  )
                  : const Icon(Icons.image_not_supported),
              title: Text(
                _resultList[index]['appartName'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_resultList[index]['appartLocation']),
              onTap: () => Navigator.pushNamed(
                context,
                '/detail',
                arguments: _resultList[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}

