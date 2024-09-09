import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/villa_model.dart';
import 'appartFeed.dart';

class AppartList extends StatelessWidget {
  final String? userID;

  AppartList({super.key, this.userID});

  @override
  Widget build(BuildContext context) {
    final _apparts = Provider.of<List<Appart>>(context);
    return SliverList(delegate: SliverChildBuilderDelegate((_,index){
      return  AppartFeed(appart: _apparts[index], userID: userID,);
    },
    childCount: _apparts.length,
    )
    );
  }
}
