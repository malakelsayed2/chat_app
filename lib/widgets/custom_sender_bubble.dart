import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/message_model.dart';

class SenderBubble extends StatefulWidget {
  final MessageModel model ;

  const SenderBubble({
    super.key,  required this.model,
  });

  @override
  State<SenderBubble> createState() => _SenderBubbleState();
}

class _SenderBubbleState extends State<SenderBubble> with SingleTickerProviderStateMixin{

 late AnimationController animationController ;
 late Animation<Offset> slideAnimation ;

 @override
  void initState() {
    // TODO: implement initState
   animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
   slideAnimation = Tween(begin: Offset(0.5 , 0),end: Offset.zero).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart));

   animationController.forward() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
          decoration: BoxDecoration(
            color: const Color(0xFFDCF8C6),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.model.message,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeago.format(widget.model.timeStamp),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}