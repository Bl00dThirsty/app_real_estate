import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/villa_model.dart';

class AppartFeed extends StatefulWidget {
  final Appart? appart;
  final String? userID;

  const AppartFeed({super.key, this.appart, this.userID});

  @override
  State<AppartFeed> createState() => _AppartFeedState();
}

class _AppartFeedState extends State<AppartFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: widget.appart!.toMap(),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: CarouselSlider.builder(
                  itemCount: widget.appart?.appartUrlImgs?.length,
                  itemBuilder: (context, index, realIndex) {
                    return Image.network(
                      widget.appart!.appartUrlImgs![index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    viewportFraction: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.appart!.appartName!,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      const SizedBox(width: 28.0),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(formattingDate(widget.appart!.appartTimestamp)),
                    Text('${widget.appart!.appartPrice}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting('fr', null);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMd('fr');

    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
