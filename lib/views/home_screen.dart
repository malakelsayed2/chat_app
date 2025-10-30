import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/widgets/custom_chat_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_model/app_brain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ChatService.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Whatsapp",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: appBrain.users,
              builder: (BuildContext context, value, Widget? child) {
                return Text(
                  "${appBrain.users.value.length} users available",
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
                );
              },
            ),
          ],
        ),
        toolbarHeight: 100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: appBrain.users,
          builder: (BuildContext context, value, Widget? child) {
            print("total Users ${appBrain.users.value.length} ") ;
            return ListView.separated(
              itemCount: appBrain.users.value.length,
              itemBuilder: (context, index) {
                return CustomChatTile(
                  model: appBrain.users.value[index],
                  onTap: () async {
                    // Navigator.push(context, MaterialPageRoute(builder:(context) => PrivateChatScreen(),));
                    final receiverId = appBrain.users.value[index].id;
                    final chatId = ChatService.createChatId(receiverId);
                    print("chatId: $chatId");

                    final doesExist = await ChatService.checkIfIdExists(chatId);

                    if (doesExist) {
                      print("Chat already existst");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chatId,
                            userModel: appBrain.users.value[index],
                          ),
                        ),
                      );
                    } else {
                      print("Creating chat for the first time");
                      await ChatService.createChat(chatId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chatId,
                            userModel: appBrain.users.value[index],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 10);
              },
            );
          },
        ),
      ),
    );
  }
}
