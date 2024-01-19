import 'package:house_of_genuises/data/models/lession_model.dart';

class ChapterModel {
  int? id;
  String? name;
  bool? isVisible;
  List<LessionModel>? lessons;

  ChapterModel.formJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isVisible = map['is_visible'];
    lessons = map['lesions'] != null
        ? List<LessionModel>.from(
            map['lesions'].map((e) => LessionModel.fromJson(e)))
        : null;
  }
}
