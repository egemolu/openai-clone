import 'package:flutter/material.dart';
import 'package:openai_clone/home_scree_body.dart';
import 'package:openai_clone/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mainColor,
      body: HomeScreenBody(),
    );
  }
}
