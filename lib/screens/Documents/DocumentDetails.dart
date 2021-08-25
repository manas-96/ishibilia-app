import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper.dart';


class DocumentDeatils extends StatefulWidget {
  final data;
  final title;
  const DocumentDeatils({Key key, this.data, this.title}) : super(key: key);
  @override
  _DocumentDeatilsState createState() => _DocumentDeatilsState();
}

class _DocumentDeatilsState extends State<DocumentDeatils> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    //
    // IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];
    //   setState((){ });
    // });
    //
    // FlutterDownloader.registerCallback(downloadCallback);
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" && progress == 100 && id != null) {
        String query = "SELECT * FROM task WHERE task_id='" + id + "'";
        var tasks = FlutterDownloader.loadTasksWithRawQuery(query: query);
        //if the task exists, open it
        if (tasks != null) FlutterDownloader.open(taskId: id);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title,style: TextStyle(color: textColor),),
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
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context,index){
              return documentData(widget.data[index]["title"],widget.data[index]["file"],index);
            },
          ),
        ),
      ),
    );
  }
  documentData(String title, String url, int i){
    return Padding(
      padding: EdgeInsets.all(8),
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
            child: ListTile(
              leading: Text('${i+1}'),
              title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'fancy',fontSize: 16)),
              trailing: Icon(Icons.download_outlined,color: textColor,),
              onTap: (){
                _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Download started"));
                _downloadFile(url, title);
               // _launchInWebViewWithJavaScript(url);
              },
            )
        ),
      ),
    );
  }
  _downloadFile(String url, String filename) async {
    final status = await Permission.storage.request();
    if(status.isGranted){
      String _localPath =
          (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        //url: "https://cdn.britannica.com/82/150182-050-800BBE18/Gurudongmar-Lake-Himalayas-India-Sikkim.jpg",
        savedDir: _localPath,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true,
      );
    }
  }

  _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path;
  }
  _downloadListener() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" && progress == 100 && id != null) {
        String query = "SELECT * FROM task WHERE task_id='" + id + "'";
        var tasks = FlutterDownloader.loadTasksWithRawQuery(query: query);
        //if the task exists, open it
        if (tasks != null) FlutterDownloader.open(taskId: id);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }
  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
