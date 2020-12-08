import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:primeiro_projeto/API.dart';

//https://servicodados.ibge.gov.br/api/v1/localidades/estados/35//distritos

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Api> _api;

  Future<List<Api>> _getUser() async {
    try {
      List<Api> listUser = List();
      final response = await http.get(
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/35//distritos?orderBy=nome');
      if (response.statusCode == 200) {
        var descodeJson = jsonDecode(response.body);
        descodeJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print("Erro ao conectar na API");
        return null;
      }
    } catch (e) {
      print("Erro ao conectar na API");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((map) {
      _api = map;
      print(_api.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _api.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 20,
                  color: Colors.grey[300],
                  child: Text(_api[index].nome)),
            );
          },
        ),
      ),
    );
  }
}
