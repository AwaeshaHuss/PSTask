import 'dart:convert';

import 'package:ps_task/core/errors/exceptions.dart';
import 'package:ps_task/core/network/http_service.dart';
import 'package:ps_task/features/home/data/models/post_model.dart';

abstract class PostsRemoteDataSource{
  Future<List<PostModel>> getPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource{

  String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  @override
  Future<List<PostModel>> getPosts() async{
    final response = await HttpService(baseUrl).request(
      '/posts/',
      method: HttpMethod.GET,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }
}