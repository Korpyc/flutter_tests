import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_model.g.dart';

@JsonSerializable()
class Person {
  final id;
  final name;
  final sex;

  Person({this.id, this.name, this.sex});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class PersonList {
  List<Person> personList;
  PersonList({this.personList});

  factory PersonList.fromJson(json) => _$PersonListFromJson(json);

  Map<String, dynamic> toJson() => _$PersonListToJson(this);
}

Future<PersonList> getPersonList() async {
  const String url = 'http://testlodtask20172.azurewebsites.net/task';
  final responce = await http.get(url);

  if (responce.statusCode == 200) {
    return PersonList.fromJson(json.decode(responce.body));
  } else {
    throw Exception('Error: ${responce.reasonPhrase}');
  }
}
