import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/news_app/cubit/cubit.dart';
import 'package:mos/layout/news_app/cubit/states.dart';
import 'package:mos/modules/news_app/search/search.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: ()
                {
                  ChangeModeTheme.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_high_outlined,),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.ChangeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
