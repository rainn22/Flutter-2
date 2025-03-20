import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  1 - Get the post provider
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            // 2- Fetch the post
            onPressed: () => {postProvider.fetchPost()},
            icon: const Icon(Icons.update),
          ),
        ],
      ),

      // 3 -  Display the post
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider postProvider) {
    final postValue = postProvider.postValue;

    if (postValue == null) {
      return Text('Tap refresh to display post'); // display an empty state
    }

    switch (postValue.state) {
      case AsyncValueState.loading:
        return CircularProgressIndicator(); // display a progress

      case AsyncValueState.error:
        return Text('Error: ${postValue.error}'); // display a error

      case AsyncValueState.success:
        return ListView.builder(
          
          itemCount: postValue.data!.length,
          itemBuilder: (context,index){

        }); // display the post
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(post.title), subtitle: Text(post.description));
  }
}
