import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvp/base/ScreenState.dart';
import 'package:flutter_mvp/list_user/ListUserInterface.dart';
import 'package:flutter_mvp/list_user/ListUserPresenter.dart';
import 'package:flutter_mvp/list_user/ListUserServices.dart';
import 'package:flutter_mvp/repo/RepoView.dart';

class ListUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'LIST USER',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new ListUserScreen(),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class ListUserScreen extends StatefulWidget {
  @override
  State createState() => new ListUserScreenState();
}

class ListUserScreenState extends ScreenState<ListUserScreen, ListUserPresenter> implements ListUserInterface {
  List<User> data;
  bool isLoading, isSuccess;
  TextEditingController editingController = new TextEditingController(text: 'duytq');

  @override
  void initState() {
    super.initState();
    presenter = new ListUserPresenter(this);
    isLoading = true;
    isSuccess = true;
    presenter.loadData(editingController.text != '' ? editingController.text : 'duytq');
  }

  @override
  void onLoadDataFail() {
    isLoading = false;
    isSuccess = false;
  }

  @override
  void onLoadDataSuccess(List items) {
    isLoading = false;
    isSuccess = true;
    setState(() {
      data = items;
    });
  }

  Future<Null> onRefresh() {
    setState(() {
      data.clear();
      isLoading = true;
      isSuccess = true;
    });
    presenter.loadData(editingController.text != '' ? editingController.text : 'duytq');
    return null;
  }

  onItemPress(int index) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Repo(currentUser: data[index])));
  }

  onSearchPress() {
    setState(() {
      data.clear();
      isLoading = true;
      isSuccess = true;
    });
    presenter.loadData(editingController.text != '' ? editingController.text : 'duytq');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else if (isSuccess == true) {
      return new Column(
        children: <Widget>[
          new Container(
            child: new TextFormField(
              decoration: new InputDecoration(
                  hintText: 'Username',
                  border: new UnderlineInputBorder(),
                  contentPadding: new EdgeInsets.all(5.0),
                  hintStyle: new TextStyle(color: Colors.grey),
                  suffixIcon: new IconButton(icon: new Icon(Icons.search), onPressed: onSearchPress)),
              controller: editingController,
            ),
            margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
          ),
          new Expanded(
            child: new RefreshIndicator(
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    child: new Card(
                      child: new FlatButton(
                        onPressed: () {
                          onItemPress(index);
                        },
                        padding: new EdgeInsets.all(0.0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              width: 40.0,
                              height: 40.0,
                              margin: new EdgeInsets.only(left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      image: new NetworkImage(data[index].avatarUrl), fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                            new Flexible(
                                child: new Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      child: new Text(
                                        'Name:',
                                        style: new TextStyle(color: Colors.amber),
                                      ),
                                      flex: 1,
                                    ),
                                    new Expanded(
                                      child: new Text(
                                        data[index].login,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      flex: 3,
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      child: new Text(
                                        'ID:',
                                        style: new TextStyle(color: Colors.amber),
                                      ),
                                      flex: 1,
                                    ),
                                    new Expanded(
                                      child: new Text(
                                        data[index].id.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      flex: 3,
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      child: new Text(
                                        'Score:',
                                        style: new TextStyle(color: Colors.amber),
                                      ),
                                      flex: 1,
                                    ),
                                    new Expanded(
                                      child: new Text(
                                        data[index].score.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      flex: 3,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                    margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  );
                },
                padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                itemCount: data.length,
              ),
              onRefresh: onRefresh,
            ),
          ),
        ],
      );
    } else {
      return new Center(
          child: new Text('Error...',
              style: new TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18.0)));
    }
  }
}
