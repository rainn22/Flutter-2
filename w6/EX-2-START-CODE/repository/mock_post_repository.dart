import '../model/post.dart';

import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  List<Post> listPosts = [
  Post(id: 1, title: "Exploring the Future of AI", description: "A deep dive into artificial intelligence and its impact on our daily lives."),
  Post(id: 2, title: "Understanding Flutter: A Beginner's Guide", description: "Learn how to get started with Flutter and build cross-platform mobile apps."),
  Post(id: 3, title: "Mastering React Native for Mobile Development", description: "Step-by-step tutorial on building mobile apps with React Native."),
  Post(id: 4, title: "The Rise of Remote Work", description: "How remote work is changing the global workforce and what it means for the future."),
  Post(id: 5, title: "Breaking Down the Internet of Things (IoT)", description: "A comprehensive guide to understanding IoT and its applications in everyday life.")
];

  @override
  Future<List<Post>> getPost() {
    return Future.delayed(Duration(seconds: 5), () {
      return listPosts;
    });
  }
}
