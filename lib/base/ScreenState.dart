import 'package:flutter/widgets.dart';
import 'package:flutter_mvp/base/Presenter.dart';

abstract class ScreenState<T extends StatefulWidget, P extends Presenter> extends State<T> {
  P presenter;
}
