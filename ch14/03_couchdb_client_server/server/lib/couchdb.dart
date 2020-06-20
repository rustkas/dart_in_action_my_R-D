import 'dart:async';
import 'dart:convert' show base64, jsonDecode, jsonEncode, utf8;
import 'dart:io';

import 'package:model/model.dart';

/// Preliminary preparation:
/// * Setup CouchDB on your local machine (version 3.1).
/// * Add server admin: login: admin, password: 1
class CouchDbHandler {
  final String host;
  final int port;
  final String dbName;

  /// waiting flag of CouchDB responce
  Future<bool> isInit;
  final HttpClient client;

  CouchDbHandler({this.host, this.port, this.dbName}) : client = HttpClient() {
    isInit = _tryCreateDb();
  }

  Future<bool> _tryCreateDb() {
    print('creatingDb');

    var completer = Completer<bool>();
    final conn = client.open('PUT', host, port, '/$dbName');
    conn.then((HttpClientRequest clientRequest) {
      _addHederInfo(clientRequest);
      clientRequest.close().then((response) {
        response.transform(utf8.decoder).listen((contents) {
          // analysing CouchDB response
          Map<String, dynamic> results = jsonDecode(contents);
          if (results.containsKey('ok') && results['ok'] ||
              results.containsKey('error') &&
                  results['error'] == 'file_exists') {
            completer.complete(true);
          } else {
            throw Exception('Results: $results');
          }
        });
      });
    }, onError: (e) {
      print('Try to create new db is failed. More info: $e');
      completer.complete(false);
    });

    return completer.future;
  }

  /// add info about your credentials to the header
  void _addHederInfo(HttpClientRequest clientRequest) {
    clientRequest.headers
        .add('Authorization', 'Basic ${base64.encode(utf8.encode('admin:1'))}');
  }

  Future<List<Map>> loadData() async {
    var completer = Completer<List<Map>>();
    var result = <Map>[];
    print('loading data');

    final clientRequest = await client.open(
        'GET', host, port, '/$dbName/_all_docs?include_docs=true');

    _addHederInfo(clientRequest);
    final response = await clientRequest.close();

    print('loadedData');

    final sb = StringBuffer();
    response.transform(utf8.decoder).listen((contents) {
      print('loading-onData');
      sb.write(contents);
    }, onDone: () {
      print('loading-closed');
      var string = sb.toString();
      if (string.isEmpty) {
        completer.complete(result);
        return completer.future;
      }

      Map data = jsonDecode(sb.toString());
      if (data.isEmpty) {
        completer.complete(result);
        return completer.future;
      }

      if (data['total_rows'] > 0) {
        for (Map rowData in data['rows']) {
          if (rowData['id'] == 'nextId') {
            continue;
          }

          Map expenseInfo = rowData['doc'];

          //get data from CouchDb '_id' field, copy it and
          // add field 'id' to the map
          final id = int.parse(expenseInfo['_${ExpenceNames.id_name}']);
          expenseInfo.remove('_${ExpenceNames.id_name}');
          expenseInfo[ExpenceNames.id_name] = id;
          result.add(expenseInfo);
        }
      }

      completer.complete(result);
    });

    return completer.future;
  }

  Future<Map> addOrUpdate(Map expense) async {
    print('saving data');
    var completer = Completer<Map>();

    var clientRequest =
        await client.open('PUT', host, port, '/$dbName/${expense["id"]}');

    _addHederInfo(clientRequest);

    //set up id field for CouchDB
    // transform "id" field to "_id"
    final id = expense[ExpenceNames.id_name];
    expense.remove(ExpenceNames.id_name);
    expense['_${ExpenceNames.id_name}'] = '$id';

    clientRequest.add(utf8.encode(jsonEncode(expense)));
    var response = await clientRequest.close();
    // return id field to the map again
    expense.remove('_${ExpenceNames.id_name}');
    expense[ExpenceNames.id_name] = id;
    print('saved data');
    final sb = StringBuffer();
    response.transform(utf8.decoder).listen((contents) {
      print('saving-ondata');
      sb.write(contents);
    }, onDone: () {
      print('saving-onclosed');
      final Map data = jsonDecode(sb.toString());
      // print('DATA: $data');
      //set last rev field value to the data item
      expense[ExpenceNames.rev_name] = data['rev'];
      completer.complete(expense);
      // print('New Expense: $expense');
    });

    return completer.future;
  }
}
