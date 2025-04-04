import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseProvider extends ChangeNotifier {
  final List<Course> _courses = [Course(name: 'HTML'), Course(name: 'JAVA')];

  List<Course> get courses => [..._courses];

  void addCourse(Course course) {
    if (!_courses.any((c) => c.name == course.name)) {
      _courses.add(course);
      notifyListeners();
    }
  }

  void updateCourse(Course updatedCourse) {
    int index = _courses.indexWhere((c) => c.name == updatedCourse.name);
    if (index != -1) {
      _courses[index] = updatedCourse;
      notifyListeners();
    }
  }

  void removeCourse(String courseName) {
    _courses.removeWhere((c) => c.name == courseName);
    notifyListeners();
  }

  Course getCourseFor(String name) {
    return _courses.firstWhere((course) => course.name == name);
  }

  void addScore(String courseName, CourseScore score) {
    final course = getCourseFor(courseName);
    course.scores.add(score);
    notifyListeners();
  }
}
