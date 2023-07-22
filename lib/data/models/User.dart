// class User {
//   int? id;
//   String? username;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? gender;
//   String? image;
//   String? token;

//   User(
//       {this.id,
//       this.username,
//       this.email,
//       this.firstName,
//       this.lastName,
//       this.gender,
//       this.image,
//       this.token});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     email = json['email'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     gender = json['gender'];
//     image = json['image'];
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['gender'] = this.gender;
//     data['image'] = this.image;
//     data['token'] = this.token;
//     return data;
//   }
// }
class User {
  bool? success;
  String? message;
  int? dataCount;
  Data? data;

  User({this.success, this.message, this.dataCount, this.data});

  User.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    dataCount = json['dataCount'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['dataCount'] = this.dataCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userTypeID;
  String? userTypeName;
  int? userID;
  String? userName;
  String? userEName;
  String? nationalID;
  int? gender;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isActive;
  int? depID;
  int? divID;
  int? levelID;
  int? sTypeID;
  int? collegeID;
  String? depName;
  String? divName;
  String? levelName;
  String? sTypeName;
  String? collegeName;

  Data(
      {this.userTypeID,
      this.userTypeName,
      this.userID,
      this.userName,
      this.userEName,
      this.nationalID,
      this.gender,
      this.email,
      this.password,
      this.phoneNumber,
      this.isActive,
      this.depID,
      this.divID,
      this.levelID,
      this.sTypeID,
      this.collegeID,
      this.depName,
      this.divName,
      this.levelName,
      this.sTypeName,
      this.collegeName});

  Data.fromJson(Map<String, dynamic> json) {
    userTypeID = json['UserTypeID'];
    userTypeName = json['UserTypeName'];
    userID = json['UserID'];
    userName = json['UserName'];
    userEName = json['UserEName'];
    nationalID = json['NationalID'];
    gender = json['Gender'];
    email = json['Email'];
    password = json['Password'];
    phoneNumber = json['PhoneNumber'];
    isActive = json['IsActive'];
    depID = json['DepID'];
    divID = json['DivID'];
    levelID = json['LevelID'];
    sTypeID = json['STypeID'];
    collegeID = json['CollegeID'];
    depName = json['DepName'];
    divName = json['DivName'];
    levelName = json['LevelName'];
    sTypeName = json['STypeName'];
    collegeName = json['CollegeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserTypeID'] = this.userTypeID;
    data['UserTypeName'] = this.userTypeName;
    data['UserID'] = this.userID;
    data['UserName'] = this.userName;
    data['UserEName'] = this.userEName;
    data['NationalID'] = this.nationalID;
    data['Gender'] = this.gender;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['PhoneNumber'] = this.phoneNumber;
    data['IsActive'] = this.isActive;
    data['DepID'] = this.depID;
    data['DivID'] = this.divID;
    data['LevelID'] = this.levelID;
    data['STypeID'] = this.sTypeID;
    data['CollegeID'] = this.collegeID;
    data['DepName'] = this.depName;
    data['DivName'] = this.divName;
    data['LevelName'] = this.levelName;
    data['STypeName'] = this.sTypeName;
    data['CollegeName'] = this.collegeName;
    return data;
  }
}
