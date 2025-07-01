import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/config/route.dart';
import 'package:habit_tracker/core/theme/app_text_styles.dart';
import 'package:habit_tracker/features/habits/data/habit_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<HabitModel> habitBox = Hive.box<HabitModel>('habits');

    return ValueListenableBuilder(
      valueListenable: habitBox.listenable(),
      builder: (context, Box<HabitModel> box, _) {
        if (box.isEmpty) {
          return Center(child: Text('لا توجد عادات بعد'));
        }

        return ListView.separated(
          itemCount: box.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (context, index) {
            final habit = box.getAt(index)!;
            return ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text(habit.name, style: AppTextStyles.headline1),
              subtitle: Text('${habit.frequency} • ${habit.repetitions} مرة'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'details') {
                    context.push(AppRouter.kHabitDetailsScreen, extra: habit);
                  } else if (value == 'edit') {
                    context.push(AppRouter.kSummaryHabitScreen, extra: habit);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'details', child: Text('تفاصيل')),
                  const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                ],
              ),
              onTap: () {
                context.push('/habitDetails', extra: habit);
              },
            );
          },
        );
      },
    );
  }
}
