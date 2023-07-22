// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'surveys_cubit.dart';

@immutable
abstract class SurveysState {}

class SurveysInitial extends SurveysState {}

class SurveysLoaded extends SurveysState {
  int s_count;
  List<Map<String, dynamic>> surveys;
  SurveysLoaded(
    this.s_count,
    this.surveys,
  );
}

class SurveysLoading extends SurveysState {}

class SurveyLoaded extends SurveysState {
  int d_count;
  List<Map<String, dynamic>> survey;
  SurveyLoaded(
    this.d_count,
    this.survey,
  );
}

class SurveyLoading extends SurveysState {}

class StartingFromHome extends SurveysState {}

class ViewProfile extends SurveysState {}

class SubmitStudentSurveyAnswer extends SurveysState {
  // final SaveSurvey student_survey_answer;

  SubmitStudentSurveyAnswer();
}

class SurveysFailed extends SurveysState {}

class SurveyQuestionResponse extends SurveysState {
  final List<Map<String, dynamic>> survey_answers;

  SurveyQuestionResponse(this.survey_answers);
}

class SurveySingleQuestionResponse extends SurveysState {
  final String answer;

  SurveySingleQuestionResponse(this.answer);
}
