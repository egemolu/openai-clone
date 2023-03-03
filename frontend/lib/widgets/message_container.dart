import 'package:flutter/material.dart';
import 'package:openai_clone/objects/message.dart';
import 'package:openai_clone/utils/colors.dart';

class MessageContainer extends StatelessWidget {
  Message message;

  MessageContainer(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var screenHeight = queryData.size.height;
    var screenWidth = queryData.size.width;
    return Container(
      width: screenWidth,
      color: message.isUserSend ? userMessageBoxColor : chatGptMessageBoxColor,
      constraints: BoxConstraints(
        minHeight: 2 * screenHeight / 18,
        maxHeight: double.infinity,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.25 * screenHeight / 18),
            child: Container(
              height: 0.75 * screenHeight / 18,
              alignment: Alignment.topLeft,
              width: 3 * screenWidth / 20,
              child: message.isUserSend
                  ? const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    )
                  : Center(
                      child: Image.asset("assets/images/chatgpt-icon.png")),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 0.25 * screenHeight / 18,
                bottom: 0.25 * screenHeight / 18),
            child: Container(
              constraints: BoxConstraints(
                minHeight: screenHeight / 18,
                maxHeight: double.infinity,
              ),
              width: 17 * screenWidth / 20,
              alignment: Alignment.topLeft,
              child: Text(
                message.message.trim().replaceAll(RegExp(r' \s+'), ' '),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
