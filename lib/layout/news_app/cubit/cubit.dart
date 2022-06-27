import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/news_app/cubit/states.dart';
import 'package:mos/modules/news_app/buisiness/business_screen.dart';
import 'package:mos/modules/news_app/science/science_screen.dart';
import 'package:mos/modules/news_app/sports/sports_screen.dart';
import 'package:mos/shared/network/local/cache_helper.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) =>BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem=
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business,),
      label: 'Buisness',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports,),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science,),
      label: 'Science',
    ),

  ];

  List<Widget> screens=
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> buisness =[];
  List<dynamic> sports =[];
  List<dynamic> science =[];
  List<dynamic> search =[];


  void ChangeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  void getBuisness ()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {'country':'eg','category':'business','apiKey':'e66c497f0e974197a563f906255b2e13',},
    ).then((value)
    {
      buisness = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError){print(onError.toString());emit(NewsGetBusinessFailedState());});
  }

  void getSports ()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {'country':'eg','category':'sports','apiKey':'e66c497f0e974197a563f906255b2e13',},
    ).then((value)
    {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((onError){print(onError.toString());emit(NewsGetSportsFailedState());});
  }

  void getScience ()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {'country':'eg','category':'science','apiKey':'e66c497f0e974197a563f906255b2e13',},
    ).then((value)
    {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((onError){print(onError.toString());emit(NewsGetScienceFailedState());});
  }

  void getSearch (String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {'q':'$value','apiKey':'e66c497f0e974197a563f906255b2e13',},
    ).then((value)
    {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError){print(onError.toString());emit(NewsGetSearchFailedState());});
  }



}

class ChangeModeTheme extends Cubit<NewsStates>
{
  ChangeModeTheme() : super(NewsInitialModeState());

  static ChangeModeTheme get(context) =>BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
      isDark=fromShared;
    else
      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value)
    {
      emit(NewsChangeModeState());
    });

  }
}