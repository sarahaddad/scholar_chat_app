import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholarchat/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

import '../widgets/chat_bubble.dart';

class chatPage extends StatelessWidget {
  static String id = 'chat Page';
  TextEditingController controller = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessageCollection);
  final _contoroler = ScrollController();

  @override
  Widget build(BuildContext context) {
      String email=ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt,descending: true).snapshots(),
        builder: (Context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: KPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 50,
                      ),
                      Text('Chat'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                          controller: _contoroler,
                          itemCount: messagesList.length,
                          itemBuilder: (
                            BuildContext,
                            index,
                          ) {
                            return messagesList[index].id==email ? chatBubble(
                              message: messagesList[index],
                            ):chatBubbleWithFreiend(message:  messagesList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            'message': data,
                            KCreatedAt: DateTime.now(),
                            'id':email,
                          });
                          controller.clear();
                          _contoroler.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                          );
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.send,
                            color: KPrimaryColor,
                          ),
                          hintText: 'Send message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: KPrimaryColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Text('loading');
          }
        });
  }
}
