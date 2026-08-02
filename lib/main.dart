import 'package:calisma_takibim/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/study_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  //flutterda main fonksiyonu async(beklemeli) olacaksa bu satır zorunludur
  //"Uygulama çizilmeden önce şu arka plan işlerini bir bekle"  demektir

  WidgetsFlutterBinding.ensureInitialized();

  //az önce  yazdığımız  beyni başka bir değişkene atayarak yeni bir nesne oluşturduk
  final studyProvider = StudyProvider();

  //İçindeki Isar ve Shared Preferences ın kurulmasını (init) bekliyoruz
  await studyProvider.init();

  runApp(
    //Uygulamanın en tepesine Provider ı yerleştiriyoruz ki,
    //içerideki  tüm ekranlar beyne ulaşabilsin.
    //ChangeNotifierProvider , studyProvider nesnesini
    //uygulamanın alt widgetlarıyla paylaşır
    ChangeNotifierProvider(
      create: (context) => studyProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KPSS çalisma takibi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
