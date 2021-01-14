import 'package:flutter/material.dart';
import 'package:flutter_json_test/json_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<PersonList> personList;
  @override
  void initState() {
    personList = getPersonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<PersonList>(
          future: personList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.personList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('${snapshot.data.personList[index].name}'),
                        subtitle: Column(
                          children: [
                            Text('Sex: ${snapshot.data.personList[index].sex}'),
                            Text('id: ${snapshot.data.personList[index].id}'),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Error!');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
