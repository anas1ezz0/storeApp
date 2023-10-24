import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/appCubit/cubit.dart';
import 'package:shop_app/appCubit/status.dart';
import 'package:shop_app/compo/compo.dart';
import 'package:shop_app/screens/search_screen.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
     return   Scaffold(
          appBar: AppBar(
            title: Text('Sala'),
            actions: [
              IconButton(onPressed: (){navigateTo(context,  SearchScreen());}, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.screen[cubit.currantIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            selectedIconTheme: const IconThemeData(color: Colors.teal),
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey[700],
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(color: Colors.grey,),

            onTap: (index){
              cubit.changeNavBar(index);
            },
            currentIndex: cubit.currantIndex,
            items: const  [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home,) ,
              ),
              BottomNavigationBarItem(
                label: 'Category' ,
                icon: Icon(Icons.apps) ,
              ),
              BottomNavigationBarItem(
                label: 'Favourite' ,
                icon: Icon(Icons.favorite) ,
              ),
              BottomNavigationBarItem(
                label: 'settings' ,
                icon: Icon(Icons.settings) ,
              ),
            ],
          ),

        );
      },

    );
  }
}
