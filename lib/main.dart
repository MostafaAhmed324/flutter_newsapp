import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/news_app/cubit/cubit.dart';
import 'package:mos/layout/news_app/cubit/states.dart';
import 'package:mos/layout/news_app/news_layout.dart';
import 'package:mos/shared/bloc_observer.dart';
import 'package:mos/shared/network/local/cache_helper.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';
import 'package:mos/shared/styles/themes.dart';


void main() async {
  BlocOverrides.runZoned(
        () async{

          bool isDark = false;
          WidgetsFlutterBinding.ensureInitialized();
          DioHelper.init();
          await CacheHelper.init();
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeModeTheme()..changeAppMode(),),
        BlocProvider(create: (context) => NewsCubit()..getBuisness()..getScience()..getSports(),),
      ],
      child: BlocConsumer<ChangeModeTheme,NewsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode: ChangeModeTheme.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }

}

