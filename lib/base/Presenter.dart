abstract class Presenter<V, M> {
  V view;
  M model;

  Presenter(this.view, [this.model]);
}
