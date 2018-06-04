import 'dart:convert';

import 'package:flutter_mvp/base/Presenter.dart';
import 'package:flutter_mvp/list_user/ListUserInterface.dart';
import 'package:flutter_mvp/list_user/ListUserServices.dart';

class ListUserPresenter extends Presenter<ListUserInterface, ListUserServices> {
  ListUserPresenter(ListUserInterface view) : super(view, new ListUserServices());

  void loadData(String username) {
    model.loadData(username).then((response) {
      final List responseJson = json.decode(response.body)['items'];
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        view.onLoadDataFail();
      } else {
        final List result = responseJson.map((item) => User.fromJson(item)).toList();
        view.onLoadDataSuccess(result);
      }
    });
  }
}
