import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/message_model.dart';

class ReceiverBubble extends StatefulWidget {

  final MessageModel model ;
  const ReceiverBubble({
    super.key, required this.model,});

  @override
  State<ReceiverBubble> createState() => _ReceiverBubbleState();
}

class _ReceiverBubbleState extends State<ReceiverBubble> with SingleTickerProviderStateMixin{

  late AnimationController animationController ;
  late Animation<Offset> slideAnimation ;
  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    slideAnimation = Tween(begin: Offset(-0.5 , 0),end: Offset.zero).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart));

    animationController.forward() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.senderName,
                style: const TextStyle(
                  fontSize: 12,
                  color:Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.model.message,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 3),
              Text(
                timeago.format(widget.model.timeStamp),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}