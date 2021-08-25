import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/helper.dart';

import 'Events/EventDetails.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String mode="";
  var value;
  @override
  void initState() {
    getEvent();
    getTicket();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                        title: Text("FeedBack",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

                      )
                  ),
                ),
              ),
              Transform.translate(
                  offset: Offset(0,-20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        )
                    ),
                    child: takeReview(),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  String _review="";
  int _rating = 0;
  String title="";

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
  }
  bool checkReview=false;
  takeReview(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.black54),
                  //color:  Colors.white70,
                ),

                //color:  Colors.pink[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: value,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors. black,
                              fontSize: 16,
                            ),
                            hint: Text('Feedback',style: TextStyle(color: Colors.black)),
                            onChanged: (String newValue) {
                              setState(() {
                                value = newValue;
                                //(_myState);
                                if(value=="General FeedBack"){
                                  mode="general";
                                }
                                else if(value=="Event FeedBack"){
                                  mode="event";
                                }
                                else if(value=="Work Order FeedBack"){
                                  mode="work";
                                }
                              });
                            },
                            items: ['General FeedBack','Event FeedBack','Work Order FeedBack']?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item,style: TextStyle(),),
                                value: item.toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            mode=="event"?eventRating()
            :mode=="work"?workRating()
            :generalRating()
          ],
        ),
      ),
    );
  }
  generalRating(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // width: 500.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  child: new Icon(
                    Icons.star,
                    color: _rating >= 1 ? Colors.orange : Colors.grey,
                  ),
                  onTap: () => rate(1),
                ),
                new GestureDetector(
                  child: new Icon(
                    Icons.star,
                    color: _rating >= 2 ? Colors.orange : Colors.grey,
                  ),
                  onTap: () => rate(2),
                ),
                new GestureDetector(
                  child: new Icon(
                    Icons.star,
                    color: _rating >= 3 ? Colors.orange : Colors.grey,
                  ),
                  onTap: () => rate(3),
                ),
                new GestureDetector(
                  child: new Icon(
                    Icons.star,
                    color: _rating >= 4 ? Colors.orange : Colors.grey,
                  ),
                  onTap: () => rate(4),
                ),
                new GestureDetector(
                  child: new Icon(
                    Icons.star,
                    color: _rating >= 5 ? Colors.orange : Colors.grey,
                  ),
                  onTap: () => rate(5),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [new BoxShadow(
                color: Colors.black54,
                blurRadius: 0.5,
              ),],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:8.0,right: 7),
              child: TextFormField(onChanged: (val){
                title=val.toString();
              },

                decoration: InputDecoration(border: InputBorder.none,
                  hintText: "Enter Review",
                  hintStyle: TextStyle(color: Colors.black),

                ),
                maxLines: 5,
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: buttonColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
              child: Text("Rate Now",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            onPressed: (){
              if(mode==""){
                _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please select feedback"));
              }
              else{
                if(_rating==0){
                  _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please select rating"));
                }
                else if(title==""){
                  _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please enter review"));
                }
                else{
                  review();
                }
              }
            },
          ),
        )
      ],
    );
  }
  review()async{
    final body={
      "rating": _rating.toString(),
      "review": title
    };
    final result = await APIClient().generalFeedback(body);
    if(result=="success"){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Review submitted"));
    }else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Failed"));
    }
  }

  List eventData;
  getEvent()async{
    final result = await APIClient().eventFeedback();
    if(result!="failed"){
      if(mounted){
        setState(() {
          eventData=result;
        });
      }
    }
  }
  var eventValue;
  eventRating(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: Colors.black54),
              //color:  Colors.white70,
            ),

            //color:  Colors.pink[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: eventValue,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors. black,
                          fontSize: 16,
                        ),
                        hint: Text('Select event',style: TextStyle(color: Colors.black)),
                        onChanged: (String newValue) {
                          setState(() {
                            eventValue = newValue;
                            print(eventValue);
                            Get.to(EventDetails(
                              id: newValue,
                            ));
                          });
                        },
                        items: eventData?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item["name"],style: TextStyle(),),
                            value: item["id"].toString(),
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List ticketData;
  getTicket()async{
    final result = await APIClient().ticketFeedback();
    if(result!="failed"){
      if(mounted){
        setState(() {
          ticketData=result;
        });
      }
    }
  }
  var ticketValue;
  workRating(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: Colors.black54),
              //color:  Colors.white70,
            ),

            //color:  Colors.pink[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: eventValue,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors. black,
                          fontSize: 16,
                        ),
                        hint: Text('Select ticket',style: TextStyle(color: Colors.black)),
                        onChanged: (String newValue) {
                          setState(() {
                            ticketValue = newValue;
                            print(ticketValue);
                            // Get.to(EventDetails(
                            //   id: newValue,
                            // ));
                          });
                        },
                        items: ticketData?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item["name"],style: TextStyle(),),
                            value: item["id"].toString(),
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
