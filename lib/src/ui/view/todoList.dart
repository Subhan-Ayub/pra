// ignore_for_file: avoid_unnecessary_containers, file_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_task/src/controllers/todoListController.dart';
import 'package:flutter_task/src/ui/widgets/textfield.dart';
import 'package:flutter_task/src/utils/helpers/db_helper.dart';
import 'package:flutter_task/src/utils/models/task_model.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    TodoListController _ = Get.find<TodoListController>();

    return Scaffold(
      body: body(_),
      floatingActionButton: floatingBtn(_).marginOnly(bottom: 40),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  FloatingActionButton floatingBtn(TodoListController _) {
    return FloatingActionButton(
      onPressed: () {
        // Get.dialog(AlertDialog(
        //   actions: [
        //     ReuseableTextfield(
        //       labelText: 'Name',
        //       controller: _.add,
        //     ).marginOnly(top: 30, bottom: 10),
        //     Center(
        //         child: ElevatedButton(
        //             onPressed: () {
        //               if (_.add.text.isNotEmpty) {
        //                 _.save();
        //                 Get.back();
        //                 _.add.text = '';
        //               } else {
        //                 Get.snackbar('Error', 'Name field is required',
        //                     backgroundColor: Colors.red,
        //                     colorText: Colors.white,
        //                     snackPosition: SnackPosition.BOTTOM);
        //               }
        //             },
        //             child: const Text('ADD')))
        //   ],
        // ));
        // _.db.insertTask(Task(id: 1, title: 'sssss', completed: true));
        _.db.getTasks();
      },
      backgroundColor: Colors.black,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  SafeArea body(TodoListController _) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'TODO',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          ReuseableTextfield(
            labelText: 'Search',
            controller: _.search,
            onchange: (text) {
              _.filtering(text);
            },
          ),
          Container(
            height: Get.height / 1.36,
            width: Get.width,
            child: users(_),
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }

  AnimationLimiter users(TodoListController _) {
    return AnimationLimiter(
        child: Obx(() => _.lodeer.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _.list.length,
                // itemCount:10,

                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(seconds: 5),
                    child: SlideAnimation(
                      verticalOffset: 70.0,
                      child: FadeInAnimation(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(159, 207, 207, 207),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  '${_.list[index]['title']}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _.add.text = _.list[index];
                                        Get.dialog(AlertDialog(
                                          actions: [
                                            ReuseableTextfield(
                                              labelText: 'Name',
                                              controller: _.add,
                                            ).marginOnly(top: 30, bottom: 10),
                                            Center(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_.add.text
                                                          .isNotEmpty) {
                                                        _.edit(index);
                                                        _.add.text = '';
                                                      } else {
                                                        Get.snackbar('Error',
                                                            'Name field is required',
                                                            backgroundColor:
                                                                Colors.red,
                                                            colorText:
                                                                Colors.white,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM);
                                                      }
                                                    },
                                                    child:
                                                        const Text('Update')))
                                          ],
                                        ));
                                      },
                                      child: const Icon(Icons.edit),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        delPopUp(_, index);
                                      },
                                      child: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ).paddingSymmetric(horizontal: 20),
                        ),
                      ),
                    ),
                  );
                },
              )));
  }

  delPopUp(TodoListController _, int index) {
    return Get.dialog(AlertDialog(
      actions: [
        const Center(
          child: Text(
            'Are u sure u what to delete !',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ).marginSymmetric(vertical: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('No')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 255, 0, 0), // Set your desired color here
                ),
                onPressed: () {
                  _.delete(index);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )
      ],
    ));
  }
}
