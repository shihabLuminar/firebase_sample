import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              // write the logic to navigate to login screen on successful  loggout
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('employees').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?.docs[index]["name"]),
                subtitle: Text(snapshot.data?.docs[index]["ph"]),

                trailing: IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('employees')
                        .doc(snapshot.data?.docs[index].id)
                        .delete();
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
