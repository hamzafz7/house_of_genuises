import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/info_widget.dart';

class QuizInfoWidget extends StatelessWidget {
  const QuizInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366.w,
      height: 209.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: const [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Color.fromARGB(255, 235, 230, 230))
          ]),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoWidget(
                  color: Colors.purple, text: "عدد الاسئلة ", number: "20"),
              SizedBox(
                width: 40,
              ),
              InfoWidget(
                  color: Colors.blue,
                  text: "عدد الاسئلة المتجاوزة",
                  number: "05")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoWidget(
                  color: Colors.red, text: "الإجايات الخاطئة", number: "05"),
              SizedBox(
                width: 40,
              ),
              InfoWidget(
                  color: Colors.green, text: "الإجابات الصحيحة", number: "05")
            ],
          ),
        ],
      ),
    );
  }
}
