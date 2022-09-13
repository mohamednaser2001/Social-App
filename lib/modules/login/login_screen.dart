

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home_layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'login_cubit.dart';
import 'login_states.dart';

class LoginScreen extends  StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialAppLoginCubit(),
      child: BlocConsumer<SocialAppLoginCubit,SocialAppLoginStates>(
        listener: (context, state){
          if(state is SocialAppLoginSuccessState){
            CacheHelper.saveData(key: 'uId',value:  state.userId);
            navigateWithoutBack(context,HomeLayout());
          }
        },
        builder: (context, state){
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                           fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        const Text(
                          'Login now to browse our new offers',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                        ),
                        const SizedBox(height: 40.0,),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter email address';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:const Icon(
                               Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                SocialAppLoginCubit.get(context).changePassword();
                              },
                              icon: Icon(
                                SocialAppLoginCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                              ),
                            ),

                          ),
                          obscureText:SocialAppLoginCubit.get(context).isShown ? false : true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30.0,),
                        Container(
                          color: Colors.blue,
                          width: double.infinity,
                          height: 40,
                          child: ConditionalBuilder(
                            condition: state is! SocialAppLoginLoadingState,
                            builder:(context)=> MaterialButton(
                              onPressed:(){

                                if(formKey.currentState!.validate()){
                                  SocialAppLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }

                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.white,)) ,
                          ),


                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Not have an account! ',
                            ),
                            TextButton(
                              child:const Text(
                                  'Register'
                              ),
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context)=> RegisterScreen(),
                                ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
