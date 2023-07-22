part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class UserLogOut extends AppState {}

class TextApearstate extends AppState {}

class UserInfoLoaded extends AppState {
  late User user;
  UserInfoLoaded(
    this.user,
  );
}

class UserInfoloading extends AppState {}

class RefreshHomePage extends AppState {}

class UserInfoloadingFailed extends AppState {}

class DarkModestate extends AppState {} 



// class AccountInfoLoaded extends AppState {
//   late User account;
//   AccountInfoLoaded(
//       this.account,
//       );

// }