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

class _HomePageState extends ViewState<HomePage, HomeController>{
  _HomePageState(HomeController controller) : super(controller);

  final nameController = TextEditingController();
  final depositController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Scaffold(
        key: globalKey, // built in global key for the ViewState for easy access in the controller
        body: Center(
          child: ListView(
            children: <Widget>[
              Text(
                // use data provided by the controller
                'Button pressed ${controller.counter} times.',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter a name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: depositController,
                  decoration: InputDecoration(hintText: 'Enter a mount of deposit'),
                ),
              ),
              RaisedButton(onPressed: (){
                controller.addUser(nameController.text, double.parse( depositController.text));
              },
              child: Text("Add User"),
              ),


              Text(
                'The current user is',
              ),
              Text(
                controller.user == null ? '' : '${controller.user}',
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(
                onPressed: controller.getUser,
                child: Text(
                  'Get User',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
              RaisedButton(
                onPressed: controller.getUserwithError,
                child: Text(
                  'Get User Error',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              )
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

}