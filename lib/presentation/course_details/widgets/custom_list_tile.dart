import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/data/models/chapter_model.dart';

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
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          child: ExpansionTile(
            expandedAlignment: Alignment.topRight,
            backgroundColor: Colors.white,
            title: Text(
              chapterModel.name ?? "لا يوجد اسم لهذا الكورس",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16.sp),
            ),
            children: const [Text("gggg"), Text("hhhhh")],
          ),
        ),
      ),
    );
  }
}
