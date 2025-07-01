import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/theme/app_text_styles.dart';

class HabitItem extends StatefulWidget {
  final String title;
  const HabitItem({super.key, required this.title});

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  bool isDone = false;

  void markAsDoneTemporarily() {
    setState(() {
      isDone = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isDone = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: markAsDoneTemporarily,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.teal),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(widget.title, style: AppTextStyles.headline1.copyWith(fontSize: 16.sp)),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isDone
                  ? Icon(Icons.done, key: const ValueKey('done'), color: Colors.green)
                  : Icon(Icons.arrow_forward_ios, key: const ValueKey('arrow'), size: 16.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
