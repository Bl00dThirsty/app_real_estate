import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
        borderRadius: BorderRadius.circular(10),
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: PageView.builder(
              itemCount: appart.appartUrlImgs?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(
                  appart.appartUrlImgs?[index] ?? 'default_image_url',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error, color: Colors.red));
                  },
                );
              },
            ),
          ),
          Positioned(
            left: 15,
            top: 130,
            child: _buildInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.001),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2,color: Colors.white.withOpacity(0.1)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appart.appartName ?? 'Nom non disponible',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Publié par: ${appart.appartUserName ?? 'Utilisateur inconnu'}',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Prix: ', style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600)),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
