import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/courses_provider.dart';
import '../models/course.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  // Modified to pass courseName instead of Course object for better state management
  void _editCourse(Course course) async {
    await Navigator.of(context).push<Course>(
      MaterialPageRoute(
        builder:
            (ctx) => CourseScreen(
              courseName: course.name,
            ), // Changed to pass courseName
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access courses through Provider instead of local state
    final coursesProvider = Provider.of<CourseProvider>(context);
    final courses = coursesProvider.courses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder:
            (ctx, index) => Dismissible(
              key: Key(courses[index].name),
              child: CourseTile(course: courses[index], onEdit: _editCourse),
            ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course),
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}