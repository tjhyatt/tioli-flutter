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

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
              color: Color.fromRGBO(30, 169, 53, .3)
            ),
            height: 36,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),

                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                    height: 36,

                    child: Text("Take", 
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    print("take it");
                  },
                  highlightColor: Color.fromRGBO(30, 169, 53, 1),
                )
              ],
            )
          ),
        ),

        Expanded(
          flex: leaveVotes,

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
              color: Color.fromRGBO(245, 47, 47, .3)
            ),
            height: 36,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),

                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 9, 12, 10),
                    child: Text("Leave", 
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                  onTap: () => {
                    print("leave it")
                    
                  },
                  highlightColor: Color.fromRGBO(245, 47, 47, 1),
                )
                
              ],
            )
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return myWidget(_takes, _leaves);
  }
}