import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_api/api_service.dart';
import 'package:testing_api/model/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Testing'),
      ),
      body: _listFutureTask(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = Provider.of<ApiService>(context, listen: false);
          api.getTasks().then((value) {
            value.forEach((element) {
              print(element.title);
            });
          }).catchError((onError) {
            print(onError.toString());
          });
        },
        child: Icon(Icons.traffic_sharp),
      ),
    );
  }

  FutureBuilder _listFutureTask(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
       //future: ApiService(Dio()).getTasks(),
        future: Provider.of<ApiService>(context, listen: false).getTasks(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TaskModel>> snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasError) {
              return Container(child: Center(child: Text('Something wrong')));
            }
            final tasks = snapShot.data;
            return _listTask(context: context, tasks: tasks);
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  ListView _listTask(
      {required BuildContext context, required List<TaskModel>? tasks}) {
    return ListView.builder(
        itemCount: tasks!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                leading: Image.network(tasks[index].url,
              
                ),
              
                title: Text(tasks[index].title),
                trailing: Image.network(tasks[index].thumbnailUrl),
              ),
            ),
          );
        });
  }
}
