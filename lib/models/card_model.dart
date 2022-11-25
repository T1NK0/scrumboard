class CardModel {
  late String title;
  late String description;
  late String priority;
  late String status;
  late String user;

  CardModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.user,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    title:
    json['title'];
    description:
    json['description'];
    priority:
    json['priority'];
    status:
    json['status'];
    user:
    json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['status'] = status;
    data['user'] = user;
    return data;
  }
}
