import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';
import 'package:meta/meta.dart';

import '../../data/models/User.dart';
import '../../data/repository/userinforepository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  SharedPreferances sharedPreferances = SharedPreferances();
  AppCubit(this.authRepository) : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool textappear = true;
  bool dark_mode = false;
  String username = "";
  String password = "";
  TextEditingController un = TextEditingController();
  TextEditingController pw = TextEditingController();

  void darkmode() {
    dark_mode = !dark_mode;
    sharedPreferances.setbool("dark_mode", dark_mode);
    un.text = username;
    pw.text = password;
    emit(DarkModestate());
  }

  void changemode(bool? saved_mode) {
    if (saved_mode != null) {
      dark_mode = saved_mode;
    } else {
      dark_mode = dark_mode;
    }
    emit(DarkModestate());
  }

  void textAppear() {
    textappear = !textappear;
    un.text = username;
    pw.text = password;
    emit(TextApearstate());
  }

  late User user;

  final AuthRepository authRepository;
  logout() {
    emit(UserLogOut());
  }

  Future<User> getuserinfo(
      String username, String password, BuildContext context) async {
    emit(UserInfoloading());
    await authRepository.getuserinfo(username, password, context).then((value) {
      if (value == false) {
        emit(UserInfoloadingFailed());
        user = User();
      } else {
        emit(UserInfoLoaded(value));
        user = value;
      }
    });
    print(user.toJson());
    return user;
  }

  refresh() {
    emit(RefreshHomePage());
  }
}
