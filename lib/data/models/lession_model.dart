class LessionModel {
  final int id;
  final String title;
  final String link;
  final int time;
  final int isVisible;
  final bool? isOpen;
  bool? isPaid;
  final String type;
  final int chapterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  LessionModel({
    required this.id,
    required this.title,
    required this.link,
    required this.time,
    required this.isVisible,
    required this.isOpen,
    this.isPaid,
    required this.type,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessionModel.fromJson(Map<String, dynamic> json) {
    return LessionModel(
        id: json['id'],
        title: json['title'],
        link: json['link'],
        time: json['time'],
        isVisible: json['is_visible'],
        isOpen: json['is_open'],
        type: json['type'],
        chapterId: json['chapter_id'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        isPaid: json['is_paid']);
  }
}
