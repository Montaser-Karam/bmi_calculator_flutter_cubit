import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/bmi_cubit/bmi_cubit.dart';
import '../cubits/bmi_cubit/bmi_states.dart';
import 'bmi_result_view.dart';

class BmiInputView extends StatefulWidget {
  const BmiInputView({super.key});

  @override
  State<BmiInputView> createState() => _BmiInputViewState();
}

class _BmiInputViewState extends State<BmiInputView> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: AppBar(
        title: const Text(
          'حاسبة مؤشر كتلة الجسم',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocListener<BmiCubit, BmiState>(
          listener: (context, state) {
            if (state is BmiWarningState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.orangeAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            } else if (state is BmiSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BmiResultView(
                    bmiResult: state.bmiResult,
                    bmiStatus: state.bmiStatus,
                  ),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  const Icon(
                    Icons.analytics_outlined,
                    size: 70,
                    color: Color(0xFF4F5EBD),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161926),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF222638),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInputField(
                          controller: _weightController,
                          label: 'الوزن (كيلو جرام)',
                          icon: Icons.scale_rounded,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          controller: _heightController,
                          label: 'الطول (سنتيمتر)',
                          icon: Icons.height_rounded,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          controller: _ageController,
                          label: 'السن (بالسنوات)',
                          icon: Icons.calendar_today_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F5EBD),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final weight = double.parse(_weightController.text);
                          final height = double.parse(_heightController.text);
                          final age = int.parse(_ageController.text);

                          context.read<BmiCubit>().calculateBmi(
                            weight: weight,
                            heightInCm: height,
                            age: age,
                          );
                        }
                      },
                      child: const Text(
                        'عرض النتيجة و التحليل',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF4F5EBD)),
        filled: true,
        fillColor: const Color(0xFF0F111A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF222638)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4F5EBD), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
