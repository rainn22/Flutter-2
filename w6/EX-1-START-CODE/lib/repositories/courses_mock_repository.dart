import "package:test/models/course.dart";
import "courses_repository.dart";

class MockCoursesRepository extends CoursesRepository {
  final List<Course> courses = [Course(name: "HTML"), Course(name: "JAVA")];

  @override
  List<Course> getCourses() {
    return courses;
  }

  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }
}