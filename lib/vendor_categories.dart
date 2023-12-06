import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plo_vendor/sub_category.dart';

class VendorCategoriesScreen extends StatelessWidget {
  const VendorCategoriesScreen({super.key});

  final List categoriesList = const [
    {
      "image": "assets/images/babyshower.png",
      "name": "Baby Shower",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/baby2.png",
      "name": "Baloons",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/babyshower.png",
      "name": "Wedding",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/baby2.png",
      "name": "Retirement",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/babyshower.png",
      "name": "Quinciera",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/babyshower.png",
      "name": "Dinner Party",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/baby2.png",
      "name": "Decades",
      'routeName': '/sub_category'
    },
    {
      "image": "assets/images/baby2.png",
      "name": "Bar Mitzvah",
      'routeName': '/sub_category'
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xFFF5F5F5)));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/Back button.png',
                      color: const Color(0xFF555555),
                      width: 45,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Vendor Categories',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3C3C3C)),
                    ),
                    Text(
                      'What Are You Offering',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: categoriesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 120,
                  crossAxisSpacing: 0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryScreen(
                                  data: categoriesList[index],
                                )),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: .5, color: Colors.grey),
                              top: BorderSide(width: .0, color: Colors.grey),
                              left: BorderSide(width: 1, color: Colors.grey),
                              right: BorderSide(width: 1, color: Colors.grey))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              categoriesList[index]['image'],
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categoriesList[index]['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
