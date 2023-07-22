class Surveys {
  bool? success;
  String? message;
  int? dataCount;
  String? data;
  List<dynamic>? ListofSurveys;

  Surveys({this.success, this.message, this.dataCount, this.data});

  Surveys.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    dataCount = json['dataCount'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['dataCount'] = this.dataCount;
    data['data'] = this.data;
    return data;
  }
}

class Survey {
  bool? success;
  String? message;
  int? dataCount;
  String? data;

  Survey({this.success, this.message, this.dataCount, this.data});

  Survey.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    dataCount = json['dataCount'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['dataCount'] = this.dataCount;
    data['data'] = this.data;
    return data;
  }
}

class SaveSurvey {
  bool? success;
  String? message;
  int? dataCount;
  Null? data;

  SaveSurvey({this.success, this.message, this.dataCount, this.data});

  SaveSurvey.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    dataCount = json['dataCount'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['dataCount'] = this.dataCount;
    data['data'] = this.data;
    return data;
  }
}
