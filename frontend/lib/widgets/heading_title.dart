import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  String title;
  Icon icon;
  double screenHeight;
  double screenWidth;

  HeadingTitle(this.title, this.icon, this.screenHeight, this.screenWidth,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight / 18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: 0.5 * screenWidth / 20,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}
