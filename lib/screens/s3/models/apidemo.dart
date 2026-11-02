import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class Apidemo extends GetxController {
  List abc = [];
  final String _getApi =
      "https://devapi.instituterun.com/visitormanagement/iGuru/Configuration/Sources/GetAllSources";
  final String _addSourceApi =
      "https://devapi.instituterun.com/visitormanagement/iGuru/Configuration/Sources/AddUpdateSources";
  final String _removeApi =
      "https://devapi.instituterun.com/visitormanagement/iGuru/Configuration/Sources/Status/";

  String token =
      "eyJhbGciOiJIUzI1NiIsImtpZCI6ImF1dGhLZXkiLCJ0eXAiOiJKV1QifQ.eyJqdGkiOiJiZmIzMDM3Yi05MWM5LTRlMzgtYWEzMS1lMmU2NDkwZDk5NTgiLCJpYXQiOjE3OTE0MzAzNTksIlVzZXJUeXBlSUQiOiIxIiwiVXNlcklEIjoiMTYwOSIsIkluc3RpdHV0ZUlEIjoiODciLCJDbGFzc0RlcElEIjoiMTE0MyIsIlNlY3Rpb25EZXNpZ0lEIjoiMTEzOSIsIkFjYWRhbWljWWVhckNvZGUiOiIxMyIsIlJvbGVJRCI6WyI5IiwiNCJdLCJSb2xlSURzIjoiOSw0IiwibmJmIjoxNzkxNDMwMzU5LCJleHAiOjE3OTE1MTY3NTksImlzcyI6Imluc3RpdHV0ZXJ1bi5jb20iLCJhdWQiOiJJbnN0aXR1dGVVc2VycyJ9.m66VMbylLZxaHWKy4vugzeH547TfmEkG6EaQwrpazAk";
  Dio dio = Dio();
  Future getUser() async {
    final res = await dio.post(
      data: {"pageNumber": 1, "pageSize": 10, "instituteID": 87},
      _getApi,
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json, text/plain,charset=utf-8, /',
        },
      ),
    );
    // print(res.data);
    // print(res.statusCode);
    abc = (res.data["data"]);
    debugPrint(abc.toString());

    debugPrint("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVV");
    debugPrint(abc.where((ee) => ee['status'] == true).toString());
  }

  Future updateSource(int index, String source, String description) async {
    final item = abc[index];
    item["source"] = source;
    item["description"] = description;
    final res = await dio.post(
      data: {
        "sourceID": item['sourceID'],
        "source": item['source'],
        "description": item['description'],
        "status": true,
        "instituteID": 87,
      },
      _addSourceApi,
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json, text/plain,charset=utf-8, /',
        },
      ),
    );
    if (res.statusCode == 200) {
      update(['hello']);
      debugPrint(res.data);
    } else {
      debugPrint("Someting webt wrong");
    }
  }

  Future inactiveSource(int index) async {
    final item = abc[index];
    final url = "$_removeApi${item["sourceID"]}";
    final res = await dio.put(
      url,
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json, text/plain,charset=utf-8, /',
        },
      ),
    );
    if (res.statusCode == 200) {
      abc.removeAt(index);
      update(['hello']);
      debugPrint(res.data);
    } else {
      throw Exception("Could not deactivate source (status ${res.statusCode})");
    }
  }

  Future addSource(String source, String des) async {
    final res = await dio.post(
      data: {
        "sourceID": 0,
        "source": source,
        "description": des,
        "status": true,
        "instituteID": 87,
      },
      _addSourceApi,
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json, text/plain,charset=utf-8, /',
        },
      ),
    );
    if (res.statusCode == 200) {
      update(['hello', 'chaloo']);
      debugPrint(res.data);
    } else {
      debugPrint("Someting went wrong");
    }
  }
}
