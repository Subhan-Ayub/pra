// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter_task/src/bindings/todoListBindings.dart';
import 'package:flutter_task/src/ui/view/todoList.dart';
import 'package:flutter_task/src/utils/routes/appRoutes.dart';
import 'package:get/route_manager.dart';


class AppPages {
  static const String INITIAL = Routes.todo;
  static final List<GetPage<dynamic>> routes = [
    GetPage(
        name: Routes.todo,
        page: () => const TodoList(),
        binding: TodoListBindings(),
        transition: Transition.noTransition),
 

  ];
}
