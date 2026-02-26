import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ওরিয়েন্টেশন কন্ট্রোল করার জন্য প্রয়োজন 📱
import 'screens/home_screen.dart'; // তোমার হোম স্ক্রিন ইমপোর্ট করো

void main() async {
  // ১. ফ্লাটার ইঞ্জিন এবং প্ল্যাটফর্ম চ্যানেলের সাথে যোগাযোগ নিশ্চিত করা ⚙️
  WidgetsFlutterBinding.ensureInitialized();

  // ২. অ্যাপটিকে শুধুমাত্র ল্যান্ডস্কেপ মোডে চলার জন্য সীমাবদ্ধ করা 🔄
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // ৩. অ্যাপটি রান করা 🚀
  runApp(const JungleSurvivalApp());
}

class JungleSurvivalApp extends StatelessWidget {
  const JungleSurvivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jungle Survival',
      theme: ThemeData.dark(), // গেমের জন্য ডার্ক থিম ভালো দেখায়
      home: const HomeScreen(), // শুরুতেই হোম স্ক্রিন দেখাবে
    );
  }
}
