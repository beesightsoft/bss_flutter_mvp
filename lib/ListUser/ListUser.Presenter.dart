import 'dart:convert';

import 'package:flutter_mvp/Base/Presenter.dart';
import 'package:flutter_mvp/ListUser/ListUser.Interface.dart';
import 'package:flutter_mvp/ListUser/ListUser.Service.dart';

class ListUserPresenter extends Presenter<ListUserInterface, ListUserServices> {
  ListUserPresenter(ListUserInterface view)
      : super(view, new ListUserServices());
  String defaultText = 'beesightsoft';

  void loadData(String username) {
    model.loadData(username.isEmpty ? defaultText : username).then((response) {
      final List responseJson = json.decode(response.body)['items'];
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        view.onLoadDataFail();
      } else {
        final List result =
            responseJson.map((item) => User.fromJson(item)).toList();
        view.onLoadDataSuccess(result);
      }
    });
  }
}
