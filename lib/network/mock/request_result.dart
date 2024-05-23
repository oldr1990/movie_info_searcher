import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie_info_searcher/network/model_response.dart';

Future<Result<T>> requestResult<T extends Object>(
    String url, T Function(Map<String, dynamic>) parser) async {
  try {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 401) {
      log(response.body);
      return Success(parser(jsonDecode(response.body)));
    } else {
      log(response.statusCode.toString());
      return Error("Unexpected error! ${response.statusCode}");
    }
  } on SocketException {
    return Error("Please, check your internet connection and try again.");
  } catch (e) {
    return Error("Unknown error occupied!");
  }
}
