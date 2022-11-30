class TaskModel {
  late String ident;
  late String title;
  late String description;
  late String priority;
  late String status;
  late String user;

  TaskModel({
    required this.ident,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.user,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    ident = json['ident'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ident": ident,
        "title": title,
        "description": description,
        "priority": priority,
        "status": status,
        "user": user,
      };
}
