import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' show Response;
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/features/home/data/models/post_model.dart';
import 'package:ps_task/features/home/domain/entities/post_entity.dart';
import 'package:ps_task/features/home/domain/usecases/get_posts_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;

  PostsBloc(this.getPostsUseCase): super(const PostState()){
    on<GetAllPostsEvent>(_getAllPosts);
  }



  static PostsBloc get(context) => BlocProvider.of(context);


  FutureOr<void> _getAllPosts(GetAllPostsEvent event, Emitter<PostState> emit) async{
    emit(state.copyWith(status: PostsStateStatus.loading));
     Either<Failure, List<PostEntity>> result;
     result = await getPostsUseCase.call();
     result.fold((l) {
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error fetching posts'),)));
      emit(state.copyWith(status: PostsStateStatus.error));
     }, (r) {
        List<PostModel> posts = [];
        posts = r.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
        emit(state.copyWith(
            status: PostsStateStatus.success, postsList: posts));
     });
  }
}
