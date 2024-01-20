import 'package:house_of_genuises/data/models/chapter_model.dart';
import 'package:house_of_genuises/data/models/value_of_course_modrel.dart';

class CourseInfoResponse {
  CourseInfoModel? course;
  CourseInfoResponse.fromJson(Map<String, dynamic> json) {
    course =
        json['data'] != null ? CourseInfoModel.fromJson(json['data']) : null;
  }
}

class CourseInfoModel {
  int? id;
  String? name;
  String? image;
  String? telegramChannelLink;
  bool? isOpen;
  bool? isVisible;
  bool? isPaid;
  int? totalTime;
  List<String>? teachers;
  List<ChapterModel>? chapters;
  List<ValueOfCourse>? valuesOfCourse;
  String? message;
  CourseInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    telegramChannelLink = json['telegram_channel_link'];
    isOpen = json['is_open'];
    isVisible = json['is_visible'];
    isPaid = json['is_paid'];
    totalTime = json['total_time'];
    teachers =
        json['teachers'] != null ? List<String>.from(json['teachers']) : null;
    chapters = json['chapters'] != null
        ? List<ChapterModel>.from(
            json['chapters'].map((e) => ChapterModel.formJson(e)))
        : null;
    valuesOfCourse = json['values_of_course'] != null
        ? List<ValueOfCourse>.from(
            json['values_of_course'].map((e) => ValueOfCourse.fromJson(e)))
        : null;
    message = json['message'];
  }
}
