import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper.dart';

class ViewContacts extends StatefulWidget {
  final data;
  final title;
  const ViewContacts({Key key, this.data, this.title}) : super(key: key);
  @override
  _ViewContactsState createState() => _ViewContactsState();
}

class _ViewContactsState extends State<ViewContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title,style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            image: DecorationImage(
                image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
            )
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context,index){
                return contact(widget.data[index] ["name"], widget.data[index] ["mobile"],
                    widget.data[index] ["image"],widget.data[index] ["designation"] ,
                    widget.data[index] ["email"], widget.data[index] ["landline"],
                    widget.data[index] ["office"]);
              },
            ),
          ),
        ),
      ),
    );
  }
  contact(String name, String mobile, String image,String designation,String email, String lan,String office){
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [new BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
          ),],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'fancy',fontSize: 18),),
                  Text(designation,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'regular'),),
                  SizedBox(height: 4,),
                  Text('MOB : '+mobile,style: TextStyle(fontWeight: FontWeight.  w500,fontFamily: 'regular'),),
                  SizedBox(height: 4,),
                  Text('Landline : '+lan,style: TextStyle(fontWeight: FontWeight.  w500,fontFamily: 'regular'),),
                  SizedBox(height: 4,),
                  Text('Email : '+email,style: TextStyle(fontWeight: FontWeight.  w500,fontFamily: 'regular'),),
                  SizedBox(height: 4,),
                  Text('Office : '+office,style: TextStyle(fontWeight: FontWeight.  w500,fontFamily: 'regular'),),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone,color: textColor,),
                        onPressed: () => launch("tel://mobile"),
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        icon: Icon(Icons.email,color: textColor,),
                        onPressed: (){
                          mail(email);
                        },
                      )
                    ],
                  ),

                 // SizedBox(width: 5,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void mail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
    }
  }
}
