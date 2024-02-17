import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/courses_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/data/repositories/category_repo.dart';

class MyCoursesController extends GetxController {
  @override
  void onInit() {
    int id = CacheProvider.getUserId();
    getMyCourses(id);
    super.onInit();
  }

  final CategoryRepository _categoryRepository = CategoryRepository();
  var getMyCoursesStatus = RequestStatus.begin.obs;
  updateGetCoursesStatus(RequestStatus status) =>
      getMyCoursesStatus.value = status;
  CoursesModel? model;
  Future<void> getMyCourses(int id) async {
    updateGetCoursesStatus(RequestStatus.loading);
    var response = await _categoryRepository.getMyCourses(id);
    if (response.success) {
      model = CoursesModel.fromJson(response.data);
      if (model!.courses == null || model!.courses!.isEmpty) {
        updateGetCoursesStatus(RequestStatus.noData);
      } else {
        updateGetCoursesStatus(RequestStatus.success);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetCoursesStatus(RequestStatus.noInternentt);
      } else {
        updateGetCoursesStatus(RequestStatus.onError);
      }
    }
  }
}
