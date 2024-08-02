import 'package:app_real_estate/shared_ui/appartFeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/villa_model.dart';

class AppartList extends StatelessWidget {
  final String? userID;

  const AppartList({this.userID});

  @override
  Widget build(BuildContext context) {
    final _apparts = Provider.of<List<Appart>>(context);
    return SliverList(delegate: SliverChildBuilderDelegate((_,index){
      return AppartFeed(appart: _apparts[index], userID: userID,);
    },
    childCount: _apparts.length,
    ));
  }
}
