

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit.dart';
import 'package:social_app/modules/register/register_states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../home_layout/home_layout.dart';
import '../../shared/components/components.dart';


class RegisterScreen extends  StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> SocialAppRegisterCubit(),
      child: BlocConsumer<SocialAppRegisterCubit,SocialAppRegisterStates>(
        listener: (context,state){
          if(state is SocialAppCreateUserSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.model.uId);
            navigateWithoutBack(context,HomeLayout());
          }
        },
        builder: (context,state){
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
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        const Text(
                          'Register now to browse our new offers',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                        ),
                        const SizedBox(height: 40.0,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter name';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter your phone';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:const Icon(
                              Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                SocialAppRegisterCubit.get(context).changePassword();
                              },
                              icon: Icon(
                                SocialAppRegisterCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                              ),
                            ),

                          ),
                          obscureText:SocialAppRegisterCubit.get(context).isShown ? false : true,
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
                            condition: state is! SocialAppRegisterLoadingState,
                            builder:(context)=> MaterialButton(
                              onPressed:(){

                                if(formKey.currentState!.validate()){
                                  SocialAppRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }

                              },
                              child: const Text(
                                'Register',
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
                              'Already have an account! ',
                            ),
                            TextButton(
                              child:const Text(
                                  'Login'
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0,),
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
