import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String name;
  final int numberOfDeposit;

  const UserTileWidget(this.name, this.numberOfDeposit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        color: Colors.red,
        child: Row(children: <Widget>[
          Text("Username : " + name),
          SizedBox(width: 20,),
          Text("Number of Accounts : " + numberOfDeposit.toString())
        ],),
      ),
    );
  }
}