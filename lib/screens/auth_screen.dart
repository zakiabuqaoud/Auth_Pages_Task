
// import for Internal Lib
import 'dart:math';
import 'package:flutter/material.dart';

//import My Files
import '.././widgets/auth_card.dart';


class AuthScreen extends StatelessWidget {
  static const String routeName = "/auth";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1),
                  Color.fromRGBO(255, 188, 117, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //first Flexible contain on title
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 8),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8.0,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Clothes Shop",
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 45,
                            fontFamily: "Anton",
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  //second Flexible contain on Auth Card
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


