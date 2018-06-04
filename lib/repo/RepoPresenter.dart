import 'dart:convert';

import 'package:flutter_mvp/base/Presenter.dart';
import 'package:flutter_mvp/repo/RepoInterface.dart';
import 'package:flutter_mvp/repo/RepoServices.dart';
import 'package:http/http.dart' as http;

class RepoPresenter extends Presenter<RepoInterface, RepoServices> {
  RepoPresenter(RepoInterface view) : super(view, new RepoServices());

  void loadData(String username) {
    model.loadData(username).then((response) {
      final List responseJson = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        view.onLoadDataFail();
      } else {
        final List result = responseJson.map((item) => Repository.fromJson(item)).toList();
        view.onLoadDataSuccess(result);
      }
    });
  }
}
