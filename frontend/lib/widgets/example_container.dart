import 'package:flutter/material.dart';
import 'package:openai_clone/utils/colors.dart';

class ExampleContainer extends StatefulWidget {
  String text;
  double screenHeight;
  double screenWidth;
  bool isClickable;
  TextEditingController searchBarTextController;
  ExampleContainer(this.text, this.screenHeight, this.screenWidth,
      this.isClickable, this.searchBarTextController,
      {Key? key})
      : super(key: key);

  @override
  State<ExampleContainer> createState() => _ExampleContainerState();
}

class _ExampleContainerState extends State<ExampleContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 1 * widget.screenWidth / 20,
          right: 1 * widget.screenWidth / 20),
      child: GestureDetector(
        onTap: () {
          if (widget.isClickable) {
            setState(() {
              widget.searchBarTextController.text =
                  widget.text.substring(1, widget.text.length - 1);
            });
          }
        },
        child: Container(
          height: 1.5 * widget.screenHeight / 18,
          width: 18 * widget.screenWidth / 20,
          decoration: BoxDecoration(
            color: chatBoxColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              widget.isClickable
                  ? const Text(
                      "->",
                      style: TextStyle(color: Colors.white),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
