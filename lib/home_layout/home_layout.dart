

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class HomeLayout extends  StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  cubit.titles[cubit.currentIndex]
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon:Image.asset('assets/images/notification.png',color: Colors.black,height: 22.0,width: 22.0,),
              ),
              IconButton(
                onPressed: (){},
                icon:const Icon(Icons.search,size: 28,color: Colors.black,),
              ),
            ],
          ),
          body: cubit.layoutScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index){
              cubit.changeBottomNavBarIndex(index);
            },
            currentIndex: cubit.currentIndex,
            backgroundColor: Color(0xffFAFAFA),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/home.png',
                  height: 25.0,
                  color:cubit.currentIndex==0? Colors.blueAccent : Colors.black.withOpacity(0.6),),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/chat.png',
                  height: 25.0,
                  color:cubit.currentIndex==1? Colors.blueAccent : Colors.black.withOpacity(0.6),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/search-profile.png',
                  height: 25.0,
                  color:cubit.currentIndex==2? Colors.blueAccent : Colors.black.withOpacity(0.6),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/settings.png',
                  height: 25.0,
                  color:cubit.currentIndex==3? Colors.blueAccent : Colors.black.withOpacity(0.6),
                ),
                //Icon(Icons.settings_outlined,),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
