// import 'package:finance/model/lending/lending_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LendingFormCubit extends Cubit<LendingEntry> {
//   LendingFormCubit(LendingEntry? entry)
//       : super(
//           LendingEntry(
//             id: entry?.id ?? '',
//             name: entry?.name ?? '',
//             lendDate: entry?.lendDate ?? DateTime.now(),
//             returnDate: entry?.returnDate ?? DateTime.now(),
//             amount: entry?.amount ?? 0.0,
//             statementImageUrl: entry?.statementImageUrl,
//           ),
//         );

//   void updateName(String name) {
//     emit(state.copyWith(name: name));
//   }

//   void updateAmount(double amount) {
//     emit(state.copyWith(amount: amount));
//   }

//   void updateLendDate(DateTime date) {
//     emit(state.copyWith(lendDate: date));
//   }

//   void updateReturnDate(DateTime date) {
//     emit(state.copyWith(returnDate: date));
//   }

//   void updateStatementImage(String? imagePath) {
//     emit(state.copyWith(statementImageUrl: imagePath));
//   }
// }
