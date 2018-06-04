import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/ScreenState.dart';
import 'package:flutter_mvp/list_user/ListUserServices.dart';
import 'package:flutter_mvp/repo/RepoInterface.dart';
import 'package:flutter_mvp/repo/RepoPresenter.dart';
import 'package:flutter_mvp/repo/RepoServices.dart';

class Repo extends StatelessWidget {
  final User currentUser;

  Repo({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'REPO',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new RepoScreen(
        currentUser: currentUser,
      ),
    );
  }
}

class RepoScreen extends StatefulWidget {
  final User currentUser;

  RepoScreen({this.currentUser});

  @override
  State createState() => new RepoScreenState(currentUser: currentUser);
}

class RepoScreenState extends ScreenState<RepoScreen, RepoPresenter> implements RepoInterface {
  final User currentUser;

  RepoScreenState({this.currentUser});

  List<Repository> data;
  RepoPresenter presenter;
  bool isLoading, isSuccess;

  @override
  void initState() {
    super.initState();
    presenter = new RepoPresenter(this);
    isLoading = true;
    isSuccess = true;
    data = new List();
    presenter.loadData(currentUser.login);
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
      for (int i = 0; i < items.length; i++) {
        data.add(new Repository(
            id: items[i].id,
            name: items[i].name,
            description: items[i].description,
            size: items[i].size,
            language: items[i].language));
      }
    });
  }

  Future<Null> onRefresh() {
    setState(() {
      data.clear();
      isLoading = true;
      isSuccess = true;
    });
    presenter.loadData(currentUser.login);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else if (isSuccess == true) {
      if (data.length > 0) {
        return new Column(
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: new BorderRadius.circular(20.0),
                      image: new DecorationImage(image: new NetworkImage(currentUser.avatarUrl)),
                    ),
                    width: 30.0,
                    height: 30.0,
                    margin: new EdgeInsets.all(5.0),
                  ),
                  new Text(
                    currentUser.login,
                    style: new TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              decoration: new BoxDecoration(color: Colors.grey[300], borderRadius: new BorderRadius.circular(20.0)),
              width: 150.0,
              height: 40.0,
              margin: new EdgeInsets.only(top: 20.0, bottom: 10.0),
            ),
            new Expanded(
              child: new RefreshIndicator(
                child: new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      child: new Card(
                        child: new Container(
                          child: new Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Text(
                                      'ID:',
                                      style: new TextStyle(color: Colors.amber),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child:
                                        new Text(data[index].id != null ? data[index].id.toString() : 'no information'),
                                    flex: 5,
                                  )
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Text(
                                      'Name:',
                                      style: new TextStyle(color: Colors.amber),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child: new Text(
                                        data[index].name != null ? data[index].name.toString() : 'no information'),
                                    flex: 5,
                                  )
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Text(
                                      'Description:',
                                      style: new TextStyle(color: Colors.amber),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child: new Text(
                                        data[index].description != null ? data[index].description : 'no information'),
                                    flex: 5,
                                  )
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Text(
                                      'Size:',
                                      style: new TextStyle(color: Colors.amber),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child: new Text(data[index].size != null
                                        ? '${data[index].size.toString()} KB'
                                        : 'no information'),
                                    flex: 5,
                                  )
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Text(
                                      'Language:',
                                      style: new TextStyle(color: Colors.amber),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child: new Text(
                                        data[index].language != null ? data[index].language : 'no information'),
                                    flex: 5,
                                  )
                                ],
                              ),
                            ],
                          ),
                          padding: new EdgeInsets.all(10.0),
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
            child: new Text('${currentUser.login} has no repository',
                style: new TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18.0)));
      }
    } else {
      return new Center(
          child: new Text('Error...',
              style: new TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18.0)));
    }
  }
}
