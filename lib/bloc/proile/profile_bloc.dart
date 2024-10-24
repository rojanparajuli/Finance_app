import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_event.dart';  
import 'profile_state.dart'; 

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore;

  ProfileBloc(this.firestore) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        DocumentSnapshot snapshot = await firestore.collection('users').doc(event.userId).get();
        if (snapshot.exists) {
          emit(ProfileLoaded(snapshot.data() as Map<String, dynamic>));
        } else {
          emit(ProfileError('User not found'));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
