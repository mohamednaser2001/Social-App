import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'bloc_observer.dart';
import 'home_layout/home_layout.dart';
import 'modules/create_post_screen/post_screen.dart';
import 'dart:io';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId =CacheHelper.getData(key: 'uId');
  Widget widget;
  if(uId!=null) widget= HomeLayout();
  else widget=LoginScreen();
  

   runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..getUserDate()..getPosts()..getAllUsers(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:const AppBarTheme(
            elevation: 0.0,
            color: Colors.white,
            titleSpacing: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22.0,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 20.0,
            ),
          ),
          bottomNavigationBarTheme:const BottomNavigationBarThemeData(
            elevation: 20.0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}



