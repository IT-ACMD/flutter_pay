//异步请求数据
import 'dart:convert';

import 'dart:io';

import 'package:flutter_app/data/dataCenter.dart';

import '../config.dart';

typedef Future<bool> HttpAuthenticationCallback(
    Uri uri, String scheme, String realm);

class ECHttp {
  static getData(url, list) async {
    print('------getData--------');
    var httpClient = new HttpClient();
    var result;
    try {
      //请求路径
      var request = await httpClient.getUrl(Uri.parse('$eServiceUrl$url'));
      //添加请求头
      for (int i = 0; i < list.length; i++) {
        request.headers.add(list[i]['name'], list[i]['value']);
      }
      //返回值
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        print('getData请求成功');
        var json = await response.transform(utf8.decoder).join();
        result = json;
      } else {
        //result = 'Error getting json data:\nHttp status ${response.statusCode}';
        result = null;
      }
    } catch (exception) {
      //result = 'Faild getting json data';
      result = null;
    }
    return result;
  }

  /** 
   * params "mobile=$phone&smsCode=$code"
   */
  static postData(String url, String params) async {
    print('------postData--------');
    var result;
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse('$eServiceUrl$url'));

    // 设置请求头
    request.headers.set(
        HttpHeaders.contentTypeHeader, 'application/x-www-form-urlencoded');
    var token = getToken();
    request.headers.set(HttpHeaders.authorizationHeader, token);
    request.headers.add('deviceId', '008');

    /// 添加请求体
    request.write(params);

    try {
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.ok) {
        print('postData请求成功');
        print(responseBody);
        result = responseBody;
      }
    } catch (exception) {
      print('postData请求失败');
      result = null;
    }
    return result;
  }

  static postDataJson(String url, Map map,
      [String userName, String userPwd]) async {
    print('------postDataJson--------');
    var result;
    HttpClient httpClient = new HttpClient();

    /*httpClient.authenticate = (Uri url, String scheme, String realm) async {
      //if (url.host == "xx.com" && realm == "admin") {
      httpClient.addCredentials(
        url,
        "admin",
        new HttpClientBasicCredentials("+86", "13657909357"),
      );
      return true;
      //}
      //return false;
    };*/
    //httpClient.addCredentials(Uri.parse('$eServiceUrl$url'), 'admin', credentials);
    //final http = IOClient(httpClient);

    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse('$eServiceUrl$url'));

    // 设置请求头
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    var token = getToken();
    request.headers.set(HttpHeaders.authorizationHeader, token);

    /// 添加请求体
    request.add(utf8.encode(json.encode(map)));

    try {
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.ok) {
        print('postDataJson请求成功');
        print(responseBody);
        result = responseBody;
      }
    } catch (exception) {
      print('postDataJson请求失败');
      result = null;
    }
    return result;
  }
}

HttpAuthenticationCallback _basicAuthenticationCallback(
        HttpClient client, HttpClientCredentials credentials) =>
    (Uri uri, String scheme, String realm) {
      client.addCredentials(uri, realm, credentials);
      return new Future.value(true);
    };

/*.then((data) {
        
      }).catchError((e) {
        //执行失败会走到这里
        showMessageOne(context, 'System error, please try again later!');
      }).whenComplete(() {
        //无论如何走这里
        showMessageOne(context, 'System error, please try again later!');
      });*/
