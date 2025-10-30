import 'package:chat_app/widgets/custom_receiver_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../services/chat_service.dart';
import '../widgets/custom_sender_bubble.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.chatId, required this.userModel});

  final String chatId;
  final UserModel userModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isConvo = true;

  TextEditingController messageController = TextEditingController();

  late final Stream<List<MessageModel>> chat_stream;

  @override
  void initState() {
    // TODO: implement initState
    chat_stream = ChatService.fetchMessageStream(widget.chatId);
    chat_stream.listen((data) {
      print("new data coming from stream");
      print(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.chatId);
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      appBar: AppBar(
        backgroundColor: Colors.green,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userModel.username,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.videocam, size: 28, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.call, size: 24, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              height: 500,
              child: StreamBuilder(
                stream: chat_stream,
                builder: (context, snapshot) {
                  // final data = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null) {
                    return Center(child: Text("No messages yet"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final senderName =
                          FirebaseAuth.instance.currentUser!.displayName;
                      return snapshot.data![index].senderName == senderName
                          ? SenderBubble(model: snapshot.data![index])
                          : ReceiverBubble(model: snapshot.data![index]);
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {},
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () async {
                        if (messageController.text.trim().isEmpty) return;

                        final message = MessageModel(
                          id: UniqueKey().toString(),
                          message: messageController.text.trim(),
                          senderId: FirebaseAuth.instance.currentUser!.uid,
                          senderName:
                              FirebaseAuth.instance.currentUser!.displayName ??
                              "User",
                          timeStamp: DateTime.now(),
                        );

                        await ChatService.sendMessage(message, widget.chatId);
                        messageController.clear();
                      },
                    ),
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
