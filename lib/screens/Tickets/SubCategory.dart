import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Tickets/CreateWorkOrder.dart';

import '../../helper.dart';


class SubCategory extends StatefulWidget {
  final data;
  final id;
  final title;
  const SubCategory({Key key, this.data, this.id, this.title}) : super(key: key);
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    title: Text("Sub-Deficiency",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                height: MediaQuery.of(context).size.height-150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                ),

                child: fetch(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetch(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,mainAxisSpacing: 5),
        itemCount: widget.data.length,
        itemBuilder: (context,index){
          return box(index, widget.data);
        },
      ),
    );
  }
  bool other=false;
  box(int index,data){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          setState(() {
            if(data[index]["name"].toString().toUpperCase()=="OTHER"){
              other=true;
            }else other=false;
          });
          Get.to(CreateWorkOrder(
            id: data[index]["id"].toString(),
            other: other,
            title: widget.title,
            subtitle: data[index]["name"],
          ));
        },
        child: Container(
          decoration: BoxDecoration(

            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [new BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            ),],
          ),
          child: ListTile(
            title:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                  child: Image.network("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 30,
                alignment: Alignment.center,
                child: Text('${data[index]["name"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontFamily: 'regular',fontSize: 15),textAlign: TextAlign.start,),
              ),
            ),

          ),

        ),
      ),
    );
  }
}
