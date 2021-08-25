import 'package:flutter/material.dart';
import 'package:ishbilia/DataService/APIClient.dart';

import '../../helper.dart';

class BookEvent extends StatefulWidget {
  final id;

  const BookEvent({Key key, this.id}) : super(key: key);
  @override
  _BookEventState createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {

 List<TextEditingController> nameController = List.generate(74, (i) => TextEditingController());
 List<TextEditingController> type = List.generate(74, (i) => TextEditingController());
 List<TextEditingController> number = List.generate(74, (i) => TextEditingController());
 List<TextEditingController> ageController = List.generate(74, (i) => TextEditingController());

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> name=[];
  List<String> nationality=[];
  List<String> id_type=[];
  List<String> id_no=[];
  List<String> age=[];
  List<String> relation=[];
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Book Event",style: TextStyle(color: textColor),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(15),
                itemCount: length,
                itemBuilder: (context,index){
                  return view(index+1);
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                  child: Text("BOOK",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                ),
                onPressed: (){
                  validation("book",);
                },
                color: Colors.amber,
              ),
              SizedBox(height: 100,)
            ],
          )
        ),
      ),
    );
  }
  String _name='',_idType='',_nation,idNo='',_age='',_relation;
  int length=1;
  view(int index){

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text("Attendee $index",style: TextStyle(color: textColor,fontSize: 19,fontFamily: 'fancy',fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
              ),],
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Theme.of(context).primaryColor,width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController[index],
                decoration: InputDecoration(
                   
                    labelText: 'Name',
                  border: InputBorder.none,
                ),

                onChanged: (val){
                  _name=val;
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
              ),],
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Theme.of(context).primaryColor,width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(controller: type[index],
                decoration: InputDecoration(
                   
                    labelText: 'Id Type',
                  border: InputBorder.none,
                ),

                onChanged: (val){
                  _idType=val;
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
              ),],
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Theme.of(context).primaryColor,width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(controller: number[index],
                decoration: InputDecoration(
                   
                    labelText: 'Id Number',
                  border: InputBorder.none,
                ),

                onChanged: (val){
                  idNo=val;
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
              ),],
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Theme.of(context).primaryColor,width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(controller: ageController[index],
                decoration: InputDecoration(
                   
                    labelText: 'Age',
                  border: InputBorder.none,
                ),

                onChanged: (val){
                  _age=val;
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
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
                          value: _nation,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Nationality',style: TextStyle(color: Colors.black54)),
                          onChanged: (String newValue) {
                            setState(() {
                              _nation=newValue;
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
          SizedBox(height: 10,),
          Container(
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
                          value: _relation,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Relation',style: TextStyle(color: Colors.black54)),
                          onChanged: (String newValue) {
                            setState(() {
                              _relation=newValue;
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
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              validation("add",);

            },
            child: Text("+ add attendee",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'regular',fontSize: 18,color: textColor),),
          ),

        ],
      ),
    );
  }
  validation(String check,){
    if(_name==''){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Enter name"));
    }
    else if(_idType==''){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Enter ID type"));
    }
    else if(idNo==''){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Enter ID number"));
    }
    else if(_age==''){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Enter age"));
    }
    else if(_nation==null){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Select nationality"));
    }
    else if(_relation==null){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Select relation"));
    }
    else{
      setState(() {
        name.add(_name);
        nationality.add(_nation);
        id_no.add(idNo);
        id_type.add(_idType);
        relation.add(_relation);
        age.add(_age);
      });
      if(check=="book"){
        book();
      }
      else{
        if(mounted){
          setState(() {
            length=length+1;
          });
        }
      }
      print(name);
    }
  }
  book()async{
    Map<String, List<String>> body={
      "name": name,
      "nationality": nationality,
      "id_type": id_type,
      "id_no": id_no,
      "age": relation,
      "relation": age
    };
    final result = await APIClient().bookEvent(widget.id, body);
    if(result=='success'){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Booking successful"));
    }
    else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Booking failed"));

    }
  }
}
