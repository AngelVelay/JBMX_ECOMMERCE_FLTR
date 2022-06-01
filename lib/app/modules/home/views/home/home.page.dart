import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jexpoints/app/modules/main/views/profile/profile.page.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jexpoints/app/components/points/points.widget.dart';
import 'package:jexpoints/app/modules/home/views/home/home.controller.dart';

import '../../../../components/button-qr-generate/button-qr-generate.dart';
import '../../../../components/cart-shopping/cart-shopping.dart';
import '../../../../components/circular-progress-bar/circular-progress-bar.dart';
import '../../../../components/linear-progress-bar/linear-progress-bar.dart';
import '../../../main/views/main/widgets/menu/menu.widget.dart';
import 'navbar_page.dart/navbar.page.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<HomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final screens = [HomePageTest(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 60.0,
          items: [
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.black45,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[_page]);
  }
}

class HomePageTest extends GetView<HomeController> {
  const HomePageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverDelegate(
              expandedHeight: 120,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Column(children: [
                const SizedBox(height: 40),
                _slider(controller),
                const SizedBox(height: 20),
                _topList(context, controller),
              ]),
            ),
          )
        ],
      ),
    ));
  }

  static Widget _slider(HomeController controller) {
    return SizedBox(
        child: ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CarouselSlider.builder(
          itemCount: controller.sliderImagesList.length,
          itemBuilder: (context, index, realIndex) {
            final carouselImage = controller.sliderImagesList[index];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    width: 600,
                    height: 600,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/publicidad',
                                arguments: carouselImage);
                          },
                          child: FadeInImage(
                            width: 600,
                            height: 3000,
                            fit: BoxFit.cover,
                            placeholder: const NetworkImage(
                                'https://tenor.com/view/loading-gif-9212724.gif'),
                            image: NetworkImage(carouselImage),
                          ),
                        ))));
          },
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    ));
  }

  static Widget _sliderImage(String carouselImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          width: 400,
          height: 150,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const NetworkImage(
                    'https://tenor.com/view/loading-gif-9212724.gif'),
                image: NetworkImage(carouselImage),
              ))),
    );
  }

  static Widget _topList(BuildContext context, HomeController controller) {
    return Column(children: [
      const Text(
        'Recompensas',
        style: TextStyle(
          fontSize: 25,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 10),
      SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.vertical,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.topProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) =>
                    _topListItem(context, controller.topProductList[index])),
          ),
        ),
      ),
    ]);
  }

  static Widget _topListItem(BuildContext context, dynamic product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail', arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: NetworkImage(product['url']),
                  image: NetworkImage(product['url']),
                ),
              ),
            ),
          ),
          // const Text(
          //   // products is out demo list
          //   'Nombre de producto',
          //   style: TextStyle(color: Colors.black, fontSize: 12),
          // ),

          Center(
              child: Text(
            // products is out demo list
            '${product['points']} pts',
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          )),
          // Text(
          //   "${product['puntos']} pts",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // )
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(fit: StackFit.expand, children: [
        SizedBox(
          height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
          child: AppBar(
            backgroundColor: const Color(0xFF222222),
            elevation: 0.0,
            title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Angel Velay",
                      style: TextStyle(color: Colors.white),
                    ),
                    PointsViewer(
                      size: 43,
                      fontSize: 14,
                      value: '35',
                    )
                  ],
                )),
          ),
        ),
        Positioned(
          top: 0,
          child: Opacity(
              opacity: percent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircularProgressBar(
                          AvatarSize: 15,
                          percent: 0.8,
                          sizeProgressBar: 20,
                        ),
                        Column(
                          children: [
                            Text('Angel Velay',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white)),
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    color: const Color(0xFF43578d),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const FadeInImage(
                                            placeholder: AssetImage(
                                                'assets/images/estrella.png'),
                                            image: AssetImage(
                                                'assets/images/estrella.png')),
                                        Container(width: 10),
                                        const Text('35 pts',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CartShopping(),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
          left: 20,
          top: expandedHeight - 30,
          child: Opacity(
            opacity: percent,
            child: Form(
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFfffffff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Buscar',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(Icons.food_bank, color: Colors.black)),
                  )),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
