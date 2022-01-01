import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/screens/add_task.dart';
import 'package:todo_firebase/screens/description.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              final docs = snapshot.requireData;
              return ListView.builder(
                itemCount: docs.size,
                itemBuilder: (context, index) {
                  var time =
                      (docs.docs[index]['timestamp'] as Timestamp).toDate();

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Description(
                                    title: docs.docs[index]['title'],
                                    description: docs.docs[index]
                                        ['description'],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 90,
                      decoration: BoxDecoration(
                          color: Color(0xff121211),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(docs.docs[index]['title'],
                                        style:
                                            GoogleFonts.roboto(fontSize: 18))),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                      DateFormat.yMd().add_jm().format(time),
                                      style: GoogleFonts.roboto(fontSize: 15)),
                                )
                              ],
                            ),
                            Container(
                              child: IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(uid)
                                        .collection('mytasks')
                                        .doc(docs.docs[index]['time'])
                                        .delete();
                                  },
                                  icon: Icon(Icons.delete)),
                            )
                          ]),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          }),
    );
  }
}
