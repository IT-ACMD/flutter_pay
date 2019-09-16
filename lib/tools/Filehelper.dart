import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Filehelper{
  //example
  //{
    //File myfile = new File('$appDocPath/myfile.txt');
    //myfile.writeAsString('nihaoxiabi').then((val){
      //myfile.readAsString().then((val){
        //print(val);
      //});
    //});
  //}

  static getCacheUrl() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  static getAppdataUrl() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }
}