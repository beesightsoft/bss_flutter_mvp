import 'dart:convert';

import 'package:flutter_mvp/Base/Presenter.dart';
import 'package:flutter_mvp/Repo/Repo.Interface.dart';
import 'package:flutter_mvp/Repo/Repo.Service.dart';

class RepoPresenter extends Presenter<RepoInterface, RepoServices> {
  RepoPresenter(RepoInterface view) : super(view, new RepoServices());

  void loadData(String username) {
    model.loadData(username).then((response) {
      final List responseJson = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        view.onLoadDataFail();
      } else {
        final List result =
            responseJson.map((item) => Repository.fromJson(item)).toList();
        view.onLoadDataSuccess(result);
      }
    });
  }
}
