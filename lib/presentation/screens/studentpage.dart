// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/business_logic/cubit/user_cubit.dart';
// import 'package:graduation_project/data/models/User.dart';
// import 'package:graduation_project/presentation/widgets/surveywidgets.dart';

// class Student extends StatelessWidget {
//   const Student({super.key});

//   Widget character_info(String tiltle, String value) {
//     return RichText(
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         text: TextSpan(children: [
//           TextSpan(
//             text: tiltle,
//             style: TextStyle(
//                 color: Color.fromARGB(255, 6, 77, 135),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16),
//           ),
//           TextSpan(
//             text: value,
//             style:
//                 TextStyle(color: Color.fromARGB(255, 6, 77, 135), fontSize: 16),
//           ),
//         ]));
//   }

//   Widget build_divider(double value) {
//     return Divider(
//       thickness: 2,
//       height: 5,
//       endIndent: value,
//       color: Color.fromARGB(255, 6, 77, 135),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     @override
//     late User user;
//     // BlocProvider.of<SurveysCubit>(context).acountinfo();
//     return BlocBuilder<SurveysCubit, UserState>(builder: (context, state) {
//       if (state is AccountInfoLoaded) {
//         user = (state).account;
//         return Scaffold(
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           body: Container(
//             margin: EdgeInsets.only(top: 50, bottom: 20, left: 10, right: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   width: 10,
//                   color: Color.fromARGB(255, 6, 77, 135),
//                 )),
//             child: CustomScrollView(slivers: [
//               // SliverAppBar(
//               //   expandedHeight: 150,
//               //   pinned: true,
//               //   stretch: true,
//               //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
//               //   flexibleSpace: FlexibleSpaceBar(
//               //     // centerTitle: true,
//               //     title: Text(
//               //       "${user.username}",
//               //       style: TextStyle(
//               //           color: Color.fromARGB(255, 6, 77, 135), fontSize: 35),
//               //       // textAlign: TextAlign.center,
//               //     ),
//               //     background: Hero(
//               //         tag: {user.email},
//               //         child: Center(
//               //           child: UserAccountsDrawerHeader(
//               //             accountEmail: Text(""),
//               //             accountName: Text(""),
//               //             currentAccountPicture: Center(
//               //               child: CircleAvatar(
//               //                 backgroundColor: Colors.white,
//               //                 radius: 40,
//               //                 child: Text(
//               //                   "${user.username.toString().substring(0, 2).toUpperCase()}",
//               //                   style: TextStyle(
//               //                     color: Color.fromARGB(255, 6, 77, 135),
//               //                   ),
//               //                 ),
//               //               ),
//               //             ),
//               //           ),
//               //         )),
//               //   ),
//               // ),
//               SliverList(
//                   delegate: SliverChildListDelegate([
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                   margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Center(
//                         child: CircleAvatar(
//                           backgroundColor: Color.fromARGB(255, 6, 77, 135),
//                           radius: 40,
//                           child: Text(
//                             "${user.username.toString().substring(0, 2).toUpperCase()}",
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 255, 255, 255),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info("User ID:  ", "${user.id}"),
//                       build_divider(250),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info("User name:  ", "${user.username}"),
//                       build_divider(220),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info("User Email:  ", "${user.email}"),
//                       build_divider(220),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info(
//                           "User Avaliable Surveys:  ", "${user.firstName}"),
//                       build_divider(135),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info("User Gender:  ", "${user.gender}"),
//                       build_divider(220),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       character_info("User ID:  ", "${user.id}"),
//                       build_divider(250),
//                     ],
//                   ),
//                 ),
//               ])),
//             ]),
//           ),
//         );
//       } else {
//         return CircularProgressIndicator();
//       }
//     });
//   }
// }
