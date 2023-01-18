import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_layout/shop_home_screen.dart';
import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/modules/shop_app/register/rigester_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/styles/colors.dart';

class ShopAppLoginScreen extends StatelessWidget  {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppLoginCubit(),
      
      child: BlocConsumer<ShopAppLoginCubit, ShopAppLoginStates>(
        listener: (context, state) {
          if(state is ShopAppLoginSuccessState) {
            if (state.shopAppUseLoginModel.status) {
              print(state.shopAppUseLoginModel.data!.token);
              showToast(
                  msg:  state.shopAppUseLoginModel.message,
                  state: ToastStates.SUCCESS
              );
              CacheHelper.saveData(
                  key: 'token',
                  value: state.shopAppUseLoginModel.data!.token,

              ).then((value) {
                token=CacheHelper.getData(key: 'token');
              navigateAndFinishSS(context, ShopLayoutScreen());
              });
            }
            else {
              showToast(
                msg:  state.shopAppUseLoginModel.message,
                state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopAppLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to browse out hot offers',
                          style: Theme.of(context).textTheme.bodyText2,

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onTap: () {},
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'email must not be empty';
                              }
                              return null;
                            },

                            text: 'Email',
                            prefixIcon: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: cubit.isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                            isPasswordIcons: cubit.isPassword,
                            prefixpress: (){
                              cubit.changIconPasswordState();
                            },
                            onTap: () {},
                            onSubmit: (value){
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'password must not be empty';
                              }
                              return null;
                            },

                            text: 'Password',
                            prefixIcon: Icons.lock_outline
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopAppLoginLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                                function:(){
                                  if(formKey.currentState!.validate())
                                    {
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                      );
                                    }

                                },
                                text: 'Login',
                                radius: 10,
                                background: defaultColor,
                                isUpperCase: true,
                                width: 200
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t hane an account ?',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, ShopAppRegisterScreen());
                              },
                              child: Text(
                                'Register now',
                              ),
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
