import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;
bool isMe = false;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetypeController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late var messagetext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUSer();
  }

  void getCurrentUSer() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user.email;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
        title: Text(
          '⚡️Chat',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messagetypeController,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Material(
                    child: MaterialButton(
                      onPressed: () {
                        messagetypeController.clear();
                        _firestore.collection('messages').add({
                          'text': messagetext,
                          'sender': loggedInUser,
                          'timeStamp': FieldValue.serverTimestamp()
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class messageStream extends StatelessWidget {
  const messageStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .orderBy('timeStamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Text('Done');
          } else if (snapshot.hasError) {
            return Text('error');
          }
          var mess = snapshot.data;

          final m = mess!.docs.reversed;
          List<messageBubble> l = [];
          m.forEach(
            (element) {
              final messageText = element.data() as Map<String, dynamic>;
              l.add(messageBubble(
                sender: messageText['sender'],
                text: messageText['text'],
                isMe: messageText['sender'] == loggedInUser,
                timestamp: messageText['timeStamp'],
              ));
            },
          );
          return Expanded(
            child: ListView(
              reverse: true,
              children: l,
            ),
          );
        });
  }
}

class messageBubble extends StatelessWidget {
  messageBubble(
      {required this.sender, required this.text, this.isMe, this.timestamp});
  late final String sender;
  late final String text;
  late final isMe;
  late final timestamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 10),
          ),
          Material(
              elevation: 8,
              color: isMe ? Colors.white : Colors.lightBlueAccent,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: isMe ? Colors.black54 : Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
