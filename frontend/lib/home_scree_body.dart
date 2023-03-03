import 'package:flutter/material.dart';
import 'package:openai_clone/api/fetching_service.dart';
import 'package:openai_clone/objects/message.dart';
import 'package:openai_clone/utils/colors.dart';
import 'package:openai_clone/widgets/message_container.dart';
import 'package:openai_clone/widgets/example_container.dart';
import 'package:openai_clone/widgets/heading_title.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  FetchingService fs = FetchingService();
  final TextEditingController searchBarTextController = TextEditingController();
  ScrollController listScrollController = ScrollController();
  ScrollController messageListController = ScrollController();
  bool listAtEnd = false;
  bool isLoading = false;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(onScrollEvent);
  }

  @override
  void dispose() {
    listScrollController.removeListener(onScrollEvent);
    searchBarTextController.dispose();
    super.dispose();
  }

  void onScrollEvent() {
    double maxPosition = listScrollController.position.maxScrollExtent;
    double currentPosition = listScrollController.position.pixels;
    if (maxPosition - currentPosition <= 50) {
      setState(() {
        listAtEnd = true;
      });
    } else {
      setState(() {
        listAtEnd = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var screenHeight = queryData.size.height;
    var screenWidth = queryData.size.width;

    return Column(
      children: [
        SizedBox(
          height: screenHeight / 18,
        ),
        header(screenHeight),
        isLoading
            ? SizedBox(
                height: 14 * screenHeight / 18,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : SizedBox(
                height: 14 * screenHeight / 18,
                child: messages.isEmpty
                    ? withoutMessage(screenHeight, screenWidth)
                    : withMessage(screenHeight, screenWidth),
              ),
        footer(screenHeight, screenWidth),
      ],
    );
  }

  Widget withoutMessage(double screenHeight, double screenWidth) {
    return Stack(children: [
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: listScrollController,
          children: [
            SizedBox(
              height: 0.5 * screenHeight / 18,
            ),
            SizedBox(
              height: screenHeight / 18,
              child: const Center(
                child: Text(
                  'ChatGPT',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            HeadingTitle(
                'Examples',
                const Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.white,
                ),
                screenHeight,
                screenWidth),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "${'"'}Explain quantum computing in simple terms${'"'}",
              screenHeight,
              screenWidth,
              true,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "${'"'}How do I make an HTTP request in Javascript?${'"'}",
              screenHeight,
              screenWidth,
              true,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "${'"'}Got any creative ideas for a 10 year old’s birthday?${'"'}",
              screenHeight,
              screenWidth,
              true,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            HeadingTitle(
                'Capabilities',
                const Icon(
                  Icons.electric_bolt_outlined,
                  color: Colors.white,
                ),
                screenHeight,
                screenWidth),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "Remembers what user said earlier in the conversation",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "Allows user to provide follow-up corrections",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "Trained to decline inappropriate requests",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            HeadingTitle(
                'Limitations',
                const Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.white,
                ),
                screenHeight,
                screenWidth),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "Limited knowledge of world and events after 2021",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "May occasionally produce harmful instructions or biased content",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
            SizedBox(
              height: 0.25 * screenHeight / 18,
            ),
            ExampleContainer(
              "May occasionally generate incorrect information",
              screenHeight,
              screenWidth,
              false,
              searchBarTextController,
            ),
          ],
        ),
      ),
      listAtEnd == false
          ? Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_circle_down_outlined),
                color: Colors.grey,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconSize: 36,
                onPressed: () {
                  if (listScrollController.hasClients) {
                    final position =
                        listScrollController.position.maxScrollExtent;
                    listScrollController.animateTo(
                      position,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
            )
          : Container(),
    ]);
  }

  Widget withMessage(double screenHeight, double screenWidth) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: messageListController,
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageContainer(messages[index]);
        },
      ),
    );
  }

  Widget footer(double screenHeight, double screenWidth) {
    return Container(
      height: 2 * screenHeight / 18,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: commandBox(screenHeight, screenWidth),
    );
  }

  Widget commandBox(double screenHeight, double screenWidth) {
    return Container(
      child: commanBoxRow(screenWidth, screenHeight),
    );
  }

  Row commanBoxRow(double screenWidth, double screenHeight) {
    return Row(
      children: [
        SizedBox(
          width: 2 * screenWidth / 20,
        ),
        commandBarTextField(screenWidth, screenHeight),
      ],
    );
  }

  Widget commandBarTextField(double screenWidth, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: chatBoxColor,
        borderRadius: BorderRadius.circular(24),
      ),
      width: 16 * screenWidth / 20,
      height: 1 * screenHeight / 18,
      child: TextField(
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        controller: searchBarTextController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: screenWidth / 20, top: 0.25 * screenHeight / 18),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: 'Type your command',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.play_arrow_outlined),
            color: Colors.grey,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 28,
            onPressed: () async {
              if (searchBarTextController.text.isNotEmpty) {
                String prompt = searchBarTextController.text;
                searchBarTextController.clear();
                Message m1 = Message(message: prompt, isUserSend: true);
                messages.add(m1);

                setState(() {
                  isLoading = !isLoading;
                });

                String reply = await fs.getAnswer(prompt);
                Message m = Message(message: reply, isUserSend: false);
                messages.add(m);

                setState(() {
                  isLoading = !isLoading;
                });
                await Future.delayed(const Duration(milliseconds: 500));

                if (messageListController.hasClients) {
                  messageListController.animateTo(
                      messageListController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget header(double screenHeight) {
    return Container(
      height: screenHeight / 18,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: const Center(
        child: Text(
          'New chat',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
