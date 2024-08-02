
import 'package:app_real_estate/pages/pub_page.dart';
import 'package:app_real_estate/pages/root.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/color.dart';
import '../utils/data.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_textbox.dart';
import '../widgets/icon_box.dart';
import '../widgets/property_item.dart';
import '../widgets/recent_item.dart';
import '../widgets/recommend_item.dart';
import 'home_appbar.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(child: CustomScrollView(
        slivers: [
          HomeAppBar(user: _user),
          SliverToBoxAdapter(child: _buildBody(),),

        ],
      )
      ),
    );
  }
  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          _buildSearch(),
          const SizedBox(
            height: 20,
          ),
          _buildCategories(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Populaire",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/pub'), child: Text('Tout voir'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildPopulars(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "voir",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecent(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/search'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            IconBox(
              child: Icon(Icons.search_outlined, color: Colors.white),
              bgColor: AppColor.secondary,
              radius: 10,
            )
          ],
        ),
      ),
    );
  }

  int _selectedCategory = 0;
  Widget _buildCategories() {
    List<Widget> lists = List.generate(
      categories.length,
          (index) => CategoryItem(
        data: categories[index],
        selected: index == _selectedCategory,
        onTap: () {
          setState(() {
            _selectedCategory = index;
          });
        },
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget _buildPopulars() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 240,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .8,
      ),
      items: List.generate(
        populars.length,
            (index) => PropertyItem(
          data: populars[index],
        ),
      ),
    );
  }

  Widget _buildRecommended() {
    List<Widget> lists = List.generate(
      recommended.length,
          (index) => RecommendItem(
        data: recommended[index],
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget _buildRecent() {
    List<Widget> lists = List.generate(
      recents.length,
          (index) => RecentItem(
        data: recents[index],
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }
}






