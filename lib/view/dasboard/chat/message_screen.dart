import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  String name, image, email, receiverId;

  MessageScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.email,
      required this.receiverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Chat");
  //ScrollController: A Flutter class that lets you programmatically control and observe the scroll position
  //of scrollable widgets like ListView, SingleChildScrollView, etc.
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //fetch map values from firebase
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      //convert map into list
                      List<dynamic> messages = map.values.toList();
                      List<dynamic> filteredMessages =
                          messages.where((message) {
                        return (message['receiver'] == widget.receiverId &&
                                message['sender'] ==
                                    SessionController().userId) ||
                            (message['receiver'] ==
                                    SessionController().userId &&
                                message['sender'] == widget.receiverId);
                      }).toList();

                      // Automatically scroll to the bottom when a new message arrives addPostFrameCallback:
                      //This method schedules a callback to be executed after the current frame is fully
                      //rendered. This ensures that the UI is already drawn on the screen
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        //hasclient check ScrollController is currently controlling any scrollable widgets.
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(
                              //_scrollController.position.maxScrollExtent: This property represents the maximum
                              // scrollable position. Essentially, it gets the bottom-most position of the scrollable widget (e.g., the bottom of the list in a ListView).
//Overall, this line jumps to the bottom of the scrollable widget (like a chat window) once the widget is fully loaded/rendered.
                              _scrollController.position.maxScrollExtent);
                        }
                      });

                      return ListView.builder(
                          controller: _scrollController,
                          //get the length of messages from firebase
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            //all values save to message index wise
                            var message = messages[index];
                            //help to differentiate between user and sender through different visualization of widgets
                            bool isSender =
                                message["sender"] == SessionController().userId;

                            return Align(
                              alignment: isSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSender
                                      ? Colors.blue[200]
                                      : Colors.grey[300],
                                  borderRadius: isSender
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        )
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      //messages send by sender
                                      message['message'],
                                      style: TextStyle(
                                          color: isSender
                                              ? Colors.black
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      //represent date and time in readable format
                                      Utils.formatTime(message['time']),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: messageController,
                      cursorColor: AppColors.primaryTextTextColor,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: () {
                              sendMessage();
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryIconColor,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(
                            color: AppColors.primaryTextTextColor
                                .withOpacity(0.8)),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.textFieldDefaultFocus),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.alertColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.textFieldDefaultBorderColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage("Enter message");
    } else {
      final timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiver': widget.receiverId,
        'type': 'text',
        'time': timeStamp,
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
