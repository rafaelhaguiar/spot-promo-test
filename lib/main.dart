import 'package:flutter/material.dart';
import 'package:spot_promo_test/base/pages/login_page.dart';
import 'package:spot_promo_test/base/pages/register_page.dart';
import 'package:spot_promo_test/products/pages/products_page.dart';

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/products': (context) => ProductsPage(),
      }),
    );
