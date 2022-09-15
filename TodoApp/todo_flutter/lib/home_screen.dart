// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:todo_flutter/create_page.dart';
import 'package:todo_flutter/data.dart';
import 'package:todo_flutter/edit_page.dart';
import 'todo_api.dart';

const Color _errorColor = Colors.red;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Data>> _futureData;
  List<Data> _todoList = [];

  @override
  void initState() {
    super.initState();

    try {
      _futureData = Api().fetchData();
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Todo App'),
          backgroundColor: Colors.teal.shade300,
          centerTitle: true,
          actions: [
            IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
          ]),
      body: _buildFutureData(),
      backgroundColor: Colors.green.shade100,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.lime.shade700,
          child: const Text(
            "Create",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            String itemName = await showDialog(
                context: context,
                builder: (BuildContext context) => const ItemDialog());
          }),
    );
  }

  Widget _buildFutureData() {
    return FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              _todoList = snapshot.data as List<Data>;
              return _buildData(_todoList);
            } else if (snapshot.hasError) {
              _showError(snapshot.error.toString());
            }
          }
          return const CircularProgressIndicator();
        });
  }

//data.sort((a, b) => a[data.title].compareTo(b[data.priority]));
  Widget _buildData(List<Data> data) {
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        data.sort((a, b) => a.title.compareTo(b.priority));
        return _buildRow(data[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Future<void> _updateTaskSaving(Data data) async {
    Data newData = Data(
        id: data.id,
        title: data.title,
        createDate: data.createDate,
        isCompleted: !data.isCompleted,
        detail: data.detail,
        priority: data.priority);

    try {
      final updateData = await Api().updateData(newData);
      setState(() {
        data.isCompleted = updateData.isCompleted;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _deleteTask(Data deletedData) async {
    Data delete = Data(
        id: deletedData.id,
        title: deletedData.title,
        createDate: deletedData.createDate,
        isCompleted: deletedData.isCompleted,
        detail: deletedData.detail,
        priority: deletedData.priority);

    try {
      final deleteItem = await Api().deleteData(delete);
      setState(() {
        deletedData.id = deleteItem.id;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  // Future<void> _updateDataSave(Data updatedData) async {
  //   Data updateD = Data(
  //       id: updatedData.id,
  //       title: updatedData.title,
  //       createDate: updatedData.createDate,
  //       isCompleted: updatedData.isCompleted,
  //       detail: updatedData.detail,
  //       priority: updatedData.priority);

  //   try {
  //     final updateItem = await Api().updateData(updateD);
  //     setState(() {
  //       updatedData.title = updateItem.title;
  //       updatedData.isCompleted = updateItem.isCompleted;
  //       updatedData.detail = updateItem.detail;
  //       updatedData.priority = updateItem.priority;
  //     });
  //   } catch (e) {
  //     _showError(e.toString());
  //   }
  // }

  ListTile _buildRow(Data data) {
    return ListTile(
      title: Text(data.title),
      subtitle: Text(data.priority),
      trailing: SizedBox(
          width: 150,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    _updateTaskSaving(data);
                  },
                  icon: Icon(data.isCompleted
                      ? Icons.check_box
                      : Icons.check_box_outline_blank_rounded)),
              IconButton(
                  onPressed: () {
                    _deleteTask(data);
                    _deleteMessage();
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    _pushEdit(data);
                  },
                  icon: const Icon(Icons.edit)),
            ],
          )),
    );
  }

  void _pushEdit(Data data) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const EditPage()));
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final Iterable<ListTile> tiles =
            _todoList.where((title) => title.isCompleted).map(
          (data) {
            return ListTile(
              title: Text(data.title, style: const TextStyle(fontSize: 20)),
              subtitle: Text(
                data.detail,
                style: const TextStyle(fontSize: 15),
              ),
            );
          },
        );

        final List<Widget> divided = tiles.isNotEmpty
            ? ListTile.divideTiles(tiles: tiles, context: context).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Completed Tasks',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.amber.shade300,
          ),
          body: ListView(children: divided),
        );
      },
    ));
  }

  void _showError(String error) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(error),
        backgroundColor: _errorColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _deleteMessage() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Delete succesful. Please restart the page.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
