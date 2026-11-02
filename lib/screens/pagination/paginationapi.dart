import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Paginationapi extends GetxController {
  // List to store all posts
  RxList<dynamic> li = <dynamic>[].obs;

  // Loading and pagination states
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  final String api = "https://jsonplaceholder.typicode.com/posts";

  final int limit = 10;

  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    li.clear();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // Prevent duplicate requests
    if (isLoading.value || !hasMore.value) return;

    try {
      isLoading.value = true;

      final response = await dio.get(
        api,
        queryParameters: {'_start': li.length, '_limit': limit},
      );

      final List<dynamic> posts = response.data;

      if (posts.isEmpty) {
        hasMore.value = false;
      }

      li.addAll(posts);
      isLoading.value = false;
      print("Total posts loaded: ${li.length}");
    } catch (e) {
      print("API Error: $e");
    } finally {}
  }
}

// Future nextPage() async {
//     if (len.value != 10) {
//       len = len + 1;
//       start += 10;
//       li.clear();
//       fetchPosts();
//     }
//   }

//   Future prevPage() async {
//     if (len.value != 1) {
//       len = len - 1;
//       start -= 10;
//       li.clear();
//       fetchPosts();
//     }
//   }
