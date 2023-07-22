import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/cubit/app_cubit.dart';

import '../../data/models/User.dart';
import '../widgets/user_profile_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileWidgites profileWidgites = new ProfileWidgites();
    @override
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        late User user = AppCubit.get(context).user;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded)),
            ),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 6, 77, 135),
                                radius: 40,
                                child: Text(
                                  "${user.data!.email.toString().substring(0, 2).toUpperCase()}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 6),
                                profileWidgites.text(user.data!.userTypeName!,
                                    30, FontWeight.bold)
                              ]),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text(
                                  user.data!.userName.toString(),
                                  18,
                                  FontWeight.w400),
                              profileWidgites.text(
                                  ' اسم الطالب : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text(
                                  '${user.data!.gender == 2 ? "أنثي" : "ذكر "}',
                                  18,
                                  FontWeight.w400),
                              profileWidgites.text(
                                  'النوع : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text('${user.data!.phoneNumber}',
                                  18, FontWeight.w400),
                              profileWidgites.text(
                                  'رقم الهاتف : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text('${user.data!.collegeName}',
                                  18, FontWeight.w400),
                              profileWidgites.text(
                                  'الكلية : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text('${user.data!.levelName}',
                                  18, FontWeight.w400),
                              profileWidgites.text(
                                  'الفرقة : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row(
                            [
                              profileWidgites.text(
                                  '${user.data!.depName}', 18, FontWeight.w400),
                              profileWidgites.text(
                                  'القسم : ', 18, FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 15),
                          profileWidgites.row([
                            profileWidgites.text(
                                '${user.data!.divName}', 18, FontWeight.w400),
                            profileWidgites.text(
                                'الشعبة : ', 18, FontWeight.bold),
                          ]),
                          const SizedBox(height: 15),
                          profileWidgites.row([
                            profileWidgites.text(
                                '${user.data!.sTypeName}', 18, FontWeight.w400),
                            profileWidgites.text(
                                'حالة الطالب : ', 18, FontWeight.bold),
                          ]),
                        ]))));
      },
    );
  }
}
