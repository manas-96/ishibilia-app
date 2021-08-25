import 'package:flutter/material.dart';
import 'package:ishbilia/helper.dart';


class AnnouncementDetails extends StatefulWidget {
  final url;
  final text;

  const AnnouncementDetails({Key key, this.url, this.text}) : super(key: key);
  @override
  _AnnouncementDetailsState createState() => _AnnouncementDetailsState();
}

class _AnnouncementDetailsState extends State<AnnouncementDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black54),
            backgroundColor: Colors.white,
            title: Text('Details',style: TextStyle(color: Colors.black54,fontFamily: 'fancy' ),),
          ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.url),fit: BoxFit.contain
                  )
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.text,style: TextStyle(color: textColor,fontSize: 17,fontFamily: 'regular',fontWeight: FontWeight.bold),),
            ),
          ],
        ),

      ),
    );
  }

  box(String index){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(index,style: TextStyle(color: Colors.black54,fontFamily: 'fancy',fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Cricket',style: TextStyle(color: Colors.black54,fontFamily: 'fancy',fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 5,),
                    Text('20/6/2021',style: TextStyle(color: Colors.black54,fontFamily: 'regular',fontWeight: FontWeight.bold,fontSize: 16),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
