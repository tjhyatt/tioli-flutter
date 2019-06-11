import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './VoteBar.dart';

class Tioli {
  String id;
  String uid;
  String username;
  String question;
  int takes;
  int leaves;
  int timestamp;

  Tioli(this.id, this.uid, this.username, this.question, this.takes, this.leaves, this.timestamp);
}

class TioliView extends StatefulWidget {

  @override
  TioliViewState createState() => TioliViewState();

  final String _tioliId;

  TioliView(this._tioliId);
}

class TioliViewState extends State<TioliView> {
  
  @override
  void initState() {
    super.initState();
   // _getTioliById(widget._tioliId);
  }

  Future<Tioli> _getTioliById(String tioliId) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child('tioli/' + tioliId);

    var _snapshot;

    await ref.once().then((snapshot) => {
      print(snapshot.value['uid']),
      _snapshot = snapshot
    });

    return new Tioli(_snapshot.value['uid'], _snapshot.value['id'], _snapshot.value['username'], _snapshot.value['question'], _snapshot.value['takeVotes'], _snapshot.value['leaveVotes'], _snapshot.value['timestamp']); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take it or leave it', style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0
        ),),
        elevation: 0.5,
        
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: FutureBuilder(
          future: _getTioliById(widget._tioliId),
          initialData: new Tioli("1", "2", "3", "4", 0, 0, 0),
          builder: (BuildContext context, AsyncSnapshot<Tioli> tioli) {
            if (tioli.hasData) {
              print(tioli.data.takes);
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      tioli.data.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: VoteBar(tioli.data.takes, tioli.data.leaves),
                    )
                    // VoteBar()
                    // Row(
                    //   children: <Widget>[
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(new Radius.circular(4.0))
                    //         ),
                    //         child: Container(

                    //         )
                    //       ),
                    //       child: Row(
                    //         children: <Widget>[
                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width * .5 - 24,
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Color.fromRGBO(30, 169, 53, 1),
                    //                 border: Border.all(
                    //                   color: Color.fromRGBO(30, 169, 53, 1),
                    //                   width: 8.0,
                    //                 ),
                    //                 borderRadius: BorderRadius.all(new Radius.circular(4.0))
                    //               ),
                    //               child: Text("hh"),
                    //             ),
                    //           ),

                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width * .5 - 24,
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Color.fromRGBO(245, 47, 47, 1),
                    //                 border: Border.all(
                    //                   color: Color.fromRGBO(245, 47, 47, 1),
                    //                   width: 8.0,
                    //                 ),
                    //               ),
                    //               child: Text("hh"),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     )
                        
                        
                    //   ],
                    // )
                  ],
                ),
              );
              
              
              
            }
            
          },
        )
      )
    );
  }
}