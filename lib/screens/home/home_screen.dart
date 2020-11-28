import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/screens/auth/login/login_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = LoginController(context: context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          height: size.height,
          width: size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(state.currentUser.avatar),
                radius: 50,
              ),
              Text(
                state.currentUser.firstName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
