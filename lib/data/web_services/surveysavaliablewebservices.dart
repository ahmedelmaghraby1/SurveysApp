import 'dart:convert';

import 'package:graduation_project/constants/strings.dart';
import 'package:http/http.dart';

class AvaliableSurveys {
  Future avalialesurveys(int userID, int userTypeId, int collegeId, int levelId,
      int depId, int divId, int gender, int pageNum, int pageSize) async {
    try {
      Uri avaliablesurveysurl = Uri.parse(
          "${enigma_baseurl}/${surveys_endpoint}?ServiceKey=${services_key}&UserID=${userID}&UserTypeID=${userTypeId}&CollegeID=${collegeId}&LevelID=${levelId}&DepID=${depId}&DivID=${divId}&Gender=${gender}&PageNo=${pageNum}&PageSize=${pageSize}&");
      Response response = await get(avaliablesurveysurl);
      dynamic re = jsonDecode(response.body);
      if (re['dataCount'] == 0) {
        return 0;
      } else {
        return re;
      }
    } catch (e) {
      print(e);
    }
  }

  Future surveydetails(int surveyId) async {
    try {
      Uri avaliablesurveysurl = Uri.parse(
          "${enigma_baseurl}/${survey_endpoint}?ServiceKey=${services_key}&SurveyID=${surveyId}");
      Response response = await get(avaliablesurveysurl);
      dynamic re = jsonDecode(response.body);
      print(re);
      return re;
    } catch (e) {
      print(e);
    }
  }

  Future postsurvey(String surveyanswer) async {
    String url =
        "${enigma_baseurl}${save_urvey_answer_endpoint}?ServiceKey=${services_key}&AnswerInfo=${surveyanswer}";
    Uri posturl = Uri.parse(url); // Replace with your API endpoint

    // Encode the data to JSON format
    String jsonData = jsonEncode(surveyanswer);

    try {
      print(url);
      Response response = await post(posturl);
      bool success = jsonDecode(response.body)['Success'];
      print(success);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      // Error occurred during the request
      print('Error sending post request: $e');
    }
  }
}
