import 'package:beflex_clean_architecture/src/app/widgets/user_tile_widget.dart';
import 'package:beflex_clean_architecture/src/data/repositories/data_users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'home_controller.dart';

class HomePage extends View {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState(HomeController(DataUsersRepository()));
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState(HomeController controller) : super(controller);
  final List<String> _listViewData = [
    "A List View with many Text - Here's one!",
    "A List View with many Text - Here's another!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
  ];
  final nameController = TextEditingController();
  final depositController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Scaffold(
        key:
            globalKey, // built in global key for the ViewState for easy access in the controller
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text(
                // use data provided by the controller
                'Button pressed ${controller.counter} times.',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Number of User : ${controller.userCount}.',
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: 200,
                child: RaisedButton(
                  onPressed: () {
                    _asyncInputDialog(context);
                  },
                  child: Text("Add User"),
                ),
              ),
              RaisedButton(
                onPressed: controller.getUser,
                child: Text(
                  'Get User',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
              Expanded(
                  child: controller.userCount > 0 ? ListView.builder(
                itemCount: controller.userCount ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  print("index : $index");
                  print(controller.users[index].name);
                  return UserTileWidget(controller.users[index].name,controller.users[index].accounts.length );
                },
              ) : Container()
              ) ,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => callHandler(controller
            .buttonPressed), // callhandler refreshes the view the handler has finished
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter current team'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                controller: nameController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Name', hintText: 'Enter name'),
              )),
              SizedBox(
                width: 10,
              ),
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Amount', hintText: 'Enter amount of deposit'),
                controller: depositController,
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                controller.addUser(
                    nameController.text, double.parse(depositController.text));
                nameController.clear();
                depositController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
