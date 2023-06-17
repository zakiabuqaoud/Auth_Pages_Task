
//Flutter Packagee:clothes
import 'package:flutter/material.dart';

//External Package
import 'package:provider/provider.dart';

//My Files: screens
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

//My Files: providers
import './providers/auth.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Order(),
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed( //understand 1
                seedColor: Colors.deepPurple,
                secondary: Colors.deepOrange,
                primary: Colors.deepPurple),
            primaryColor: Colors.purple,
            secondaryHeaderColor: Colors.deepOrange,// possible remove line
            useMaterial3: true,
            fontFamily: "Lato"),
        home: const AuthScreen(),
        routes: {
          ProductDetail.routeName: (_) => const ProductDetail(),
          CartScreen.routeName: (_) => const CartScreen(),
          OrderScreen.routeName: (_) => const OrderScreen(),
          UserProductScreen.routename: (_) => const UserProductScreen(),
          EditProductScreen.routeName: (_) => const EditProductScreen(),
          AuthScreen.routeName: (_) => const AuthScreen(),
        },
      ),
    );
  }
}
