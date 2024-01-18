class CoursesModel {
  List<CourseModel>? courses;
  String? message;

  CoursesModel({required this.courses, required this.message});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    courses = json['data'] != null
        ? List<CourseModel>.from(
            json['data'].map((e) => CourseModel.fromJson(e)))
        : null;
  }
}

class CourseModel {
  final int id;
  final String name;
  final String image;
  final String telegramChannelLink;
  final bool isOpen;
  final bool isVisible;
  final bool isPaid;

  CourseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.telegramChannelLink,
    required this.isOpen,
    required this.isVisible,
    required this.isPaid,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      telegramChannelLink: json['telegram_channel_link'],
      isOpen: json['is_open'],
      isVisible: json['is_visible'],
      isPaid: json['is_paid'],
    );
  }
}
