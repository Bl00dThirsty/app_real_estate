
import 'package:app_real_estate/widgets/property_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../models/villa_model.dart';

//var profile = NetworkImage(user!.photoURL);

// <AppartModel>

List recommended = [
  {
    "image": "https://th.bing.com/th?id=OIF.fRG%2fWLZdNyzf2NHL9zypdg&w=257&h=193&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "name": "Chambre",
    "price": "XFA 180k",
    "location": "Nkodengui (Yaoundé), Cameroon",
    "is_favorited": true,
  },
  {
    "image": "https://th.bing.com/th/id/OIF.BwnmckzVndAmC1nsEA1Dqw?w=239&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "name": "Maison moderne",
    "price": "XFA 175k",
    "location": "Nkolndongo (Yaoundé), Cameroon",
    "is_favorited": false,
  },
  {
    "image": "https://th.bing.com/th/id/OIP.pbCHP0gs_U7YEkEP5uEYJwHaFj?w=197&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "name": "Maison moderne",
    "price": "XFA 180k",
    "location": "Nkolndongo (Yaoundé), Cameroun",
    "is_favorited": true,
  },
];

List recents = [
  {
    "image": "https://th.bing.com/th/id/OIP.27YDCX8U4yXiuRGkrLBUrwHaFj?w=212&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "name": "Villa",
    "price": "XFA 180k",
    "location": "Biteng",
    "is_favorited": false,
  },
  {
    "image": "",
    "name": "Studio moderne",
    "price": "XFA 150k",
    "location": "Biyem-Assi",
    "is_favorited": false,
  },
  {
    "image": "",
    "name": "Appartement moderne",
    "price": "XFA 180k",
    "location": "Etam Bafia",
    "is_favorited": false,
  },
];

List categories = [
  {
    "name" : "Tout",
    "icon" :  Iconsax.buildings_2
  },
  {
    "name" : "Maison",
    "icon" :  Iconsax.home_15
  },
  {
    "name" : "Boutique",
    "icon" :  Iconsax.shop
  },
  {
    "name" : "Appartement",
    "icon" :  Iconsax.building
  },
  {
    "name" : "Villa",
    "icon" :  Iconsax.building_3
  },
];

var brokers = [
    {
    "image": "https://media.istockphoto.com/id/1822009439/photo/business-happy-and-walking-black-man-on-city-journey-commute-trip-and-real-estate-agent-smile.jpg?s=1024x1024&w=is&k=20&c=Wmp8iTwF9ljl3a6RlINK5Vz89KhXvTk7Ctmr3ciWvSg=",
    "name": "John Davis",
    "type": "Broker", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
  {
    "image":"https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name" : "Chuck Norris",
    "type": "Broker", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
  {
    "image" : "https://media.istockphoto.com/id/1417249939/photo/young-african-american-man-with-afro-hair-with-fist-raised-as-anti-racist-symbol.jpg?s=1024x1024&w=is&k=20&c=jisHt02ThvX0REu8n8lPFYz9RCkGCyPWzoRRAY5zHZk=",
    "name": "Paul Biya (Le vrai)",
    "type": "Broker", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
  {
    "image" : "https://media.istockphoto.com/id/1587427094/photo/phone-walking-and-a-business-black-woman-in-the-city-searching-for-directions-or-typing-a.jpg?s=1024x1024&w=is&k=20&c=6-6ety7JoSksGToIzHeO02Nw-poOk2QGiDh5ZHM7pWI=",
    "name": "Kombi d'efoulan",
    "type": "Broker", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
];

List companies = [
  {
    "image": "https://images.unsplash.com/photo-1549517045-bc93de075e53?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "TS Home",
    "location": "Nkolndongo (Yaoundé), Cameroun",
    "type": "Broker",
    "is_favorited": false,
    "icon" : Icons.domain_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1618221469555-7f3ad97540d6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Polo237",
    "location": "Nkolndongo (Yaoundé), Cameroun",
    "type": "Broker",
    "is_favorited": true,
    "icon" : Icons.house_siding_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Dabest Pro",
    "location": "Nkolndongo (Yaoundé), Cameroun",
    "type": "Broker",
    "is_favorited": true,
    "icon" : Icons.home_work_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Cam Reality",
    "location": "Anguissa (Yaoundé), Cameroun",
    "type": "Broker",
    "is_favorited": true,
    "icon" : Icons.location_city_rounded
  },
];