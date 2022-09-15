class Data {
  int? id;
  String title;
  String? createDate;
  bool isCompleted;
  String detail;
  String priority;

  Data({
    this.id,
    required this.title,
    this.createDate,
    required this.isCompleted,
    required this.detail,
    required this.priority,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      createDate: json['createDate'],
      isCompleted: json['isCompleted'],
      detail: json['detail'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toCreateJson() => {
        "title": title,
        "createDate": createDate,
        "isCompleted": isCompleted,
        "detail": detail,
        "priority": priority
      };

  Map<String, dynamic> toUpdateJson() => {
        "id": id,
        "title": title,
        "createDate": createDate,
        "isCompleted": isCompleted,
        "detail": detail,
        "priority": priority
      };
}
