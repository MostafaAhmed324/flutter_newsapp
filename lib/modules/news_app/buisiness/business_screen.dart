import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:mos/layout/news_app/cubit/cubit.dart';
import 'package:mos/layout/news_app/cubit/states.dart';
import 'package:mos/shared/componantes/componantes.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) => Conditional.single(
        context: context,
        conditionBuilder: (context) => state is! NewsGetBusinessLoadingState,
        widgetBuilder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => builedArticleItem(NewsCubit.get(context).buisness[index],context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            itemCount: NewsCubit.get(context).buisness.length,
        ),
        fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
