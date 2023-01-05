import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class view_realtime extends StatefulWidget {
  const view_realtime({Key? key}) : super(key: key);

  @override
  State<view_realtime> createState() => _view_realtimeState();
}

class _view_realtimeState extends State<view_realtime> {
  List keylist = [];
  List namelist = [];
  List contactlist = [];

  @override
  void initState() {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Student');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Map data = event.snapshot.value as Map;
      keylist.clear();
      namelist.clear();
      contactlist.clear();
      data.forEach((key, value) {
        print("$key=>$value");
        keylist.add(key);
        Map m = value;
        namelist.add(m['name']);
        contactlist.add(m['contact']);
        setState(() {});
      });
      print(keylist);
      print(namelist);
      print(contactlist);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view_realtime"),
      ),
      body: ListView.builder(itemCount: keylist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${namelist[index]}"),
            subtitle: Text("${contactlist[index]}"),
            trailing: IconButton(onPressed: () async {
              DatabaseReference ref = FirebaseDatabase.instance.ref('Student').child(keylist[index]);
             await ref.remove();
             setState(() {

             });
            }, icon: Icon(Icons.delete)),
          );
        },
      ),
    );
  }
}
