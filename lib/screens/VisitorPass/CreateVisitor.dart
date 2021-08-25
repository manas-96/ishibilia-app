import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:ishbilia/DataService/APIClient.dart';

import '../../helper.dart';


class CreateVisitor extends StatefulWidget {
  @override
  _CreateVisitorState createState() => _CreateVisitorState();
}

class _CreateVisitorState extends State<CreateVisitor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle hintStyle =TextStyle(fontSize: 18,fontFamily: "fancy",fontWeight: FontWeight.bold,color: Colors.black);
  var from,to;
  String message='';


  List _nation=List(74);
  List _relation=List(74);
  List idType=List(74);
  List name=List(74);
  List age=List(74);
  List idNo=List(74);

  List country;
  getCountry()async{
    final result = await APIClient().countries();
    if(mounted){
      setState(() {
        country=result;
      });
    }
  }

  @override
  void initState() {
    getCountry();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:SingleChildScrollView(
          child: Column(
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
                        title: Text("Request Visitor-Pass",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

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
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.74,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: create(),
                    ),
                  ),
                ),
              )
            ],
          ),
        )

      ),
    );
  }
  int length=1;
  create(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                child: TextFormField(
                  onChanged: (val){
                    message=val;
                  },
                  decoration: InputDecoration(border: InputBorder.none,
                    hintText: "Message",
                    hintStyle: hintStyle,

                  ),
                  maxLines: 5,
                ),
              ),
            ),
          ),
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
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'yyyy/MM/dd',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onChanged: (val) => setState(() => from = val),
                  decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Valid from',
                      hintStyle: hintStyle
                  ),
                ),
              ),
            ),
          ),
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
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'yyyy/MM/dd',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onChanged: (val) => setState(() => to = val),
                  decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Valid to',
                      hintStyle: hintStyle
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (context,index){
              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Attendee : ${index+1}",style: hintStyle,),
                  ),
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
                        child: TextFormField(
                          onChanged:(val){
                            name[index]=val;
                          },
                          decoration: InputDecoration(border: InputBorder.none,
                            hintText: "Name",
                            hintStyle: hintStyle,
                          ),

                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                        ),],
                        borderRadius: BorderRadius.circular(10),
                      ),

                      //color:  Colors.pink[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: _nation[index],
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors. black,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Nationality',style: hintStyle),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _nation[index]=newValue;
                                        //(_myState);
                                      });
                                    },
                                    items: country?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Container(width: 100,
                                          child: new Text(item['name'],
                                            style: TextStyle(),),
                                        ),
                                        value: item['name'].toString(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                        ),],
                        borderRadius: BorderRadius.circular(10),
                      ),

                      //color:  Colors.pink[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: _relation[index],
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors. black,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Relation',style: hintStyle),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _relation[index]=newValue;
                                        //(_myState);
                                      });
                                    },
                                    items: ["Resident","Wife","Child","Friend","Others"]?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Container(width: 100,
                                          child: new Text(item,
                                            style: TextStyle(),),
                                        ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                        ),],
                        borderRadius: BorderRadius.circular(10),
                      ),

                      //color:  Colors.pink[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: idType[index],
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors. black,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Id Type',style: hintStyle),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        idType[index]=newValue;
                                        //(_myState);
                                      });
                                    },
                                    items: ["Passport","Driving Licence","Iqama","Saudi Id",]?.map((item) {
                                      return new DropdownMenuItem(
                                        child: Container(width: 100,
                                          child: new Text(item,
                                            style: TextStyle(),),
                                        ),
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
                  ),
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
                        child: TextFormField(
                          onChanged:(val){
                            idNo[index]=val;
                          },
                          decoration: InputDecoration(border: InputBorder.none,
                            hintText: "Id number",
                            hintStyle: hintStyle,
                          ),

                        ),
                      ),
                    ),
                  ),
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
                        child: TextFormField(
                          onChanged:(val){
                            age[index]=val;
                          },
                          decoration: InputDecoration(border: InputBorder.none,
                            hintText: "Age",
                            hintStyle: hintStyle,
                          ),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              );
            },
          ),
          Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap:(){
                  setState(() {
                    length=length+1;
                  });
                },
                child: Text("Add attendee",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'regular',color: buttonColor),),
              )
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                child: Text("Request",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              onPressed: (){
                request();
              },
              color: Colors.amber,
            ),
          ),
          SizedBox(height: 50,)
        ],
      )
    );
  }
  request()async{
    List n=[],a=[],iN=[],iT=[],r=[],na=[];
    for(int i=0;i<74;i++){
      if(name[i]!=null){
        if(mounted){
          n.add(name[i]);
        }
      }
      if(age[i]!=null){
        if(mounted){
          a.add(age[i]);
        }
      }
      if(idNo[i]!=null){
        if(mounted){
          iN.add(idNo[i]);
        }
      }
      if(idType[i]!=null){
        if(mounted){
          iT.add(idType[i]);
        }
      }
      if(_relation[i]!=null){
        if(mounted){
          r.add(_relation[i]);
        }
      }
      if(_nation[i]!=null){
        if(mounted){
          na.add(_nation[i]);
        }
      }
    }
    final body={
      "message": message,
      "valid_from": from.toString(),
      "valid_till": to.toString(),
      "name": n.toString(),
      "nationality": na.toString(),
      "id_type": iT.toString(),
      "id_no": iN.toString(),
      "age": a.toString(),
      "relation": r.toString()
    };
    print(body);
    final result = await APIClient().createVisitorPass(body);
    if(result=="success"){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Request successful"));
    }
    else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Request failed"));

    }
  }
}
