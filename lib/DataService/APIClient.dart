import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIClient{
  final baseUrl="https://helpdesk.ishbilia.net/";
  final apiUrl='https://helpdesk.ishbilia.net/api/';

  static errorToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: Duration(seconds:2),
    );
  }
  static successToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      duration: Duration(seconds:2),
    );
  }
  login(body)async{
    print('hgj');
    final header = buildHeader();
    final response = await http.post(apiUrl+'login',body: body,headers: header);
    print(response.statusCode);
    if(response.statusCode==200){
      final data=await json.decode(response.body);
      storeToken(data);
      return data;
    }
    else{
      return 'failed';
    }
  }
  buildHeader(){
    return { 'Accept' : 'application/json', 'cache-control' : 'no-cache'};
  }
  buildHeaderWithToken()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token");
    return { 'content-type' : 'application/json', 'Authorization' : 'Bearer $token'};
  }
  _buildHeaderWithToken()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token");
    return { 'content-type' : 'application/json', 'Authorization' : 'Bearer $token'};
  }
  storeToken(data)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString('token', data['access_token']);
  }
  services()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'services',headers: header);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  serviceList(String id)async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'services/$id/bookings',headers: header);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  profile()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'profile',headers: header);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  updateProfile(body)async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.put(apiUrl+'profile',headers: header,body: body);
    if(response.statusCode==200){
      print(await json.decode(response.body));
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  changePass(body)async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.post(apiUrl+'change-password',headers: header,body: body);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  contacts()async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.get(apiUrl+'contact-categories',headers: header,);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  announcements()async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.get(apiUrl+'announcements',headers: header,);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  documents()async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.get(apiUrl+'document-categories',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  countries()async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.get(apiUrl+'countries',headers: header,);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  eventCategory()async{
    final header = await buildHeaderWithToken();
    print(header);
    final response = await http.get(apiUrl+'event-categories',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  eventSubCategory(String id)async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'event-subcategories/$id/events',headers: header,);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  eventDetails(String id)async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'events/$id',headers: header,);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  eventRating(String id,body)async{
    final header = await buildHeaderWithToken();
    final response = await http.put(apiUrl+'events/$id/rating',headers: header,body: body);
    if(response.statusCode==200){
      return "success";
    }
    else{
      return 'failed';
    }
  }
  deleteEventRating(String id)async{
    final header = await buildHeaderWithToken();
    final response = await http.delete(apiUrl+'events/$id/rating',headers: header,);
    if(response.statusCode==200){
      return "success";
    }
    else{
      return 'failed';
    }
  }
  bookEvent(String id, body)async{
    print(json.encode(body));
    final header = await buildHeaderWithToken();
    final response = await http.post(apiUrl+'events/$id/booking',headers: header,body: json.encode(body));
    print(response.body);
    if(response.statusCode==201){
      return "success";
    }
    else{
      return 'failed';
    }
  }
  deficiencies()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'deficiencies',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }

  getTicket()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'tickets',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  ticketDetails(String id)async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'tickets/$id',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      print(json.decode(response.body));
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  generalFeedback(body)async{
    final header = await buildHeaderWithToken();
    final response = await http.post(apiUrl+'feedback',headers: header,body:body);
    print(response.statusCode);
    if(response.statusCode==200){
      return 'success';
    }
    else{
      return 'failed';
    }
  }
   eventFeedback()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'feedback/events',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  ticketFeedback()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'feedback/tickets',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  getVisitorPass()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'visitor-pass',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  createVisitorPass(body)async{
    final header = await buildHeaderWithToken();
    final response = await http.post(apiUrl+'visitor-pass',headers: header,body: body);
    print(response.statusCode);
    print(await json.decode(response.body));
    if(response.statusCode==200){
      return "success";
    }
    else{
      return 'failed';
    }
  }

  sevilla()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'settings',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  notification()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'notifications',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }
  getApplication()async{
    final header = await buildHeaderWithToken();
    final response = await http.get(apiUrl+'application-forms',headers: header,);
    print(response.statusCode);
    if(response.statusCode==200){
      return await json.decode(response.body);
    }
    else{
      return 'failed';
    }
  }

}
