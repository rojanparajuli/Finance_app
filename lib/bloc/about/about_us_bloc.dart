import 'package:finance/bloc/about/about_us_event.dart';
import 'package:finance/bloc/about/about_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsBloc() : super(AboutUsInitialState()) {
    on<LoadAboutUsEvent>((event, emit) {
      const aboutUsContent = """
      Welcome to FinManager, where we help you take control of your finances. 
      
      Our platform allows you to easily track your lending, debts, and credits, 
      ensuring that you always stay on top of your financial commitments. 
      
      With secure data storage and user authentication, your financial records 
      are kept safe and accessible whenever you need them. 

      Let us help you achieve peace of mind in managing your finances.
      """;
      emit(AboutUsLoadedState(aboutUsContent));
    });
  }
}