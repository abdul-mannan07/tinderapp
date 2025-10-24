import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String userName;
  final String bgImg;
  const ConversationScreen({
    super.key,
    required this.userName,
    required this.bgImg,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController textController = TextEditingController();
  List<String> userText = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          elevation: 4,
          //centerTitle: true,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department, color: Colors.pink, size: 30),
              SizedBox(width: 10),
              Text(
                widget.userName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: Column(
          children: [
            Expanded(
              child: userText.isEmpty
                  ? PlaceHolderText(
                      userName: widget.userName,
                      bgImg: widget.bgImg,
                    )
                  : PlaceHolderConversation(userText: userText),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextFormField(
                  maxLines: null,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        String conversation = textController.text.trim();
                        if (conversation.isNotEmpty) {
                          setState(() {
                            userText.add(conversation);
                            textController.clear();
                          });
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceHolderText extends StatelessWidget {
  final String userName;
  final String bgImg;
  const PlaceHolderText({
    super.key,
    required this.userName,
    required this.bgImg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userNameText("You Matched With $userName"),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(bgImg),
              // backgroundColor: Colors.amber
            ),
            SizedBox(height: 10),
            userNameText("Known when $userName has read your message."),

            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.checklist_rtl_rounded, size: 25),
                    SizedBox(width: 10),
                    userNameText("Get Read Receipts"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceHolderConversation extends StatelessWidget {
  final List<String> userText;
  const PlaceHolderConversation({super.key, required this.userText});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: userText.length,
      padding: const EdgeInsets.all(10),

      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ), // space between messages
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ), // space inside bubble
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width *
                  0.7, // more realistic bubble width
            ),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              userText[userText.length - 1 - index],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}

Widget userNameText(String chatUserName) {
  return Text(
    chatUserName,
    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );
}
