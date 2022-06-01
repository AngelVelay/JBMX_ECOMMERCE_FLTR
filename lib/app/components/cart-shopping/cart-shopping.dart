import 'package:flutter/material.dart';

import '../points/points.widget.dart';

class CartShopping extends StatelessWidget {
  const CartShopping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image(
          width: 50,
          height: 50,
          image: AssetImage('assets/images/cart-shop.png')),
      PointsViewer(size: 30, value: '1', fontSize: 20),
    ]);
  }
}
