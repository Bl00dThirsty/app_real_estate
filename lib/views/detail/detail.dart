import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/villa_model.dart';

class AppartDetail extends StatelessWidget {
  const AppartDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _userID = Provider.of<User?>(context)?.uid;

    // Créer un objet Appart à partir du Map<String, dynamic>
    final appart = Appart(
      appartID: data['appartID'],
      appartName: data['appartName'],
      appartDescription: data['appartDescription'],
      appartPrice: data['appartPrice'],
      appartLocation: data['appartLocation'],
      appartUrlImgs: List<String>.from(data['appartUrlImgs']),
      appartUserID: data['appartUserID'],
      appartUserName: data['appartUserName'],
      appartFavoriteCount: data['appartFavoriteCount'],
      appartTimestamp: data['appartTimestamp'],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appart.appartName ?? 'Nom non disponible',
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PageView.builder(
                    itemCount: appart.appartUrlImgs?.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        appart.appartUrlImgs![index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appart.appartName ?? 'Nom non disponible',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Localisation: ${appart.appartLocation}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Prix: ${appart.appartPrice} XFA',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${appart.appartDescription}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Ajoutez d'autres détails de l'appartement ici
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
