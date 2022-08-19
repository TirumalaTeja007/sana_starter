import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../pages/dialogs/efi_error_dialog.dart';

socketException(SocketException error) {
  callErrorDialog(
      "Socket Exception",
      "A connection attempt failed while trying to process the"
          " requested action. ${error.message}");
}

timeoutException(TimeoutException error) {
  callErrorDialog(
      "Timeout Exception",
      "Timed out trying to reach the servers. Make sure you are online and"
          " you have a good internet connection. ${error.message.toString()}");
}

exception(Exception error) {
  callErrorDialog(
      "Exception",
      "We apologize for the inconvenience. A connection attempt failed while "
          "trying to process your request. Please try again after a few moments");
}

void httpErrorResponses(response) {
  Get.closeAllSnackbars();
  final _response = jsonDecode(response.body);
  switch (response.statusCode) {
    case 400:
      callErrorDialog(
          "HTTP 400 - Bad request",
          "We have encountered an error and cannot process your request at"
              " this point of time."
              "\n(Message: ${_response["message"]})");
      break;
    case 401:
      callErrorDialog(
          "HTTP 401 - Unauthorized",
          "There was an error processing your request as "
              "you are not authorized for the selected action. "
              "\n(Message: ${_response["message"]})");
      break;
    case 403:
      callErrorDialog(
          "HTTP 403 - Forbidden",
          "There was an error processing your request. "
              "\n(Message: ${_response["message"]})");
      break;
    case 404:
      callErrorDialog(
          "HTTP 404 - Not found",
          "We could not find what you are looking for. "
              "\n(Message: ${_response["message"]})");
      break;
    case 500:
      callErrorDialog(
          "HTTP 500 - Internal Server Error",
          "We apologize for the inconvenience. We are currently unable to "
              "handle your request. Please try again later "
              "\n(Message: ${_response["message"]})");
      break;
    case 502:
      callErrorDialog(
          "HTTP 502 - Bad Gateway",
          "We apologize for the inconvenience. The web server is temporarily"
              " overloaded and cannot process your request. Please try"
              " again later");
      break;
    case 503:
      callErrorDialog(
          "HTTP 503 - Service Unavailable",
          "We are facing some technical issues. We will have it resolved "
              "shortly so please try again after some time. If the problem persists, "
              "please contact our Technical Support department.");
      break;
    case 504:
      callErrorDialog(
          "HTTP 504 - Service Unavailable",
          "We are facing some technical issues. We will have it resolved "
              "shortly so please try again after some time. If the problem persists, "
              "please contact our Technical Support department.");
      break;
    default:
      callErrorDialog(
          "HTTP ${response.statusCode} - Error",
          "We have encountered an error while processing your request."
              "\n(Message: ${_response["message"]})");
      break;
  }
}
