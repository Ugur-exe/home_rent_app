import 'package:flutter/material.dart';
import 'package:home_rent/api/message_api.dart';
import 'package:home_rent/api/message_user.dart';
import 'package:home_rent/view/chatPage.dart';
import 'package:home_rent/view/user_card.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  List<MessageUser> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
        ),
        body: StreamBuilder(
          stream: MessageApi.db.collection("messageList").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                messages =
                    data?.map((e) => MessageUser.fromJson(e.data())).toList() ??
                        [];
                if (messages.isNotEmpty) {
                  return ListView.builder(
                    itemCount:
                        messages.length, // Replace with your actual data count
                    itemBuilder: (context, index) {
                      return UserCard(
                        messageUser: messages[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    'No messages found.',
                    style: TextStyle(fontSize: 20),
                  ));
                }
            }
          },
        ));
  }
}
