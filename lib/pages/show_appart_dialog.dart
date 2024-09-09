import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/villa_model.dart';
import '../services/database_services.dart';
import '../shared_ui/showSnackBar.dart';
import '../utils/helpers/loaders.dart';

class AppartDialog {
  User? user;
  AppartDialog({this.user});

  void showAppartDialog(BuildContext context, ImageSource source) async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles == null || pickedFiles.isEmpty) return;

    final List<File> files = pickedFiles.map((file) => File(file.path)).toList();
    final _keyForm = GlobalKey<FormState>();
    String _appartName = '';
    String _appartDescription = '';
    int _appartPrice = 0;
    String _appartLocation = '';
    String _formError = 'Veuillez fournir plus d\'informations';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.grey,
                image: DecorationImage(
                  image: FileImage(files[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 40,
                          onChanged: (value) => _appartName = value,
                          validator: (value) => _appartName.isEmpty ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Nom du logement',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 250,
                          onChanged: (value) => _appartDescription = value,
                          validator: (value) => _appartDescription.isEmpty ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Description du logement',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _appartPrice = int.tryParse(value) ?? 0,
                          validator: (value) => _appartPrice <= 0 ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Prix du logement',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 250,
                          onChanged: (value) => _appartLocation = value,
                          validator: (value) => _appartLocation.isEmpty ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Localisation du logement',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () => onSubmit(context, _keyForm, files, _appartName, _appartDescription, _appartPrice, _appartLocation, user),
                          child: Text('Publier'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void onSubmit(BuildContext context, GlobalKey<FormState> keyForm, List<File> files, String appartName, String appartDescription, int appartPrice, String appartLocation, User? user) async {
    if (keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement....");
      DatabaseService db = DatabaseService();

      try {
        // Upload multiple files and get their URLs
        List<String> appartUrlImgs = await db.uploadFiles(files);

        // Add the apartment with the list of image URLs
        db.addAppart(Appart(
          appartName: appartName,
          appartDescription: appartDescription,
          appartPrice: appartPrice,
          appartLocation: appartLocation,
          appartUrlImgs: appartUrlImgs,
          appartUserID: user!.uid,
          appartUserName: user?.displayName,
        ));

        TLoaders.successSnackBar(title: 'cool!');
      } catch (e) {
        TLoaders.warningSnackBar(title: 'Oh snap', message: e.toString());
      }
    }
  }
}
