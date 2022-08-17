import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class HomeController {
  static const String baseUrl = "http://192.168.0.119";

  Map urls = {true: "$baseUrl/H", false: "$baseUrl/L"};

  onTapConnect(val) async {
    print(val);
    try {
      final resp = await http
          .post(Uri.parse(urls[val]))
          .timeout(const Duration(seconds: 15))
          .catchError((err) {}, test: (error) => error is int && error >= 400);
    } on SocketException catch (error) {
      return "SocketException";
    } on TimeoutException catch (error) {
      return "TimeoutException";
    } on Exception catch (error) {
      return "Exception";
    }
  }

  onTapClose() async {
    try {
      final resp = await http
          .post(Uri.parse("$baseUrl/Close"))
          .timeout(const Duration(seconds: 15))
          .catchError((err) {}, test: (error) => error is int && error >= 400);
    } on SocketException catch (error) {
      return "SocketException";
    } on TimeoutException catch (error) {
      return "TimeoutException";
    } on Exception catch (error) {
      return "Exception";
    }
  }
}
