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
  final String? name;
  final String? image;
  final String? telegramChannelLink;
  final bool? isOpen;
  List<String>? teachers;
  bool? isTeachWithCourse;
  final bool? isVisible;
  final bool? isPaid;

  CourseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.telegramChannelLink,
    required this.isOpen,
    required this.isVisible,
    this.teachers,
    this.isTeachWithCourse,
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
        isTeachWithCourse: json['is_teach_this_course'],
        teachers: json['teachers'] != null
            ? List<String>.from(json['teachers'])
            : []);
  }
}
