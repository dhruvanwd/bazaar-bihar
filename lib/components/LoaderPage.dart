import 'package:bazaar_bihar/components/RandomImageLoaders.dart';
import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 200),
        child: RandomImageLoaders(),
      ),
    );
  }
}
