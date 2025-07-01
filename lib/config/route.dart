import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/data/habit_model.dart';
import 'package:habit_tracker/features/habits/presentation/screen/add_habit_screen.dart';
import 'package:habit_tracker/features/habits/presentation/screen/details_habit.dart';
import 'package:habit_tracker/features/habits/presentation/screen/habit_module.dart';
import 'package:habit_tracker/features/habits/presentation/screen/summary_screen.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/summary_screen_body.dart';

abstract class AppRouter {
  static const kHabitModule = '/HabitModule';
  static const kAddHabitScreen = '/AddHabitScreen';
  static const kHabitDetailsScreen = '/HabitDetailsScreen';
  static const kSummaryHabitScreen = '/SummaryHabitScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HabitModule(), // ✅ تم إصلاحه
      ),
      GoRoute(path: kHabitModule, builder: (context, state) => const HabitModule()),
      GoRoute(path: kAddHabitScreen, builder: (context, state) => const AddHabitScreen()),
      GoRoute(
        path: kHabitDetailsScreen,
        builder: (context, state) {
          final habit = state.extra as HabitModel;
          return HabitDetailsScreen(habit: habit);
        },
      ),
     GoRoute(
  path: kSummaryHabitScreen,
  builder: (context, state) {
    final habit = state.extra as HabitModel; // <-- هنا يتوقع HabitModel
    return SummaryScreen(habit: habit);
  },
),

    ],
  );
}
