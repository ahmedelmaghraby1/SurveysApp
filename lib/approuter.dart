// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/business_logic/cubit/user_cubit.dart';
// import 'package:graduation_project/constants/strings.dart';
// import 'package:graduation_project/data/models/User.dart';
// import 'package:graduation_project/data/repository/userinforepository.dart';
// import 'package:graduation_project/data/web_services/userinfowebservices.dart';
// import 'package:graduation_project/presentation/screens/homepage.dart';
// import 'package:graduation_project/presentation/screens/login.dart';
// import 'package:graduation_project/presentation/screens/profile.dart';
// import 'package:graduation_project/presentation/screens/studentpage.dart';
// import 'package:graduation_project/presentation/screens/surveysscreen.dart';

// class Approuter {
//   late AuthRepository userInformationRepository;
//   late SurveysCubit surveysCubit;
//   Approuter() {
//     userInformationRepository = AuthRepository(AuthWebServices());
//     surveysCubit = SurveysCubit(userInformationRepository);
//   }

//   Route? generateroute(RouteSettings settings) {
//     switch (settings.name) {
//       case login_screen:
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider(
//                   create: (context) => surveysCubit,
//                   child: Login(),
//                 ));
//       // case home_screen:
//       //   // final user = settings.arguments as User;
//       //   return MaterialPageRoute(
//       //       builder: (_) => BlocProvider(
//       //           create: (context) => surveysCubit, child: HomePage()));
//       // case student_screen:
//       //   return MaterialPageRoute(
//       //       builder: (_) => BlocProvider(
//       //             create: (context) => surveysCubit,
//       //             child: Student(),
//       //           ));
//       case profile_screen:
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider(
//                   create: (context) => surveysCubit,
//                   child: ProfilePage(),
//                 ));

//       case survey_screen:
//         // final character = settings.arguments as char.Characters;
//         // final qoutes = settings.arguments as Quotes;
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider(
//                   create: (context) => surveysCubit,
//                   child: SurveyScreen(),
//                 ));
//     }
//   }
// }
