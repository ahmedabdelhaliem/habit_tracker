import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/theme/app_color.dart';
import 'package:habit_tracker/core/theme/app_text_styles.dart';
import 'package:habit_tracker/features/habits/data/habit_model.dart';
import 'package:hive/hive.dart';

class AddHabitScreenBody extends StatefulWidget {
  const AddHabitScreenBody({super.key});

  @override
  State<AddHabitScreenBody> createState() => _AddHabitScreenBodyState();
}

class _AddHabitScreenBodyState extends State<AddHabitScreenBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  String selectedFrequency = 'يومي'; 

  void _saveHabit() {
    final name = nameController.text.trim();
    final repetitions = int.tryParse(countController.text.trim()) ?? 1;

    if (name.isNotEmpty) {
      final habit = HabitModel(name: name, repetitions: repetitions, frequency: selectedFrequency);

      final box = Hive.box<HabitModel>('habits');
      box.add(habit); 
      Navigator.of(context).pop(); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى إدخال اسم العادة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اسم العادة', style: AppTextStyles.headline1),
              SizedBox(height: 8.h),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'مثل: قراءة، رياضة...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.h),
              Text('عدد التكرارات', style: AppTextStyles.headline1),
              SizedBox(height: 8.h),
              TextFormField(
                controller: countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'مثال: 1 أو 3 مرات',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.h),
              Text('نوع التكرار', style: AppTextStyles.headline1),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                items: [
                  'يومي',
                  'أسبوعي',
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedFrequency = val!;
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveHabit,
                  icon: Icon(Icons.save),
                  label: Text('إضافة العادة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
