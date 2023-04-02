import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Question {
  static String baseUrl = "http://localhost:8000";

  static Future<List> getAllQuestion() async {
    try {
      var res = await http.get(Uri.parse("$baseUrl/question"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<List> getQuestion(int id) async {
    try {
      var res = await http.get(Uri.parse("$baseUrl/question/$id"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Login(BuildContext context, login, password) async {
    try {
      var connection = {"email": login, "password": password};
      var res =
          await http.post(Uri.parse("$baseUrl/connexion"), body: connection);
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static ajout(BuildContext context, String theme, String question,
      String reponse) async {
    try {
      var res = await http.post(
        Uri.parse("$baseUrl/question"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'theme': theme,
          'question': question,
          'reponse': reponse
        }),
      );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Update(BuildContext context, int id, String theme, String question,
      String reponse) async {
    try {
      var res = await http.put(
        Uri.parse("$baseUrl/question/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'theme': theme,
          'question': question,
          'reponse': reponse,
          'id': id.toString()
        }),
      );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Delete(BuildContext context, int id) async {
    var res = await http.delete(Uri.parse('$baseUrl/question/$id'),
        body: id.toString());
    if (res.statusCode == 200) {
      Navigator.pushNamed(context, '/liste');
    } else {
      Navigator.pushNamed(context, '/');
    }
  }
}
