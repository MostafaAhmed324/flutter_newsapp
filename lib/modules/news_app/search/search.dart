import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/news_app/cubit/cubit.dart';
import 'package:mos/layout/news_app/cubit/states.dart';
import 'package:mos/shared/componantes/componantes.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  textType: TextInputType.text,
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must\'t not be empty';
                    }
                    return null;
                  },
                  label: 'Serch',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: builedArticleItem(NewsCubit.get(context).search, context)),
            ],
          ),
        );
      },
    );
  }
}
