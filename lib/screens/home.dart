import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_ui/widgets/video.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<IconData> actionsIcons = [
    Icons.cast_sharp,
    Icons.notifications_outlined,
    Icons.search,
    Icons.account_circle
  ];
  List<String> categories = [
    "All",
    "Stoves",
    "Baking",
    "Movies",
    "Flutter",
    "React Native",
    "Coding is Love"
  ];

  String selectedCategory = "All";

  List videos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    final videosJson = await rootBundle.loadString("assets/data/data.json");
    final videosData = await json.decode(videosJson);
    setState(() {
      videos = videosData["items"];
    });
  }

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navBar(context),
      body: ListView.builder(
          controller: controller,
          itemCount: videos.length,
          itemBuilder: (context, i) {
            return Video(
              video: videos[i],
            );
          }),
    );
  }

  PreferredSizeWidget navBar(BuildContext context) {
    return ScrollAppBar(
      controller: controller,
      title: Image.asset(
        "assets/images/logo.png",
        height: 20,
        fit: BoxFit.contain,
      ),
      actions: actionsIcons
          .map((iconName) => IconButton(onPressed: () {}, icon: Icon(iconName)))
          .toList(),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.explore_outlined,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Explore",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                Wrap(
                    spacing: 5,
                    children: categories
                        .map((category) => FilterChip(
                            showCheckmark: false,
                            label: Text(
                              category,
                              style: TextStyle(
                                  color: selectedCategory == category
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            backgroundColor: Colors.grey.shade200,
                            selectedColor: Colors.grey.shade600,
                            selected: selectedCategory == category,
                            onSelected: (bool value) {
                              setState(() {
                                selectedCategory = category;
                              });
                            }))
                        .toList())
              ],
            ),
          )),
    );
  }
}
