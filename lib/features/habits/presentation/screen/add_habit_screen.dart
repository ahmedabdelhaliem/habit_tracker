import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/widget/custom_appbar.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_screen_body.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: CustomAppBar(title: 'AddHabitScreen', showBack: true),
      body: SafeArea(child: SingleChildScrollView(child: AddHabitScreenBody())),
    );
  }
}
