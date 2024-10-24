import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore;

  ProfileBloc(this.firestore) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firestores = FirebaseFirestore.instance;
      print('user id: ${firebaseAuth.currentUser!.uid}');
      emit(ProfileLoading());
      try {
        var snapshot = await firestores
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();

        print('snapshot: ${snapshot.data()}');
        if (snapshot.exists) {
          emit(ProfileLoaded(snapshot.data() as Map<String, dynamic>));
        } else {
          print('here');
          emit(ProfileError('User not found'));
        }
      } catch (e) {
        print('there');
        emit(ProfileError(e.toString()));
      }
    });
  }
}
