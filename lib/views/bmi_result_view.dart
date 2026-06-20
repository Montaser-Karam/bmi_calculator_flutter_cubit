import 'package:flutter/material.dart';

class BmiResultView extends StatelessWidget {
  final double bmiResult;
  final String bmiStatus;

  const BmiResultView({
    super.key,
    required this.bmiResult,
    required this.bmiStatus,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUnderWeight = bmiResult < 18.5;
    final bool isNormal = bmiResult >= 18.5 && bmiResult < 25.0;
    final bool isOverWeight = bmiResult >= 25.0 && bmiResult < 30.0;
    final bool isObese = bmiResult >= 30.0;

    double underWeightProgress = (bmiResult / 18.5).clamp(0.0, 1.0);
    double normalProgress = isNormal
        ? ((bmiResult - 18.5) / (25.0 - 18.5)).clamp(0.0, 1.0)
        : (bmiResult >= 25.0 ? 1.0 : 0.0);
    double overWeightProgress = isOverWeight
        ? ((bmiResult - 25.0) / (30.0 - 25.0)).clamp(0.0, 1.0)
        : (bmiResult >= 30.0 ? 1.0 : 0.0);
    double obeseProgress = isObese
        ? ((bmiResult - 30.0) / 10.0).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: AppBar(
        title: const Text(
          'تحليل كتلة الجسم',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF161926),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF222638), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'المؤشر الكلي',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          bmiStatus,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isNormal
                                ? Colors.greenAccent
                                : (isUnderWeight
                                      ? Colors.blueAccent
                                      : Colors.amberAccent),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      bmiResult.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              const Text(
                'توزيع النطاقات والمؤشرات :',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildGaugeCard(
                      title: 'نقص في الوزن',
                      range: 'أقل من 18.5',
                      isActive: isUnderWeight,
                      activeColor: const Color(0xFF29B6F6),
                      progressValue: underWeightProgress,
                    ),
                    const SizedBox(height: 14),
                    _buildGaugeCard(
                      title: 'الوزن الطبيعي',
                      range: '18.5 - 24.9',
                      isActive: isNormal,
                      activeColor: const Color(0xFF66BB6A),
                      progressValue: normalProgress,
                    ),
                    const SizedBox(height: 14),
                    _buildGaugeCard(
                      title: 'ذيادة في الوزن',
                      range: '25.0 - 29.9',
                      isActive: isOverWeight,
                      activeColor: const Color(0xFFFFA726),
                      progressValue: overWeightProgress,
                    ),
                    const SizedBox(height: 14),
                    _buildGaugeCard(
                      title: 'سمنة مفرطة',
                      range: '30.0 أو أكثر',
                      isActive: isObese,
                      activeColor: const Color(0xFFEF5350),
                      progressValue: obeseProgress,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'إعادة الفحص والتحليل',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGaugeCard({
    required String title,
    required String range,
    required bool isActive,
    required Color activeColor,
    required double progressValue,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1E2235) : const Color(0xFF131520),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? activeColor.withValues(alpha: 0.5)
              : const Color(0xFF1C1E2A),
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      range,
                      style: TextStyle(
                        color: isActive ? Colors.white38 : Colors.white12,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : Colors.white30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isActive
                            ? activeColor
                            : activeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: activeColor.withValues(alpha: 0.5),
                                  blurRadius: 4,
                                ),
                              ]
                            : [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isActive) ...[
            const SizedBox(width: 15),
            Icon(Icons.check_circle, color: activeColor, size: 24),
          ],
        ],
      ),
    );
  }
}
