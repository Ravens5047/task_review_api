import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_api_review/components/app_dialog.dart';
import 'package:task_api_review/pages/home/widgets/card_task.dart';
import 'package:task_api_review/components/td_search_box.dart';
import 'package:task_api_review/models/task_model.dart';
import 'package:task_api_review/resources/app_color.dart';
import 'package:task_api_review/services/remote/body/task_body.dart';
import 'package:task_api_review/services/remote/task_services.dart';
import 'package:task_api_review/utils/enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final addController = TextEditingController();
  final editController = TextEditingController();
  final addFocus = FocusNode();
  final editFocus = FocusNode();
  bool showAddBox = false;

  ///===========================///
  TaskServices taskServices = TaskServices();
  List<TaskModel> tasks = [];
  List<TaskModel> tasksSearch = [];

  @override
  void initState() {
    super.initState();
    // addController.addListener(() {
    //   setState(() {}); // lắng nghe và setState() khi TextField thay đổi
    // });
    _getTasks();
  }

  // Get List Task
  Future<void> _getTasks() async {
    final query = {'deleted': false};

    taskServices.getListTask(queryParams: query).then((response) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success'] == true) {
        List<Map<String, dynamic>> maps = (data['body']['docs'] ?? [])
            .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
        tasks = maps.map((e) => TaskModel.fromJson(e)).toList();
        tasksSearch = [...tasks];
        setState(() {});
      } else {
        print('object message ${data['message']}');
      }
    }).catchError((onError) {
      print('$onError 😐');
    });
  }

  void _createTask() {
    final body = TaskBody()
      ..name = addController.text.trim()
      ..description = 'Hello World'
      ..status = StatusType.PROCESSING.name;

    taskServices.createTask(body).then((response) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success'] == true) {
        TaskModel obj = TaskModel.fromJson(data['body']);
        tasks.add(obj);
        tasksSearch = [...tasks];
        addController.clear();
        searchController.clear();
        setState(() {});
      } else {
        print('object message ${data['message']}');
      }
    }).catchError((onError) {
      print('object $onError');
    });
  }

  void _updateTask(TaskBody body) {
    taskServices.updateTask(body).then((response) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        tasks.singleWhere((element) => element.id == body.id)
          ..name = body.name
          ..description = body.description
          ..status = body.status;
        tasksSearch.singleWhere((element) => element.id == body.id)
          ..name = body.name
          ..description = body.description
          ..status = body.status;
        setState(() {});
      } else {
        print('object message ${data['message']}');
      }
    }).catchError((onError) {
      print('object $onError');
    });
  }

  void _deleteTask(String id) {
    taskServices.deleteTask(id).then((response) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        tasks.removeWhere((element) => (element.id ?? '') == id);
        tasksSearch.removeWhere((element) => (element.id ?? '') == id);
        setState(() {});
      } else {
        print('object message ${data['message']}');
      }
    }).catchError((onError) {
      print('object $onError');
    });
  }

  void _search(String searchText) {
    searchText = searchText.toLowerCase();
    // tasksSearch = tasks
    //     .where((element) =>
    //         (element.name ?? '').toLowerCase().contains(searchText))
    //     .toList();

    tasksSearch.clear();
    for (TaskModel task in tasks) {
      if ((task.name ?? '').toLowerCase().contains(searchText)) {
        tasksSearch.add(task);
      }
    }

    setState(() {});
  }

  void _onEdit(TaskModel task) {
    // close all edit task before open new edit task
    for (var element in tasks) {
      element.isEditing = false;
    }
    task.isEditing = true;
    editController.text = task.name ?? '';
    editFocus.requestFocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TdSearchBox(
                  controller: searchController,
                  onChanged: (searchText) {
                    _search(searchText);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(
                height: 2.0,
                indent: 20.0,
                endIndent: 20.0,
                color: AppColor.primary,
              ),
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'Tasks is empty',
                          style:
                              TextStyle(color: AppColor.brown, fontSize: 20.0),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ).copyWith(top: 16.0, bottom: 86.0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: tasksSearch.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            TaskModel task = tasksSearch[index];
                            return CardTask(
                              task,
                              screenIndex: 0,
                              editController: editController,
                              editFocus: editFocus,
                              onTap: () {
                                final body = TaskBody()
                                  ..id = task.id
                                  ..name = task.name
                                  ..description = task.description
                                  ..status = task.status == StatusType.DONE.name
                                      ? StatusType.PROCESSING.name
                                      : StatusType.DONE.name;
                                _updateTask(body);
                              },
                              onEdit: () => _onEdit(task),
                              onLongPress: () => _onEdit(task),
                              onSave: () {
                                final body = TaskBody()
                                  ..id = task.id
                                  ..name = editController.text.trim()
                                  ..description = task.description
                                  ..status = task.status;
                                _updateTask(body);

                                task.isEditing = false;
                                setState(() {});
                              },
                              onCancel: () {
                                task.isEditing = false;
                                setState(() {});
                              },
                              onDeleted: () => AppDialog.dialog(
                                context,
                                title: '😐',
                                content: 'Do you want to delete this task?',
                                action: () => _deleteTask(task.id ?? ''),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16.0),
                        ),
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          bottom: 12.0,
          child: Row(
            children: [
              Expanded(
                child: Visibility(
                  visible: showAddBox,
                  replacement: const Text('Hoàng ABC 😍'),
                  child: _addBox(),
                ),
              ),
              const SizedBox(width: 16.0),
              _addButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addButton() {
    return GestureDetector(
      onTap: () {
        if (showAddBox == true) {
          if (addController.text.isNotEmpty) {
            _createTask();
          }
          addFocus.unfocus();
          showAddBox = false;
          setState(() {});
        } else {
          showAddBox = true;
          addFocus.requestFocus();
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColor.primary,
          border: Border.all(color: AppColor.red.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Icon(Icons.add, size: 32.0, color: AppColor.white),
      ),
    );
  }

  Widget _addBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.6, vertical: 3.6),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.orange, width: 1.2),
        borderRadius: BorderRadius.circular(8.6),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: addController,
        focusNode: addFocus,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Add a new todo item',
          hintStyle: TextStyle(color: AppColor.grey),
        ),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
