
// ignore_for_file: file_names

import 'package:get/get.dart';

import '../controllers/todoListController.dart';

class TodoListBindings extends Bindings{
   @override
  void dependencies(){
    Get.lazyPut<TodoListController>(() => TodoListController());
  }
}