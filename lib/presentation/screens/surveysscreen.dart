import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/cubit/surveys_cubit.dart';
import 'package:graduation_project/presentation/widgets/surveyquestion.dart';

class SurveyScreen extends StatelessWidget {
  GlobalKey formkey = new GlobalKey();
  late int q_count;
  late List<Map<String, dynamic>> survey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurveysCubit, SurveysState>(
      listener: (context, state) {
        if (state is SurveyLoading) Image.asset("assets/images/loading.gif");
      },
      builder: (context, state) {
        q_count = SurveysCubit.get(context).q_count;
        survey = SurveysCubit.get(context).survey;
        return Scaffold(
          body: Form(
            key: formkey,
            child: SurveyQuestion(
              survey: survey,
            ),
          ),
        );
      },
    );
  }
}
