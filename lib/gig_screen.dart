import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plo_vendor/vendor_categories.dart';

class GigScreen extends StatefulWidget {
  const GigScreen({super.key});

  @override
  State<GigScreen> createState() => _GigScreenState();
}

class _GigScreenState extends State<GigScreen> {
  final searchController = TextEditingController();

  final List categoriesList = const [
    {'image': 'assets/images/baby1.png', 'title': 'Baby Shower'},
    {'image': 'assets/images/baby2.png', 'title': 'Bechelor Party'},
    {'image': 'assets/images/baby3.png', 'title': 'Birthday'},
    {'image': 'assets/images/baby1.png', 'title': 'Baby Shower'},
    {'image': 'assets/images/baby2.png', 'title': 'Bechelor Party'},
    {'image': 'assets/images/baby3.png', 'title': 'Birthday'},
  ];

  bool gigs = false;
  bool product = false;

  void showGig() {
    setState(() {
      gigs = true;
      product = false;
    });
  }

  void showProduct() {
    setState(() {
      gigs = false;
      product = true;
    });
  }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF5B5B5B),
                        ),
                        Text(
                          'Ashok Nagar, Jaipur',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5B5B5B)),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined,
                            color: Color(0xFF5B5B5B))
                      ],
                    ),
                    const Icon(Icons.notifications, color: Color(0xFF5B5B5B))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    filled: true,
                    suffixIcon: Icon(Icons.search),
                    fillColor: Color(0xFFDEDEDE),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFDEEEF7),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFDEEEF7),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFDEEEF7),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFDEEEF7),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showProduct();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .055,
                        width: MediaQuery.of(context).size.width * 1 / 2.3,
                        alignment: Alignment.center,
                        decoration: product
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFF903E3),
                                  Color(0xFF0A6DFE)
                                ]))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: const Color(0xFFF903E3))),
                        child: Text(
                          'Products',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: product
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFF903E3)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showGig();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * .055,
                        width: MediaQuery.of(context).size.width * 1 / 2.3,
                        decoration: gigs
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFF903E3),
                                  Color(0xFF0A6DFE)
                                ]))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: const Color(0xFFF903E3))),
                        child: Text(
                          'Gig',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: gigs
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFF903E3)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .015),
                product
                    ? Expanded(
                        child: Container(
                          child: const Center(
                            child: Text('Product List'),
                          ),
                        ),
                      )
                    : Container(),
                gigs
                    ? Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Browse Categories',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF5B5B5B)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VendorCategoriesScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'View More',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5B5B5B)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .2,
                              child: ListView.builder(
                                itemCount: categoriesList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        CircleAvatar(
                                          radius: 46,
                                          backgroundColor:
                                              const Color(0xFFFDC069),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 89,
                                            width: 89,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Image.asset(
                                              categoriesList[index]['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          categoriesList[index]['title'],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF5B5B5B)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10),
                                  itemCount: 8,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .135,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                              ),
                                              child: Image.asset(
                                                'assets/images/gridImage.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text(
                                                    'Gig Name',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF3C3C3C)),
                                                  ),
                                                  Text(
                                                    '₹ 899',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFF3C3C3C)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text(
                                                    '22 Hours Ago',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFFC1839F)),
                                                  ),
                                                  Text(
                                                    'Karnatka,India',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFFC1839F)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/rating.png',
                                                    width: 60,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
