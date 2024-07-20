import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Searchuser extends StatelessWidget {
   Searchuser({super.key});
  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .where('name', isEqualTo: _textController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("An error occurred: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No User Found"));
              }
              var person = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: person.length,
                  itemBuilder: (context, index) {
                    var personi = person[index];
                    if (personi['username'] == _textController.text) {
                      return ListTile(
                        title: Text(personi['username']),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Text(" No Useroo Found"),
                      );
                    }
                  });
            }));
  }
}
