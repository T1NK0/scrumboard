class CardModel {
  final String title;
  final String description;
  final int priority;
  final int status;
  final String user;

  const CardModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.user,
  });

  static CardModel fromJson(json) => CardModel(
        title: json['title'],
        description: json['description'],
        priority: json['priority'],
        status: json['status'],
        user: json['user'],
      );
}
