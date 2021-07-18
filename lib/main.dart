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
import 'package:shaboo/data/repositories/implement/user/user_repo_impl.dart';
import 'package:shaboo/modules/auth/login/views/login_screen.dart';
import 'package:shaboo/modules/loading/views/loading_screen.dart';
import 'package:shaboo/modules/on_boarding/views/on_boarding_screen.dart';
import 'package:shaboo/modules/updateInfo/update_profile.dart';

import 'package:shaboo/routes.dart';
import 'package:shaboo/utils/store.dart';

getInitRoute() async {
  bool isFirstTime = await Store.getIsFirstTime() == 'true' ? true : false ?? true;
  String token = await Store.getToken();
  if (isFirstTime)
    return OnBoardingScreen();
  else if (token != null) {
    return LoadingScreen();
  } else
    return LoginScreen();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome = await getInitRoute();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kPrimaryColor, // navigation bar color
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp(
    initScreen: _defaultHome,
  ));
}

class MyApp extends StatelessWidget {
  final Widget initScreen;

  const MyApp({Key key, this.initScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepoImpl(),
        ),
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
            create: (context) => UserBloc(userRepo: RepositoryProvider.of<UserRepoImpl>(context)),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<LocationBloc>(
            create: (context) => LocationBloc(),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(postRepo: RepositoryProvider.of<PostRepoImpl>(context)),
          ),
          BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(reviewRepo: RepositoryProvider.of<ReviewRepoImpl>(context)),
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
          home: this.initScreen,
          routes: routes,
        ),
      ),
    );
  }
}
