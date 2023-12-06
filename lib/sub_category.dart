import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubCategoryScreen extends StatelessWidget {
  final data;
  const SubCategoryScreen({super.key, required this.data});

  // final List categoriesList = const [
  //   {
  //     "image": "assets/images/babyshower.png",
  //     "name": "Baby Shower",
  //   },
  //   {
  //     "image": "assets/images/baby2.png",
  //     "name": "Baloons",
  //   },
  //   {
  //     "image": "assets/images/babyshower.png",
  //     "name": "Wedding",
  //   },
  //   {
  //     "image": "assets/images/baby2.png",
  //     "name": "Retirement",
  //   },
  //   {
  //     "image": "assets/images/babyshower.png",
  //     "name": "Quinciera",
  //   },
  //   {
  //     "image": "assets/images/babyshower.png",
  //     "name": "Dinner Party",
  //   },
  //   {
  //     "image": "assets/images/baby2.png",
  //     "name": "Decades",
  //   },
  //   {
  //     "image": "assets/images/baby2.png",
  //     "name": "Bar Mitzvah",
  //   },
  // ];

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
          child: Column(children: [
            Row(children: [
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
                children: [
                  Text(
                    data['name'],
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3C3C3C)),
                  ),
                  const Text(
                    'Sub Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 120,
                  crossAxisSpacing: 0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: .5, color: Colors.grey),
                              top: BorderSide(width: .5, color: Colors.grey),
                              left: BorderSide(width: .5, color: Colors.grey),
                              right:
                                  BorderSide(width: .5, color: Colors.grey))),
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              data['image'],
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data['name'],
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
          ]),
        )));
  }
}
