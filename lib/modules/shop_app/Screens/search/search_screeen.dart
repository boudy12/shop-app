import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/Screens/search/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/Screens/search/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';


class ShopAppSearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppSearchCubit(),
      child: BlocConsumer<ShopAppSearchCubit,ShopAppSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value!.isEmpty)
                          {
                            return 'Search must not be empty';
                          }
                          return null;
                        },
                        text: 'Search',
                        prefixIcon: Icons.search_outlined,
                        onChanged: (value){
                          cubit.search(text: value);
                        },
                      onSubmit: (text){
                        if(formKey.currentState!.validate())
                        {
                          cubit.search(text: text);

                        }
                      },
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if(state is ShopAppSearchLoadingStates)
                      LinearProgressIndicator(),

                    if(state is ShopAppSearchSuccessStates)
                     ConditionalBuilder(
                       condition: state is! ShopAppSearchLoadingStates,
                       builder: (context) => cubit.searchModel!.data!.data!.length == 0 ? Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 0.0),
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Image.asset(
                                   'assets/Images/search.png',
                                 ),
                                 Text('Favorites are empty!'),
                               ],
                             ),
                           ),
                         ),
                       ): Expanded(
                         child: ListView.separated(
                             physics: BouncingScrollPhysics(),
                             itemBuilder: (context, index) => buildListItem(cubit.searchModel!.data!.data![index],context,isOldPrise: false),
                             separatorBuilder: (context, index) => buildSpacerLine(),
                             itemCount: cubit.searchModel!.data!.data!.length
                         ),
                       ),
                       fallback: (context) => Center(child: CircularProgressIndicator()),
                     ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
