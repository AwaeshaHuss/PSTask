import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps_task/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ps_task/config/injection.dart' as di;
import 'package:ps_task/features/home/presentation/bloc/post_bloc.dart';


MultiBlocProvider blocProviders({Widget? child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBlocBloc>(create: (context) => di.sl<AuthBlocBloc>()..add(LoadUserDataEvent(context))),
      BlocProvider<PostsBloc>(create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent(context))),
    ],
    child: child!,
  );
}