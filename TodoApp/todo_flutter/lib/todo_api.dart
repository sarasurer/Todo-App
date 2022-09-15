import 'package:todo_flutter/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const int _okResponseCode = 200;
const int _postResponseCode = 201;

class Api {
  final String _url = 'localhost:44336';

  Future<List<Data>> fetchData() async {
    final uri = Uri.https(_url, 'api/ToDo');
    final response = await http.get(uri);

    if (response.statusCode == _okResponseCode) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse.map<Data>((title) => Data.fromJson(title)).toList();
    } else {
      throw Exception('Failed to load Todo App.');
    }
  }

  Future<Data> updateData(Data data) async {
    final uri = Uri.https(_url, 'api/ToDo/${data.id}');
    String bodyJson = json.encode(data.toUpdateJson());

    final response = await http.put(
      uri,
      body: bodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      // body: jsonEncode(<String, Object>{
      //   'id': data.id,
      //   'title': data.title,
      //   'createDate': data.createDate,
      //   'isCompleted': data.isCompleted,
      //   'detail': data.detail,
      //   'priority': data.priority,
      // }),
    );

    if (response.statusCode == _okResponseCode) {
      return Data.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Data.');
    }
  }

  //post metodu uygula

  Future<Data> createData(Data data) async {
    final uri = Uri.https(_url, 'api/ToDo');
    String bodyJson = json.encode(data.toCreateJson());
    final response = await http.post(
      uri,
      body: bodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(<String, Object>{
      //   'title': data.title,
      //   'createDate': data.createDate,
      //   'isCompleted': data.isCompleted,
      //   'detail': data.detail,
      //   'priority': data.priority,
      // })
    );

    if (response.statusCode == _postResponseCode) {
      // String responseString = response.body;
      // Data.fromJson(jsonDecode(responseString));
      var jsonResponse = json.decode(response.body);
      return Data.fromJson(jsonResponse);
      //return jsonResponse.map<Data>((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Todo App.');
    }
  }

  Future<Data> deleteData(Data data) async {
    final uri = Uri.https(_url, 'api/ToDo/${data.id}');
    final deleteResponse = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        // 'id': data.id,
      }),
    );

    if (deleteResponse.statusCode == _okResponseCode) {
      return Data.fromJson(jsonDecode(deleteResponse.body));
    } //else {
    //throw Exception('Failed to delete Data.');
    //},
    return deleteData(data);
  }

  Future<List<Data>> readDataById([id]) async {
    final uri = Uri.https(_url, 'api/ToDo');
    final response = await http.get(uri);

    if (response.statusCode == _okResponseCode) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse.map<Data>((id) => Data.fromJson(id)).toList();
    } else {
      throw Exception('Failed to load Todo App.');
    }
  }
}
