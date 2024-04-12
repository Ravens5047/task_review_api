class DeleteTaskBody {
  List<String>? ids;
  String? type;

  DeleteTaskBody();

  // factory DeleteTaskBody.fromJson(Map<String, dynamic> json) => DeleteTaskBody()
  //   ..ids = json['ids'] as List<String>?
  //   ..type = json['type'] as String?;

  Map<String, dynamic> toJson() {
    return {
      if (ids != null) 'ids': ids,
      if (type != null) 'type': type,
    };
  }
}
