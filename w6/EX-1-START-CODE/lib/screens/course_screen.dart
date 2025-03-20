import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/courses_provider.dart';
import '../models/course.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseName});

  final String courseName;

  void _addScore(BuildContext context, Course course) async {
    final CourseScore? newScore = await Navigator.of(
      context,
    ).push<CourseScore>(MaterialPageRoute(builder: (ctx) => CourseScoreForm()));

    if (newScore != null) {
      Provider.of<CourseProvider>(
        context,
        listen: false,
      ).addScore(courseName, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CourseProvider>(context);
    final course = coursesProvider.getCourseFor(courseName);
    final scores = course.scores;

    Widget content = const Center(child: Text('No Scores added yet.'));

    if (scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: scores.length,
        itemBuilder:
            (ctx, index) => ListTile(
              title: Text(scores[index].studentName),
              trailing: Text(
                scores[index].studentScore.toString(),
                style: TextStyle(
                  color: scoreColor(scores[index].studentScore),
                  fontSize: 15,
                ),
              ),
            ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(course.name, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => _addScore(context, course),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}