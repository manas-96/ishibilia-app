import 'package:flutter/material.dart';

import '../helper.dart';


class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
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
                      title: Text("Faq",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

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
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: fetchFaq(),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  bool show=false;
  fetchFaq(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        InkWell(
          onTap:(){
            setState(() {
              show=!show;
            });
          },
          child: Text("How can I go Sevilla ?",style: TextStyle(color: textColor,fontFamily: 'fancy',fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        SizedBox(height: 5,),
        show?Text("Click on the Sevilla icon in your menu or in your dashboard. You will be redirected to Sevilla page",style: TextStyle(fontFamily: 'regular',fontWeight: FontWeight.w500,fontSize: 17),)
        :Container(),
      ],
    );
  }
}
