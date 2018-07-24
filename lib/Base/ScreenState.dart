import 'package:flutter/widgets.dart';
import 'package:flutter_mvp/Base/Presenter.dart';

abstract class ScreenState<T extends StatefulWidget, P extends Presenter>
    extends State<T> {
  P presenter;
}
