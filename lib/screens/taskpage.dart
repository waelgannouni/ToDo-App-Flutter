import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskPage extends StatefulWidget {


  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void PostTaskData(data) async{
  try{
    var body = json.encode(data);

    final response = await http.post(Uri.http(
        '192.168.1.159:8080','/api/v1/Tasks'),
        headers: {"Content-Type": "application/json"},
        body: body);
  print(response.body);
  }catch(err){print(err);}
  }
  DateTime itemDueDate = DateTime.now();
  String? itemName;
  String? itemCategory;
  String? itemPeriority;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: itemDueDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != itemDueDate)
      setState(() {
        itemDueDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom:6,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                              },
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Icon(
                              Icons.close,
                              color: Color(0XFF222428),
                              size: 20.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            ),
                          ),
                            Expanded(
                                child: Text(
                                  "Add Your Task",
                                    style:TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF211551),
                                    )
                                ),
                            ),
                        ],
                      ),
                    ),
                 Padding(
                   padding:  EdgeInsets.only(
                     bottom: 12.0,
                     left: 20
                   ),
                   child: TextField(
                     onChanged: (value){
                       setState(() {
                         itemName=value;
                         print(itemName);
                       });
                     },
                         decoration: InputDecoration(
                           hintText: "Enter Title for the task",
                           border:InputBorder.none,
                           contentPadding: EdgeInsets.symmetric(
                             horizontal: 24
                           )
                         ),
                      ),
                 ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30
                        ),
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0XFF868290),
                                  size: 20.0,
                                  semanticLabel: 'Text to announce in accessibility modes',
                                ),
                              ),
                              Text(
                                  "Due ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${itemDueDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 45
                    ),
                    child: DropdownButton<String>(
                      hint: Text(itemPeriority ?? "Select Task Periority"),
                      items: <String>['High', 'Middle', 'Low'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          itemPeriority = value;
                          print(itemPeriority);
                        });
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top:20,
                            left: 45
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: Color(0XFF868290),
                              size: 20.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 100
                              ),
                              child: Text(itemCategory ?? "Select Task Categorie"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 45,
                          top: 20
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              style:ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.transparent)
                              )
                              ),
                                backgroundColor:MaterialStateProperty.all<Color>(Color(0XFF868290)),
                              ),
                              child: Text(
                                'Work',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  itemCategory = "work";
                                  print(itemCategory);
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35
                              ),
                              child:  TextButton(
                                style:ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.transparent)
                                      )
                                  ),
                                  backgroundColor:MaterialStateProperty.all<Color>(Color(0XFF868290)),
                                ),
                                child: Text(
                                  'Personal',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    itemCategory = "Personal";
                                    print(itemCategory);
                                  });
                                },
                              )
                            ),
                            TextButton(
                              style:ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.transparent)
                                    )
                                ),
                                backgroundColor:MaterialStateProperty.all<Color>(Color(0XFF868290)),
                              ),
                              child: Text(
                                      'Home',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  itemCategory = "Home";
                                  print(itemCategory);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 45,
                        top:20
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: TextButton(
                        style:ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.transparent)
                              )
                          ),
                          backgroundColor:MaterialStateProperty.all<Color>(Color(0XFF433465)),
                        ),
                        child: Text(
                          'ADD TASK',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          PostTaskData({
                            "itemName":itemName,
                            "itemCategory":itemCategory,
                            "itemDueDate":itemDueDate.toIso8601String(),
                            "itemPeriority":itemPeriority
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
