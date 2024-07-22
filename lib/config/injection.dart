import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ps_task/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ps_task/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';
import 'package:ps_task/features/auth/domain/usecases/load_userdata_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/register_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/sendotp_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/verifyotp_usecase.dart';
import 'package:ps_task/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ps_task/features/home/data/datasources/post_data_sources.dart';
import 'package:ps_task/features/home/data/repositories/post_repositories_impl.dart';
import 'package:ps_task/features/home/domain/repositories/post_repositories.dart';
import 'package:ps_task/features/home/domain/usecases/get_posts_usecase.dart';
import 'package:ps_task/features/home/presentation/bloc/post_bloc.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();

  static Future<void> init() async {
    // bloc
    sl.registerFactory(() => AuthBlocBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logOutUseCase: sl(),
        sendOTPUseCase: sl(),
        verifyOTPUseCase: sl(),
        loadUserDataUseCase: sl()));

    sl.registerFactory(() => PostsBloc(sl()));

    // use case
    sl.registerLazySingleton(() => LoadUserDataUseCase(sl()));
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => LogOutUseCase(sl()));
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => SendOTPUseCase(sl()));
    sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
    sl.registerLazySingleton(() => GetPostsUseCase(sl()));

    // repo
    sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImpl(sl()));
    sl.registerLazySingleton<PostRepositories>(() => PostRepositoriesImpl(sl()));

    // data source
    sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(FirebaseAuth.instance, FirebaseFirestore.instance));
    sl.registerLazySingleton<PostsRemoteDataSource>(() => PostsRemoteDataSourceImpl());
  }
}
