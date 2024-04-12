class TaskBody {
  String? id;
  String? name;
  String? description;
  String? status;

  TaskBody();

  // factory TaskBody.fromJson(Map<String, dynamic> json) => TaskBody()
  //   ..id = json['id'] as String?
  //   ..name = json['name'] as String?
  //   ..description = json['description'] as String?
  //   ..status = json['status'] as String?;

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
    };
  }
}
