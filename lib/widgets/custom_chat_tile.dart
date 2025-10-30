import 'package:flutter/material.dart';

import '../models/user_model.dart';

class CustomChatTile extends StatelessWidget {
  const CustomChatTile({Key? key, required this.model, required this.onTap}) : super(key: key);
  final UserModel model ;
  final VoidCallback onTap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsGeometry.all(20),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade400, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      model.username[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(model.email, style: TextStyle(color: Colors.grey, fontSize: 16)),
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Text("Availble to chat", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text("now", style: TextStyle(color: Colors.grey, fontSize: 16)),
                Container(
                  padding: EdgeInsetsGeometry.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.chat_bubble ,color: Colors.white, size: 15,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
