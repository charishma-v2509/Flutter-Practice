import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxController {
  RxList<UserModel> data = <UserModel>[].obs;


  //   @override
  // void onInit() {
  //   super.onInit();
  //   getUsers();

  //   // initialization logic
  // }

  Future<void> getUsers() async {
    Dio dio = Dio();
    
    final res = await dio.get("https://jsonplaceholder.typicode.com/users");

    data.value = (res.data as List).map((e) => UserModel.fromJson(e)).toList();
  }


}

class UserModel {
  int id;
  String name;
  String username;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
