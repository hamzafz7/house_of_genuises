import 'package:house_of_genuises/data/models/question_model.dart';

class QuizzModel {
  String? title;
  String? description;
  List<QuestionModel>? questions;
  QuizzModel({this.description, this.questions, this.title});
  QuizzModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    questions = json['questions'] != null
        ? List<QuestionModel>.from(
            json['questions']?.map((e) => QuestionModel.fromJson(e)))
        : [];
  }
}
