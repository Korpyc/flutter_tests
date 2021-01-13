import 'package:http/http.dart' as http;
import 'dart:convert';

class Person {
  final int id;
  final name;
  final sex;

  Person({this.id, this.name, this.sex});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'] as int,
        name: json['name'] as String,
        sex: json['sex'] as String);
  }
}

class PersonList {
  List<Person> personList;
  PersonList({this.personList});

  factory PersonList.fromJson(Map<String, dynamic> json) {
    var personListJson = json as List;

    List<Person> personJson =
        personListJson.map((i) => Person.fromJson(i)).toList();
    return PersonList(personList: personJson);
  }
}

Future<PersonList> getPersonList() async {
  const url = 'http://testlodtask20172.azurewebsites.net/task';
  final responce = await http.get(url);

  if (responce.statusCode == 200) {
    return PersonList.fromJson(json.decode(responce.body));
  } else {
    throw Exception('Error: ${responce.reasonPhrase}');
  }
}
