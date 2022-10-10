import 'dart:convert';
import 'package:etst/screens/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../db/Tasks.dart';
import '../widgets/widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future getTaskData() async{
    try{


    var response = await http.get(Uri.http('192.168.1.159:8080','/api/v1/Tasks'));
    var jsonData = jsonDecode(response.body);
    List<Task>Tasks =[];
    for(var task in jsonData){
      Task t = Task(task['id'],task['itemName'],task['itemPeriority'],task['itemDueDate'],task['itemCategory']);
      Tasks.add(t);
    }
    print(Tasks.length);
    return  Tasks;
    }catch(err){print(err);}
  }
  var formatter = new DateFormat('EEEE, MMMM dd, yyyy ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0XFFFFFFFF),
        title: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "TODAY",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                )
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                    formatter.format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF433465),
                  ),
                )
            ),
          ],
        ),

      ),
      body: SafeArea(
        child: Container(
          width:double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: Color(0XFFF6F6F6),
          child:Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future:getTaskData(),
                    builder: (context,AsyncSnapshot snapshot){
                        if(snapshot.data==null){
                          return Expanded(
                            child: ScrollConfiguration(
                              behavior: NoGlowBehavior(),
                              child: ListView(
                                children: [
                                  TaskWidget(Id:0,itemName:"Get Started",itemCategory:"Personal",itemDueDate:formatter.format(DateTime.now()),itemPeriority:"Low"),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Expanded(
                            child: ScrollConfiguration(
                              behavior: NoGlowBehavior(),
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context,i){
                                    return TaskWidget(
                                      Id: snapshot.data[i].Id,
                                      itemName:  snapshot.data[i].itemName,
                                      itemCategory: snapshot.data[i].itemPeriority,
                                      itemDueDate:  snapshot.data[i].itemDueDate.toString(),
                                      itemPeriority:  snapshot.data[i].itemCategory,
                                    );
                                  }
                                  ),
                            ),
                          );
                        }
                    },
                  ),
                ],
              ),

              Positioned(

                top: 12,
                right: 0,
                child: GestureDetector(

                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => TaskPage()
                    );
                  },
                  child: Container(
                    width: 60,
                      height: 60,
                    decoration: BoxDecoration(
                      color:Color(0XFF433465),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
