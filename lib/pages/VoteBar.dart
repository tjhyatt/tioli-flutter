import 'package:flutter/material.dart';

class VoteBar extends StatelessWidget {

  int _takes;
  int _leaves;
  
  VoteBar(this._takes, this._leaves);

  Widget myWidget(int takeVotes, int leaveVotes) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: takeVotes,
          child: InkWell(
            child: Container(
              color: Color.fromRGBO(30, 169, 53, 1),
              height: 36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text("Take", 
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                  
                ],
              )
            ),
            onTap: () {
              print("take it");
            },
          ),
        ),
        Expanded(
          flex: leaveVotes,
          child: InkWell(
            child: Container(
              color: Color.fromRGBO(245, 47, 47, 1),
              height: 36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text("Leave", 
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              )
            ),
            onTap: () {
              print("Leave It");
            },
          )
          
          
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return myWidget(_takes, _leaves);
  }
}