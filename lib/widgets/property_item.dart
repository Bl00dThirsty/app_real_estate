import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/color.dart';
import 'custom_image.dart';
import 'icon_box.dart';
import 'package:flutter/material.dart';
import '../models/villa_model.dart';

class PropertyItem extends StatelessWidget {
  final Appart appart;
  final String? userID;

  const PropertyItem({super.key, required this.appart, this.userID});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.network(
            appart.appartUrlImg!,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 20,
            top: 130,
            child: _buildFavorite(),
          ),
          Positioned(
            left: 15,
            top: 160,
            child: _buildInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorite() {
    return Icon(
      Iconsax.heart,
      color: Colors.red,
      size: 20,
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appart.appartName!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Publié par: ${appart.appartUserName}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text('Prix: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            Text(
              '${appart.appartPrice} FCFA',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text('Localisation: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            Text(
              '${appart.appartLocation}',
              style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
