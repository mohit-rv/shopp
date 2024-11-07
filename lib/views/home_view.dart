import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/drawer/drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Utils/colors.dart';
import '../controller/home_controller.dart';
import '../widgets/custom_navigation_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            key:_scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: Image.asset('assets/images/logo.png',height:80,width:80,),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right:15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.search, color: Colors.black,size:35,),
                      const SizedBox(width: 10,),
                      Image.asset('assets/images/scanner.png',height:25,width:25,)
                    ],
                  ),
                )
              ],
            ),
            drawer: MyDrawer(userData:controller.userData,),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Hi, ${controller.userData.isNotEmpty ? controller.userData[0]['name'] : ''}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const AutoSizeText(
                              'What are you looking for today?',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CarouselSlider.builder(
                        itemCount: controller.carouselItems.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                          return Card(
                            margin: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Image.asset(
                                controller.carouselItems[itemIndex],
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay:false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          onPageChanged: controller.callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.activeIndex,
                          count: controller.carouselItems.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor:AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              CategoryTab(title: 'Recommend', index: 0),
                              CategoryTab(title: 'Cell Phone', index: 1),
                              CategoryTab(title: 'Car Products', index: 2),
                              CategoryTab(title: 'Department Store', index: 3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 9.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 190.0,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 6,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor:AppColors.lightColor,
                            highlightColor:AppColors.lightColor,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color:AppColors.primary
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color:AppColors.secondary
                                        .withOpacity(0.3),
                                    borderRadius:
                                    BorderRadius.circular(1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          height: 14,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          height: 16,
                                          width: 40,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:4,
                          crossAxisSpacing: 9.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 120.0,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.productList.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          var product = controller.productList[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.secondary
                                          .withOpacity(0.3),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(15),
                                  ),
                                  child: Image.asset(
                                    product['image'],
                                    height: 60,
                                    width:80,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                AutoSizeText(product['title'] ?? '', overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color:AppColors.blackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: controller.productsList2.length,
                      itemBuilder: (context, index) {
                        var product = controller.productsList2[index];
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                        image: DecorationImage(
                                          image: AssetImage(product['image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(product['title'],
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText('\$${product['price']}',
                                                style: const TextStyle(color: Colors.orange)),
                                            InkWell(
                                              onTap: () {
                                                controller.addProduct(product['title'], product['image'], product['price']);
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: AppColors.secondary,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: const Center(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_cart,
                                                          color: AppColors.whiteColor,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'Add',
                                                          style: TextStyle(color: AppColors.whiteColor),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star, color: Colors.orange, size: 14),
                                                AutoSizeText('4.6', style: TextStyle(fontSize: 12)),
                                                SizedBox(width: 5),
                                                AutoSizeText('86 review', style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                            Icon(Icons.more_vert)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color:AppColors.primary),
                                onPressed: () {
                                  controller.deleteProduct(product['id']); // Use the document ID for deletion
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: (index) {
                controller.updateSelectedIndex(index);
              },
            ),

          );
        }
    );
  }
}


class CategoryTab extends StatelessWidget {
  final String title;
  final int index;

  const CategoryTab({Key? key, required this.title, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        bool isSelected = controller.selectedTabIndex == index;
        return GestureDetector(
          onTap: () {
            controller.selectTab(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                AutoSizeText(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.primary : Colors.black,
                  ),
                ),
                const SizedBox(height: 4), // Space between text and underline
                Container(
                  height: 2,
                  width:60, // Width of the underline
                  color: isSelected ? AppColors.secondary : Colors.transparent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}







