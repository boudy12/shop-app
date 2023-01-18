import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';


class ShopAppProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context).userData;
        nameController.text = cubit!.data!.name;
        emailController.text = cubit.data!.email;
        phoneController.text = cubit.data!.phone;
        return Scaffold(
              appBar: AppBar(),
              body:  ConditionalBuilder(
                condition: ShopAppCubit.get(context).userData != null,
                fallback: (context) => Center(child: CircularProgressIndicator()),
                builder:(context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            if(state is ShopAppLoadingUpdateUserDataState)
                              LinearProgressIndicator(),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(40)
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(cubit.data!.image),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                text: 'Name',
                                validate: (value){
                                  if(value!.isEmpty)
                                  {
                                    return 'Name Must Not Be Empty ';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.person_outline),

                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField
                              (
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value!.isEmpty )
                                {
                                  return 'Email Must Not Be Empty ';
                                }
                                return null;
                              },
                              text: 'Email',
                              prefixIcon: Icons.email_outlined,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Phone Must Not Be Empty ';
                                }
                                return null;
                              },
                              text: 'Phone',
                              prefixIcon:  Icons.phone,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultButton(
                              text: 'UPDATE',
                              function: (){
                                if(formKey.currentState!.validate()) {
                                  ShopAppCubit.get(context).getUpdateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              radius: 10
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
          );
      },
    );
  }
}
