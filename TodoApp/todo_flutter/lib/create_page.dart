import 'package:flutter/material.dart';
import 'data.dart';
import 'todo_api.dart';

class ItemDialog extends StatefulWidget {
  const ItemDialog({Key? key}) : super(key: key);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

Data users = Data(
    title: '', createDate: '', isCompleted: false, detail: '', priority: '');

TextEditingController titleController =
    TextEditingController(text: users.title);
TextEditingController createDateController =
    TextEditingController(text: users.createDate);
TextEditingController isCompletedController =
    TextEditingController(text: users.isCompleted.toString());
TextEditingController detailController =
    TextEditingController(text: users.detail);
TextEditingController priorityController =
    TextEditingController(text: users.priority);

class _ItemDialogState extends State<ItemDialog> {
  late Future<Data> _createData;
  //List<Data> _savedItem = [];

  Future _createDataSave() async {
    Data crData = Data(
        id: users.id, //autoincrement
        title: users.title,
        createDate: users.createDate,
        isCompleted: users.isCompleted,
        detail: users.detail,
        priority: users.priority);

    try {
      Data data = await Api().createData(crData);
      setState(() {
        users.title = crData.title;
        users.createDate = crData.createDate;
        users.isCompleted = crData.isCompleted;
        users.detail = crData.detail;
        users.priority = crData.priority;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('ADD NEW TASK'),
      children: <Widget>[
        const SizedBox(height: 16),
        ElevatedButton(
          child: const Text('Create'),
          onPressed: _createDataSave,
          style: TextButton.styleFrom(backgroundColor: Colors.amber),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context, 'created');
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: titleController,
            onChanged: (value) {
              users.title = value;
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
              hintText: 'Title of Task',
              hintStyle: TextStyle(
                fontFamily: 'Lucida Console',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
            ),
            maxLength: 40,
            onSubmitted: (value) => _createData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              controller: createDateController,
              onChanged: ((value) {
                users.createDate = value;
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
                prefixIcon: Icon(Icons.date_range),
                hintText: 'Create Date: YYYY/MM/DD',
                hintStyle: TextStyle(
                  fontFamily: 'Lucida Console',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              maxLength: 40,
              onSubmitted: (value) => _createData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              controller: detailController,
              onChanged: ((value) {
                users.detail = value;
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
              onSubmitted: (value) => _createData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              controller: priorityController,
              onChanged: ((value) {
                users.priority = value;
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
                hintText: 'Priority: High, Medium or Low',
                hintStyle: TextStyle(
                  fontFamily: 'Lucida Console',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              maxLength: 40,
              onSubmitted: (value) => _createData),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: isCompletedController,
            onChanged: (value) {
              users.isCompleted = value as bool;
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
            onSubmitted: (value) => _createData,
          ),
        ),
      ],
    );
  }

  void _showError(String error) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(error),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _createMessage() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
          'Create is succesfully done. Please click the cross and restart the page.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
