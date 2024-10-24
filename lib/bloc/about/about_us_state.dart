abstract class AboutUsState {}

class AboutUsInitialState extends AboutUsState {}

class AboutUsLoadedState extends AboutUsState {
  final String content;
  AboutUsLoadedState(this.content);
}