import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/models/chapter_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_lesson%20widget.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.chapterModel});
  final ChapterModel chapterModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Card(
          color: CacheProvider.getAppTheme() ? kprimaryBlueColor : null,
          surfaceTintColor:
              CacheProvider.getAppTheme() ? kDarkBlueColor : Colors.white,
          shadowColor: Colors.grey,
          child: ExpansionTile(
              iconColor:
                  CacheProvider.getAppTheme() ? Colors.white : kDarkBlueColor,
              collapsedIconColor:
                  CacheProvider.getAppTheme() ? Colors.white : kDarkBlueColor,
              expandedAlignment: Alignment.topRight,
              backgroundColor:
                  CacheProvider.getAppTheme() ? kDarkBlueColor : Colors.white,
              title: Text(
                chapterModel.name ?? "لا يوجد اسم لهذا الكورس",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.sp),
              ),
              children: chapterModel.lessons != null &&
                      chapterModel.lessons!.isNotEmpty
                  ? List.generate(
                      chapterModel.lessons!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CourseLessonWidget(
                                lessionModel: chapterModel.lessons![index]),
                          ))
                  : [
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("لا يوجد دروس لهذا الفصل"))
                    ]),
        ),
      ),
    );
  }
}
