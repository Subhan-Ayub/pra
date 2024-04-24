// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_task/src/utils/helpers/api_helpers.dart';
import 'package:flutter_task/src/utils/helpers/db_helper.dart';
import 'package:get/get.dart';

class TodoListController extends GetxController {
  DatabaseHelper db=Get.put(DatabaseHelper());
  TextEditingController add = TextEditingController();
  TextEditingController search = TextEditingController();
  RxBool lodeer= false.obs;
  List data =
      ['ss', 'sse', 'rr', 'ty', 'lou', 'ooo', 'poiu', 'pppww'].obs;
  RxList list = [].obs;
  List? filtered;
  filtering(text) {
    filtered = data
        .where((v) => v['title'].toLowerCase().contains(text.toLowerCase()))
        .toList();
    list(filtered);
  }

  save() async {
    var body = {"title": add.text};

    var check = await apiFetcher(
        'Post', 'https://jsonplaceholder.typicode.com/todos', body);
        fetchData();
    // data.add(add.text);
    // list(data);
  }

  edit(int i) {
    data[i] = add.text;
    list(data);
    Get.back();
  }

  delete(int i) async{
    // data.removeAt(i);
    // list(data);
     var api;
    api = await apiFetcher(
      'Delete',
      'https://jsonplaceholder.typicode.com/todos/1',
    );
// fetchData();
    Get.back();
  }

  fetchData() async {
    lodeer.value=true;
  var api;
    data = await apiFetcher(
      'Get',
      'https://jsonplaceholder.typicode.com/todos',
    );
    // data(api);
    list(data);
    lodeer.value=false;
  }

  @override
  void onInit() async {
    super.onInit();

    // fetchData();

    // list(data);
  }
}
