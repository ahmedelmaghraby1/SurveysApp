// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import 'package:graduation_project/data/models/Surveys.dart';

// import '../../constants/strings.dart';

// class SingleSurvey extends StatelessWidget {
//   final Surveys survey;

//   const SingleSurvey({
//     Key? key,
//     required this.survey,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
//       padding: EdgeInsets.all(4),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(8)),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(context, survey_screen, arguments: survey);
//         },
//         child: GridTile(
//           child: Hero(
//             tag: {"survey.id"},
//             child: Container(
//               color: Colors.white,
//               child: Text(""),
//               // child: survey.image!.isNotEmpty
//               //     ? FadeInImage.assetNetwork(
//               //         placeholder: "assets/images/loading.gif",
//               //         image: survey.image!,
//               //         fit: BoxFit.cover,
//               //       )
//               //     : Image.asset(
//               //         "assets/images/loading.gif",
//               //       )),
//             ),
//           ),
//           footer: Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//             color: Colors.black54,
//             alignment: Alignment.bottomCenter,
//             child: Text(
//               "${"survey.name"}",
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
