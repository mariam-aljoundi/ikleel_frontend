import 'package:eklil/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على ارتفاع الشاشة لضبط المسافات ديناميكياً
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // مسافة علوية ديناميكية
                    SizedBox(height: constraints.maxHeight * 0.02),

                    // 1. الصورة
                    FadeIn(
                      duration: const Duration(seconds: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'images/welcom1.png',
                          fit: BoxFit.contain,
                          height: constraints.maxHeight * 0.40, // 40% من الشاشة
                        ),
                      ),
                    ),

                    // مسافة ديناميكية بين الصورة والكارد
                    SizedBox(height: constraints.maxHeight * 0.03),

                    // 2. الكارد
                    FadeInUp(
                      duration: const Duration(seconds: 5),
                      child: Card(
                        elevation: 20,
                        shadowColor: AppColors.primaryPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: constraints.maxHeight * 0.15, // الشعار ديناميكي
                                child: Image.asset('images/slogan.png',
                                    fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "لأن ليلتك تستحق أن تكون ذكرى لا تُنسى",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryPurple,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "ننسج لكِ من الأحلام ذكرى لا تغيب",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryPurple,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // مسافة ديناميكية أكبر قبل الزر لإنزاله قليلاً
                    SizedBox(height: constraints.maxHeight * 0.08),

                    // 3. زر السهم
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.primaryPurple.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5))
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward,
                                color: Colors.white, size: 30),
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );




                            },
                          ),
                        ),
                      ),
                    ),

                    // مسافة سفلية للأمان
                    SizedBox(height: constraints.maxHeight * 0.1),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}