

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Events/Calender.dart';

import '../../helper.dart';


class EventSubCategories extends StatefulWidget {
  final id;

  const EventSubCategories({Key key, this.id}) : super(key: key);
  @override
  _EventSubCategoriesState createState() => _EventSubCategoriesState();
}

class _EventSubCategoriesState extends State<EventSubCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
                  )
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child:  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,

                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Text("Events",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

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
                  child: fetchCategory(),
                )
            )
          ],
        ),
      ),
    );
  }
  bool check=false;
  subCategory()async{
    final result = await APIClient().eventSubCategory(widget.id);
    if(result.isEmpty){
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
    return result;
  }
  fetchCategory(){
    return FutureBuilder(
      future: subCategory(),
      builder: (context,snap){
        if(check){
          return Center(
            child: Container(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if(snap.data==null){
          return Container(
            height: 300,
            child: Center(
              child: Container(
                height:50,width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8
            ),
            itemCount: snap.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: (){
                    Get.to(EventCalender(
                      title: snap.data[index]['name'],
                      id: snap.data[index]["id"].toString(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.5,
                      ),],
                    ),
                    alignment: Alignment.center,
                    child: Text(snap.data[index]['name'],style: TextStyle(fontFamily: 'fancy',fontSize: 17,fontWeight: FontWeight.bold,color: textColor),textAlign: TextAlign.center,),
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
