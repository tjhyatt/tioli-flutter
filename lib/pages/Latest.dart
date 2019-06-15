import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import './Auth.dart';
import './Login.dart';
import './TioliView.dart';

class Latest extends StatefulWidget {
  @override
  _Latest createState() => _Latest();
}

class _Latest extends State<Latest> {
  DatabaseReference _database;
  var _tioliQuery;

  @override
  void initState() {
    super.initState();

    _database = FirebaseDatabase.instance.reference();
    _tioliQuery = _database.child("tioli").orderByChild('timestamp').limitToFirst(10);
  }

  Future<String> getUserAvatarById(String uid) async {
    StorageReference ref = FirebaseStorage.instance.ref().child('images/'+ uid +'/avatar');
    var url;
    await ref.getDownloadURL().then((val) {
      url = val;
    });

    return url; 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest', style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0
        ),),
        elevation: 0.5,
        
      ),
      drawer: Drawer(
        child:Container(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 5.0),
          child: Column(
            children: <Widget>[
              Text("hello", style:TextStyle(
                color: Colors.blue
              )),
              FlatButton(
                child: Text('Log out'),
                onPressed: () => { _onLogout(context) },
              )
            ],
          )
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: FirebaseAnimatedList(
          query: _tioliQuery,
          itemBuilder: (
            BuildContext context, 
            DataSnapshot snapshot, 
            Animation<double> animation, 
            int index) {
              Map map = snapshot.value;
              String userId = snapshot.value['uid'];
              String tioliId = snapshot.key;

              return Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: FutureBuilder(
                    future: getUserAvatarById(userId),
                    initialData: null,
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                    // default avatar image
                    var _loadImage = new AssetImage('assets/images/cat.jpg');
                    return ListTile(
                      title: Text(map['question']),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: text.data != null ? NetworkImage(
                          text.data
                        ) : _loadImage
                      ),
                      onTap: (() => {
                        _onTioliTap(context, tioliId)
                      }),
                    );
                  })
                ),
              );
            },
        ),
      ),
    );
  }

  _onLogout(context) {
    Auth().signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  _onTioliTap(context, tioliId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TioliView(tioliId)));
  }
}
