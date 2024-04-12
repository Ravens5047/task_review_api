import 'package:flutter/material.dart';
import 'package:task_api_review/components/button/td_elevated_button.dart';
import 'package:task_api_review/models/task_model.dart';
import 'package:task_api_review/resources/app_color.dart';
import 'package:task_api_review/utils/enum.dart';
import 'package:task_api_review/utils/extension.dart';

class CardTask extends StatelessWidget {
  const CardTask(
    this.task, {
    super.key,
    this.editController,
    this.editFocus,
    this.onTap,
    this.onEdit,
    this.onSave,
    this.onCancel,
    this.onDeleted,
    this.onRestore,
    this.onConfirmYes,
    this.onConfirmNo,
    this.onLongPress,
    this.onSelected,
    this.onHorizontalDragEnd,
    this.confirmDeleteText = 'Delete Task?',
    required this.screenIndex,
  });

  final TextEditingController? editController;
  final FocusNode? editFocus;
  final Function()? onTap;
  final Function()? onEdit;
  final Function()? onSave;
  final Function()? onCancel;
  final Function()? onDeleted;
  final Function()? onRestore;
  final Function()? onConfirmYes;
  final Function()? onConfirmNo;
  final Function()? onLongPress;
  final Function()? onSelected;
  final Function(DragEndDetails details)? onHorizontalDragEnd;
  final String confirmDeleteText;
  final int screenIndex;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    const iconSize = 18.0;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(10.0),
      topRight: Radius.circular(24.6),
      bottomLeft: Radius.circular(24.6),
      bottomRight: Radius.circular(10.0),
    );
    const boxShadow = BoxShadow(
      color: AppColor.shadow,
      offset: Offset(0.0, 3.0),
      blurRadius: 6.0,
    );

    return task.isEditing
        ? Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: borderRadius,
              boxShadow: [boxShadow],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey),
                    borderRadius: borderRadius,
                  ),
                  child: TextFormField(
                    controller: editController,
                    focusNode: editFocus,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TdElevatedButton.smallOutline(
                      onPressed: onSave,
                      borderColor: AppColor.green,
                      text: 'Save',
                      textColor: AppColor.green,
                      icon: const Icon(Icons.save,
                          size: 18.0, color: AppColor.green),
                    ),
                    const SizedBox(width: 14.6),
                    TdElevatedButton.smallOutline(
                      onPressed: onCancel,
                      text: 'Cancel',
                      icon: const Icon(Icons.cancel,
                          size: 18.0, color: AppColor.red),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Stack(
            children: [
              Positioned(
                child: GestureDetector(
                  onTap: onTap,
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onLongPress: onLongPress,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 12.0, right: 0.0, bottom: 0.0),
                          decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: borderRadius,
                            boxShadow: [boxShadow],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    task.status == StatusType.DONE.name
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    size: iconSize,
                                    color: AppColor.primary,
                                  ),
                                  const SizedBox(width: 8.6),
                                  Expanded(
                                    child: Text(
                                      (task.name ?? '--:--'),
                                      style: TextStyle(
                                          color: task.status ==
                                                  StatusType.DONE.name
                                              ? AppColor.brown.withOpacity(0.68)
                                              : AppColor.dark500,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: task.status ==
                                                  StatusType.DONE.name
                                              ? FontStyle.italic
                                              : FontStyle.normal),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Created: ',
                                    style: TextStyle(
                                        color: AppColor.brown,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Text(
                                      task.createdAt.toDateTime,
                                      style: const TextStyle(
                                          color: AppColor.grey, fontSize: 12.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (screenIndex != 3)
                                    IconButton(
                                      onPressed: onEdit,
                                      icon: const Icon(Icons.edit,
                                          size: iconSize,
                                          color: AppColor.orange),
                                    ),
                                  if (screenIndex == 3)
                                    IconButton(
                                      onPressed: onRestore,
                                      icon: const Icon(Icons.restore,
                                          size: iconSize,
                                          color: AppColor.green),
                                    ),
                                  IconButton(
                                    onPressed: onDeleted,
                                    icon: const Icon(Icons.delete,
                                        size: iconSize, color: AppColor.red),
                                  ),
                                  if (screenIndex == 3)
                                    IconButton(
                                      onPressed: onSelected,
                                      icon: Icon(
                                          task.isSelected
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off_outlined,
                                          size: iconSize,
                                          color: AppColor.primary),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: AnimatedScale(
                  scale: task.isConfirmDelete ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  alignment: Alignment.center,
                  child: Container(
                    width: 176.0,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: borderRadius,
                      boxShadow: [boxShadow],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8.6),
                        Text(
                          confirmDeleteText,
                          style: const TextStyle(
                              color: AppColor.brown, fontSize: 16.0),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.6, vertical: 8.0),
                          height: 1.0,
                          color: AppColor.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: onConfirmYes,
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: AppColor.primary, fontSize: 16.0),
                              ),
                            ),
                            Container(
                                width: 1.2, height: 16.0, color: AppColor.grey),
                            GestureDetector(
                              onTap: onConfirmNo,
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    color: AppColor.primary, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
