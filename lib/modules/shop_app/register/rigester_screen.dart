import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/login/login_screen.dart';
import 'package:shopapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/register/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/styles/colors.dart';

class ShopAppRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppRegisterCubit(),

      child: BlocConsumer<ShopAppRegisterCubit, ShopAppRegisterStates>(
        listener: (context, state) {
          if(state is ShopAppRegisterSuccessState) {
            if (state.shopAppUseRegisterModel.status) {
              print(state.shopAppUseRegisterModel.data!.token);
              showToast(
                  msg:  state.shopAppUseRegisterModel.message,
                  state: ToastStates.SUCCESS
              );
              CacheHelper.saveData(
                key: 'token',
                value: state.shopAppUseRegisterModel.data!.token,
              ).then((value) {
                token = CacheHelper.getData(key: 'token');
                navigateAndFinishSS(context, ShopAppLoginScreen());
              });
            }
            else {
              showToast(
                  msg:  state.shopAppUseRegisterModel.message,
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopAppRegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to browse out hot offers',
                          style: Theme.of(context).textTheme.bodyText2,

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Name Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text:  'Name',
                            prefixIcon: Icons.person_outline
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Email Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text: 'Email',
                            prefixIcon:  Icons.email_outlined
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Phone Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text:  'Phone',
                            prefixIcon:  Icons.phone
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPasswordIcons: cubit.isPassword,
                            suffix: cubit.suffix,
                            prefixpress: (){
                              cubit.changIconRegisterPasswordState();
                            },
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Password Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text: 'Password',
                            prefixIcon: Icons.lock_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopAppRegisterLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                                function:(){
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                    );
                                  }

                                },
                                text: 'Register',
                                radius: 10,
                                background: defaultColor,
                                isUpperCase: true,
                                width: 200
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
