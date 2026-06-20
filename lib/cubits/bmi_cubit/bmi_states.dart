abstract class BmiState {}

class BmiInitialState extends BmiState {}

class BmiLoadingState extends BmiState {}

class BmiSuccessState extends BmiState {
  final double bmiResult;
  final String bmiStatus;

  BmiSuccessState({required this.bmiResult, required this.bmiStatus});
}

class BmiWarningState extends BmiState {
  final String message;

  BmiWarningState({required this.message});
}

class BmiErrorState extends BmiState {
  final String errorMessage;

  BmiErrorState({required this.errorMessage});
}
