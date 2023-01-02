import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/view_cloud.dart';
import 'package:login_firebase/view_realtime.dart';

class realtime_cloud_insert extends StatefulWidget {
  const realtime_cloud_insert({Key? key}) : super(key: key);

  @override
  State<realtime_cloud_insert> createState() => _realtime_cloud_insertState();
}

class _realtime_cloud_insertState extends State<realtime_cloud_insert> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("realtime_cloud_insert"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t1,
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t2,
              keyboardType: TextInputType.phone,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                //RealTime Database
                DatabaseReference ref = FirebaseDatabase.instance.ref("Student").push();
                await ref.set({
                  "name": "${t1.text}",
                  "contact": "${t2.text}",
                });

                //Cloud Firestore
                CollectionReference users = FirebaseFirestore.instance.collection('Student');
                users
                    .add({
                      'name': "${t1.text}", // John Doe
                      'contact': "${t2.text}", // Stokes and Sons
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));
              },
              child: Text("Submit")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return view_realtime();
                  },
                ));
              },
              child: Text("RealTime")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return view_cloud();
                  },
                ));
              },
              child: Text("Cloud")),
        ],
      ),
    );
  }
}
