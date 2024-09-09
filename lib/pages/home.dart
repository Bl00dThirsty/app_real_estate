import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../models/villa_model.dart';
import '../theme/color.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import '../widgets/property_item.dart';
import 'home_appbar.dart';
import 'profile.dart';
import 'search_page.dart';
import 'pub_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePageContent(),
    SearchPage(),
    PubPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: _pages[_selectedIndex],
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home),
                      label: 'Accueil',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.search_normal),
                      label: 'Recherche',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.add_circle),
                      label: 'Publier',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.profile_circle),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: dark ? Colors.black : Colors.blue,
                  onTap: _onItemTapped,
                  backgroundColor: dark ? Colors.blue :  Colors.white,
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HomeAppBar(user: Provider.of<User?>(context)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logements",
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),

                  )
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/pub'),
                  child: Text('Publier?', style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.blue),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),),
                ),
              ],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 20)),
        _buildPopulars(context),
      ],
    );
  }

  Widget _buildPopulars(BuildContext context) {
    final _apparts = Provider.of<List<Appart>>(context);

    if (_apparts.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text('Aucun logement disponible')),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final appart = _apparts[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: appart.toMap(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: PropertyItem(appart: appart),
              ),
            ),
          );
        },
        childCount: _apparts.length,
      ),
    );
  }
}