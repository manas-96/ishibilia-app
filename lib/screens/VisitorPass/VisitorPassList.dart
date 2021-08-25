import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/VisitorPass/CreateVisitor.dart';

import '../../helper.dart';


class VisitorPassList extends StatefulWidget {
  @override
  _VisitorPassListState createState() => _VisitorPassListState();
}

class _VisitorPassListState extends State<VisitorPassList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: buttonColor,
            onPressed: (){
              Get.to(CreateVisitor());
            }
        ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  image: DecorationImage(
                      image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
                  )
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,

                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Text("Visitor-Pass Requests",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

                    )
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0,-20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )
                ),
                child: fetchData(),
              ),
            )
          ],
        )
      ),
    );
  }
  bool data=false;
  getData()async{
    final result = await APIClient().getVisitorPass();
    if(result=="failed"|| result.isEmpty){
      if(mounted){
        setState(() {
          data=true;
        });
      }
    }
    return result;
  }
  fetchData(){
    return FutureBuilder(
      future: getData(),
      builder: (context,snap){
        if(data){
          return Center(
            child: Text("Empty List",style: TextStyle(color: textColor,fontSize: 18,fontFamily: "fancy",fontWeight: FontWeight.bold),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                    ),],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                          ),
                          image: DecorationImage(
                            image: NetworkImage(APIClient().baseUrl+snap.data[index]["villa"]["image"]),fit: BoxFit.cover
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width-150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Request No : ${snap.data[index]["request_no"]}",style: TextStyle(fontFamily: "regular",fontWeight: FontWeight.w600,fontSize: 18),),
                              SizedBox(height: 5,),
                              Text("Villa No : ${snap.data[index]["villa"]["villa_no"]}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                              SizedBox(height: 5,),
                              Text("Status : ${snap.data[index]["status"]==0?"Pending":snap.data[index]["status"]==1?"Processed":"Complete"}",
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,
                                    color: snap.data[index]["status"]==0?Colors.redAccent: textColor
                                ),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
