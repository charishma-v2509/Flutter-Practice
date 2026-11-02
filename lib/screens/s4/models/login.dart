// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class Login extends GetxController {
  Dio dio = Dio();

  final nameCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final _loginapi =
      "https://devapi.instituterun.com/employees/EmployeeLogins/UserLogin";
  final _passwordapi =
      "https://devapi.instituterun.com/employees/EmployeeLogins/UserLoginPasswordScreen";
  final _instdetailsapi =
      "https://devapi.instituterun.com/manageinstitute/InstituteDetails/GetInstituteDetailsById";
  String token =
      "yJhbGciOiJIUzI1NiIsImtpZCI6ImF1dGhLZXkiLCJ0eXAiOiJKV1QifQ.eyJqdGkiOiJmMjdmMGY3MS02NjkxLTRlZTItYTAyZS0wNDAwOGRmOGFmNzciLCJpYXQiOjE3OTE4Njg1ODQsIlVzZXJUeXBlSUQiOiIxIiwiVXNlcklEIjoiOTA2OCIsIkluc3RpdHV0ZUlEIjoiMTEyMiIsIkNsYXNzRGVwSUQiOiIzMjUyIiwiU2VjdGlvbkRlc2lnSUQiOiIzMjkzIiwiQWNhZGFtaWNZZWFyQ29kZSI6IjIwNjQiLCJSb2xlSUQiOiI0IiwiUm9sZUlEcyI6IjQiLCJuYmYiOjE3OTE4Njg1ODQsImV4cCI6MTc5MTk1NDk4NCwiaXNzIjoiaW5zdGl0dXRlcnVuLmNvbSIsImF1ZCI6Ikluc3RpdHV0ZVVzZXJzIn0.0pcM_c38tU3fmubcfvQhIyucd5vw9mFSiwLvbOdfCTg";

  RxBool isUserCorrect = false.obs;

  void validateUserName() async {
    final url = "$_loginapi?username=${nameCtrl.text}";
    final res = await dio.post(
      url,
      options: Options(
        contentType: 'application/json',
        headers: {"Content-Type": "application/json"},
      ),
    );
    print(res.data);
    if (res.data["success"]) {
      isUserCorrect.value = true;
    } else {
      isUserCorrect.value = false;
    }
  }

  Future<void> valdiatePassword() async {
    var body = {
      "username": nameCtrl.text,
      "password": passCtrl.text,
      "isAppUser": true,
    };
    final res = await dio.post(
      _passwordapi,
      data: body,
      options: Options(
        contentType: 'application/json',
        headers: {"Content-Type": "application/json"},
      ),
    );
    if (res.data["success"]) {
      final temp = res.data['data'];
      Hive.box("user").putAll(temp);
      await instituteDetails();

      print(temp);
    } else {}
  }

  Map instituteData = {};

  Future<void> instituteDetails() async {
    final vv = Hive.box("user").get("instituteId");
    final url = "$_instdetailsapi/$vv";
    final res = await dio.get(
      url,
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json, text/plain,charset=utf-8, /',
        },
      ),
    );
    if (res.data["success"]) {
      instituteData = res.data['data'];
    } else {
      print("waste");
    }
  }
}
