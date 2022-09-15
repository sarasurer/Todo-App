import 'package:todo_flutter/home_screen.dart';
import 'data.dart';
import 'todo_api.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

Data data = Data(
    title: '',
    createDate: '',
    isCompleted: false || true,
    detail: '',
    priority: '');

TextEditingController titleController = TextEditingController(text: data.title);
TextEditingController isCompletedController =
    TextEditingController(text: data.isCompleted.toString());
TextEditingController detailController =
    TextEditingController(text: data.detail);
TextEditingController priorityController =
    TextEditingController(text: data.priority);

class _EditPageState extends State<EditPage> {
  late Future<Data> _updateData;

  Future _updateDataSave() async {
    Data updateD = Data(
        id: data.id,
        title: data.title,
        createDate: data.createDate,
        isCompleted: data.isCompleted,
        detail: data.detail,
        priority: data.priority);

    try {
      Data updateItem = await Api().updateData(updateD);
      setState(() {
        data.title = updateD.title;
        data.isCompleted = updateD.isCompleted;
        data.detail = updateD.detail;
        data.priority = updateD.priority;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text(
          'Task Update Page',
          style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 20),
                  const Offset(150, 20),
                  <Color>[
                    Colors.yellow,
                    Colors.black,
                  ],
                )),
        ),
      ),
      body: Column(children: <Widget>[
        const SizedBox(height: 16),
        ElevatedButton(
          child: const Text(
            'Update',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: _updateDataSave,
          style: TextButton.styleFrom(backgroundColor: Colors.pink.shade200),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: titleController,
            onChanged: (val) {
              data.title = val;
            },
            style: const TextStyle(
                fontFamily: 'Lucida Console', fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              prefixIcon: Icon(Icons.title),
              hintText: ('Title'),
              hintStyle: TextStyle(
                fontFamily: 'Lucida Console',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
            ),
            maxLength: 40,
            onSubmitted: (val) => _updateData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              controller: detailController,
              onChanged: ((val) {
                data.detail = val;
              }),
              style: const TextStyle(
                  fontFamily: 'Lucida Console', fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                prefixIcon: Icon(Icons.details),
                hintText: 'Detail',
                hintStyle: TextStyle(
                  fontFamily: 'Lucida Console',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              maxLength: 40,
              onSubmitted: (val) => _updateData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              controller: priorityController,
              onChanged: ((val) {
                data.priority = val;
              }),
              style: const TextStyle(
                  fontFamily: 'Lucida Console', fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                prefixIcon: Icon(Icons.priority_high),
                hintText: 'Priortiy: High, Medium or Low',
                hintStyle: TextStyle(
                  fontFamily: 'Lucida Console',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              maxLength: 40,
              onSubmitted: (val) => _updateData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: isCompletedController,
            onChanged: (val) {
              data.isCompleted = val as bool;
            },
            style: const TextStyle(
                fontFamily: 'Lucida Console', fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              prefixIcon: Icon(Icons.title),
              hintText: 'Is Completed',
              hintStyle: TextStyle(
                fontFamily: 'Lucida Console',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
            ),
            maxLength: 40,
            onSubmitted: (val) => _updateData,
          ),
        ),
      ]),
    );
  }

  void _showError(String error) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(error),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _updateMessage() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Update is succesfully done. Please restart the page.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
