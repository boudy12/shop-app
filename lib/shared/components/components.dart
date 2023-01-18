import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/models/shop_models/home_model.dart';
import 'package:shopapp/modules/shop_app/Screens/show_product.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required String text,
  required Function function,
}) => Container(
  width: width,
  height: 40,
  child: MaterialButton(
    onPressed: () => function(),
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);



Widget defaultFormField({

  required TextEditingController controller,
  required TextInputType type,
  Function(String s)? onChanged,
  Function(String s)? onSubmit,
  bool isPasswordIcons = false,
  required String? Function(String? value) validate,
  required String text,
  Function()? onTap,
  required IconData prefixIcon,
  IconData? suffix,
  Function? prefixpress,
  bool isClickable = true,
}) => TextFormField(

  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
  obscureText: isPasswordIcons,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefixIcon,
    ),
    suffixIcon: suffix != null ?   IconButton(
      onPressed: () => prefixpress!(),
      icon: Icon(
        suffix,
      ),
    ) : null,
  ),

);

Widget defaultFormFieldWithStyle({
  required TextEditingController controller,
  required TextInputType type,
  Function(String s)? onChanged,
  Function(String s)? onSubmit,
  bool isPasswordIcons = false,
  required String? Function(String? value) validate,
  required String text,
  Function()? onTap,
  IconData? prefixIcon ,
  IconData? suffix,
  Function? prefixpress,
  bool isClickable = true,
}) => TextFormField(

  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
  obscureText: isPasswordIcons,
  cursorColor: defaultColor,

  decoration: InputDecoration(
    focusColor:  defaultColor,
    hintText: text,
    labelStyle: TextStyle(
      color: defaultColor,
    ),

    border: UnderlineInputBorder(),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: defaultColor,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.redAccent,
      ),
    ),

    prefixIcon: Icon(
      prefixIcon,
      color: defaultColor,
    ),
    suffixIcon: suffix != null ?   IconButton(
      onPressed: () => prefixpress!(),
      icon: Icon(
        suffix,
        color: defaultColor,
      ),
    ) : null,
  ),

);

Widget buildTaskItem(Map model,context) =>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child: Padding(

    padding: const EdgeInsets.all(16.0),

    child: Row(

      children: [

        CircleAvatar(
          backgroundColor:  Colors.blueGrey[900],
          radius: 40,

          child: Text(

              '${model['time']}',
            style: TextStyle(
              color: Colors.white
            ),

          ),

        ),

        SizedBox(

          width: 15,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

          '${model['title']}',

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 22,



                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                    fontSize: 16,

                    color: Colors.blueGrey

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 15,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'Done', id: model['id'],);



            },

            icon: Icon(

              Icons.check_circle_outline,

              color: Colors.green,

            )

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'archive', id: model['id'],);

            },

            icon: Icon(

              Icons.archive_outlined,

              color: Colors.grey,

            )

        ),

      ],

    ),

  ),
);



Widget buildSpacerLine()=> Padding(

  padding: EdgeInsets.symmetric(horizontal: 10),

  child: Container(

    height: 1,

    width: double.infinity,

    color: Colors.grey,



  ),

);


void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget
    )
);

void navigateAndFinishSS(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
    (route) => false,
);

void showToast({
  required String msg,
  required ToastStates state,

})=>  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: chooseToastColor(state),
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    fontSize: 16,
    gravity: ToastGravity.BOTTOM
);
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.redAccent;
      break;

    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }
  return color;
}

Widget buildListItem(model , context , {bool isOldPrise  = true,bool isCart  = false}) =>Padding(

  padding: const EdgeInsets.all(15.0),

  child: Container(
    height: 120,
    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          height: 130,

          width: 130,

          child: Stack(

            alignment: AlignmentDirectional.bottomStart,

            children: [

              Image(

                image: NetworkImage('${model.image}'),

                width: 150,

                height: 150,

              ),

              if(model.discount != 0 && isOldPrise)

                Container(

                  color: Colors.redAccent,

                  child: Text(

                    'DISCOUNT',

                    style: TextStyle(

                        color: Colors.white,

                        fontWeight: FontWeight.bold,

                        fontSize: 12

                    ),

                  ),

                )

            ],



          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(

                padding: const EdgeInsets.symmetric(vertical:20.0),

                child: Text(

                  '${model.name}',

                  overflow: TextOverflow.ellipsis,

                  maxLines: 2,

                  style: TextStyle(

                    fontSize: 16,

                    height: 1.4,

                    fontWeight: FontWeight.bold,

                  ),

                ),

              ),

              Spacer(),

              Row(

                children: [

                  Text(

                    '${model.price}',

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(

                      fontSize: 13,

                      color: defaultColor,

                    ),



                  ),

                  SizedBox(

                    width: 5,

                  ),

                  if(model.discount != 0 && isOldPrise)

                    Text(

                      '${model.oldPrice}',

                      overflow: TextOverflow.ellipsis,



                      style: TextStyle(

                        fontSize: 13,

                        decoration: TextDecoration.lineThrough,

                        color: Colors.grey,

                      ),



                    ),

                  Spacer(),

                  if(isCart)

                    CircleAvatar(

                      radius: 17,

                      backgroundColor: (ShopAppCubit.get(context).carts![model.id])! ? Colors.red : Colors.grey,

                      child: IconButton(

                          onPressed: (){

                            ShopAppCubit.get(context).changeCartsItem(model.id);

                          },

                          icon: Icon(

                            Icons.restore_from_trash_rounded,

                            size: 18,

                            color: Colors.white,

                          )

                      ),

                    ),

                  if(!isCart)

                    CircleAvatar(

                    radius: 17,

                    backgroundColor: (ShopAppCubit.get(context).favorites![model.id])! ? defaultColor : Colors.grey,

                    child: IconButton(

                        onPressed: (){

                          ShopAppCubit.get(context).changeFavItem(model.id);

                        },

                        icon: Icon(

                          Icons.favorite_outline_outlined,

                          size: 18,

                          color: Colors.white,

                        )

                    ),

                  ),

                ],

              ),
      
            ],

          ),

        ),



      ],

    ),

  ),

);
