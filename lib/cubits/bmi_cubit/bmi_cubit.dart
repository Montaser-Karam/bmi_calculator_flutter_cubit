import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_states.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiInitialState());

  void calculateBmi({
    required double weight,
    required double heightInCm,
    required int age,
  }) {
    emit(BmiLoadingState());

    if (weight < 10 || age < 5) {
      emit(BmiWarningState(message: 'الرجاء إدخال قيم صحيحة  !'));
      return;
    }

    try {
      double heightInMeters = heightInCm / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      String status;
      if (bmi < 18.5) {
        status = 'وزن تحت الطبيعي';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        status = 'وزن مثالي طبيعي';
      } else if (bmi >= 25 && bmi < 29.9) {
        status = 'وزن زائد';
      } else {
        status = 'سمنة مفرطة';
      }

      emit(BmiSuccessState(bmiResult: bmi, bmiStatus: status));
    } catch (e) {
      emit(BmiErrorState(errorMessage: 'حدث خطأ أثناء الحساب'));
    }
  }
}
