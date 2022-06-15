import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Chats/0EZ5wVvdDoqLtkux5jXC/Message').snapshots(),
        builder: (ctx , snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            var results = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
            return ListView.builder(
                itemCount: results.docs.length,
                itemBuilder: (ctx, index) =>
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text('${results.docs[index]['text']}'),
                    )
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        // FirebaseFirestore.instance.collection('Chats/0EZ5wVvdDoqLtkux5jXC/Message').snapshots().listen((data) {
        //   //print(data.docs[0]['Name']);
        //   data.docs.forEach((element) {
        //     print('${element['text']}');
        //   });
        // });
        
        
        FirebaseFirestore.instance.collection('Chats/0EZ5wVvdDoqLtkux5jXC/Message').add(
            {
              'text' : 'this text is added by clicking this + button'
            });
        
      },
        child: Icon(Icons.add),),
    );
  }
}
