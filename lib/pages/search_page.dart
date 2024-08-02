import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _allResults = [];
  List _resultList = [];

  final TextEditingController _searchController =TextEditingController();

  void initState() {
    getClientStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

    searchResultList () {
      var showResults = [];


      if (_searchController.text != "") {
        for (var clientSnapShot in _allResults) {
          var name = clientSnapShot['appartName'].toString().toLowerCase();
          if (name.contains(_searchController.text.toLowerCase())) {
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
  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('apparts').orderBy('appartName').get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
  _searchController.removeListener(_onSearchChanged);
  _searchController.dispose();
    super.dispose();
  }
  @override
  void didChangedDependencies() {
    getClientStream();
    super .didChangeDependencies();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CupertinoSearchTextField(
            controller: _searchController,
          ),
        ),
        body: ListView.builder(
            itemCount: _resultList.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(_resultList[index]['appartName'],),
                subtitle: Text(_resultList[index]['appartUserName'],),
              );
            }),

      ),
    );
  }
}
