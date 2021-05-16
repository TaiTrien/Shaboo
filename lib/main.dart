import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/blocs/connection/connection_cubit.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/blocs/review/review_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/repositories/implement/book/book_repo_impl.dart';
import 'package:shaboo/data/repositories/implement/post/post_repo_impl.dart';
import 'package:shaboo/data/repositories/implement/review/review_repo_impl.dart';

import 'package:shaboo/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kPrimaryColor, // navigation bar color
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ReviewRepoImpl(),
        ),
        RepositoryProvider(
          create: (context) => BookRepoImpl(),
        ),
        RepositoryProvider(create: (context) => PostRepoImpl())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<LocationBloc>(
            create: (context) => LocationBloc(),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(
                postRepo: RepositoryProvider.of<PostRepoImpl>(context)),
          ),
          BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(
                reviewRepo: RepositoryProvider.of<ReviewRepoImpl>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
            ),
          ),
          initialRoute: '/loginScreen',
          routes: routes,
        ),
      ),
    );
  }
}
