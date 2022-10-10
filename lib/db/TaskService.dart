import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'Tasks.dart';

class TaskService extends StatefulWidget {
  const TaskService({Key? key}) : super(key: key);


  @override
  _TaskServiceState createState() => _TaskServiceState();
}

class _TaskServiceState extends State<TaskService> {

  getTaskData() async{
    var response = await http.get(Uri.https('192.168.1.50:8080','/api/v1/Tasks'));
    var jsonData = jsonDecode(response.body);

  List<Task>Tasks =[];
  for(var task in jsonData){
    Task t = Task(task['Id'],task['itemName'],task['itemCategory'],task['itemDueDate'],task['itemPeriority']);
    Tasks.add(t);
  }
  print(Tasks.length);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
