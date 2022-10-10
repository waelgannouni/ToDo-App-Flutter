import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskWidget extends StatelessWidget {
  final int Id;
  final String? itemName;
  final String? itemCategory;
  final String? itemDueDate;
  final String? itemPeriority;
   TaskWidget({required this.Id, this.itemName, this.itemCategory, this.itemDueDate, this.itemPeriority});
  Future DeleteTask(id) async{
    try{
      final response = await http.delete(Uri.http(
          '192.168.1.159:8080','/api/v1/Tasks/$id'));
    }catch(err){print(err);}
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24
      ),
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0XFF00000),
            blurRadius: 2,
            offset: Offset(1, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemCategory ?? "(cat)",
            style: TextStyle(
              color: itemPeriority=="High" ? Colors.red : itemPeriority=="Middle" ? Colors.orange : Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left:10,
              top: 10,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: itemPeriority=="High" ? Colors.red : itemPeriority=="Middle" ? Colors.orange : Colors.green ,
                  size: 20.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left:5,
                  ),
                  child: Text(
                    itemName ?? "(title color based on periority)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left:10,
            ),
            child: Divider(
                color: Color(0XFF575757FF)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left:10
            ),
            child: Text(
              itemDueDate!=null ? "Due " + itemDueDate!  :"Date",
              style: TextStyle (
                fontSize: 16,
                color: Color(0XFF868290),
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top:20
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    print('Share');
                  },
                  child: Icon(
                    Icons.ios_share_rounded,
                    color: Color(0XFF868290),
                    size: 20.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text("Share",
                    style: TextStyle(
                      color: Color(0XFF868290),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print('done');
                  },
                  child: Icon(
                    Icons.done,
                    color: Color(0XFF868290),
                    size: 20.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text("Complete",
                    style: TextStyle(
                      color: Color(0XFF868290),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    DeleteTask(Id);
                  },
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0XFF868290),
                    size: 20.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text("Delete",
                  style: TextStyle(
                      color: Color(0XFF868290),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}



class NoGlowBehavior extends ScrollBehavior{

  @override
  Widget buildViewportChrome(
      BuildContext context,Widget child, AxisDirection  axisDirection){
    return child;
  }

}