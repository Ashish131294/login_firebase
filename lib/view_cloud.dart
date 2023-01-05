import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/realtime_cloud_insert.dart';

class view_cloud extends StatefulWidget {
  const view_cloud({Key? key}) : super(key: key);

  @override
  State<view_cloud> createState() => _view_cloudState();
}

class _view_cloudState extends State<view_cloud> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Student').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("view_cloud"),),
body: StreamBuilder<QuerySnapshot>(
  stream: _usersStream,
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Text("Loading");
    }

    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return ListTile(
          title: Text(data['name']),
          subtitle: Text(data['contact']),
          trailing: IconButton(onPressed: () {
            CollectionReference users = FirebaseFirestore.instance.collection('Student');
            users
                .doc(document.id)
                .delete()
                .then((value) => print("User Deleted"))
                .catchError((error) => print("Failed to delete user: $error"));
          }, icon: Icon(Icons.delete)),


          leading: IconButton(onPressed: () {
            CollectionReference users = FirebaseFirestore.instance.collection('Student');

            users
                .doc(document.id)
                .update({'name': '${t1.text}','contact': '${t2.text}'})
                .then((value) => print("User Updated"))
                .catchError((error) => print("Failed to update user: $error"));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return realtime_cloud_insert();
            },));
          }, icon: Icon(Icons.edit)),
        );
      }).toList(),
    );
  },
),
    );
  }
}
