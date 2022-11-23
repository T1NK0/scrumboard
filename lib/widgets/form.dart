// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class TaskFormWidget extends StatefulWidget {
//   const TaskFormWidget({super.key});

//   @override
//   State<TaskFormWidget> createState() => _TaskFormWidgetState();
// }

// class _TaskFormWidgetState extends State<TaskFormWidget> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) => FormBuilder(
//         key: _formKey,
//         child: Center(
//           child: ListView(
//             padding: ,
//             children: <Widget>[
//               FormBuilderTextField(
//                 name: 'Title',
//                 controller: titleController,
//                 decoration: InputDecoration(
//                   hintText: 'Title Of task',
//                   labelText: 'Title',
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () => titleController.clear(),
//                   ),
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.done,
//               ),
//               FormBuilderTextField(
//                 name: 'Description',
//                 controller: descriptionController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'description Of task',
//                   labelText: 'Description',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => descriptionController.clear(),
//                   ),
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.done,
//               )
//             ],
//           ),
//         ),
//       );
// }
