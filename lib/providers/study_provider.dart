import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/study_session.dart'; //  kendi oluşturduğumuz model

//ChangeNotifier: değişiklik olduğunda ekrana "kendini yenile" dememizi sağlar
class StudyProvider extends ChangeNotifier {
  late Isar isar; // bunu bakalım nerede kullanacağız
  late SharedPreferences prefs;

  //Ekranlarda göstereceğimiz verileri burada tutuyoruz
  List<StudySession> sessions = [];
  int dailyGoal = 120; // günlük hedef  120  dak olsun

  // Uygulama açıldığında çalışacak motor
  Future<void> init() async {
    //önce Shared prefernces i  (ayarları) oku
    prefs = await SharedPreferences.getInstance();
    dailyGoal = prefs.getInt('dailyGoal') ?? 120; //hafızda yoksa 120  dak yap

    //Sonra  Isar veritabanını  cihazda bir klasör bularak başlat
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [StudySessionSchema], //build_runner ın ürettiği  dosyadaki şema
      directory: dir.path,
    );
    //Her şey hazır  olunca  eski  kayıtları  veritabanından çek
    await fetchSessions();
  }

  //  Isar verileri okuma  ve  ekranı güncelleme
  Future<void> fetchSessions() async {
    sessions = await isar.studySessions
        .where()
        .findAll(); //klasik veri okuma kodu
    notifyListeners(); //ekaran bağırıyoruz  veriler değişti kendini yenile
  }

  // ISAR : yeni oturum kaydetme
  Future<void> addSession(String lesson, int minutes) async {
    final newSession = StudySession()
      ..lessonName = lesson
      ..durationInMinutes = minutes
      ..date = DateTime.now();

    //YENİ VERİYİ EKLME
    await isar.writeTxn(() async {
      await isar.studySessions.put(newSession);
    });
    await fetchSessions(); //kayıt bitince verileri güncelle
  }

  //veri silme
  Future<void> deleteSesions(int id) async {
    await isar.writeTxn(() async {
      await isar.studySessions.delete(id);
    });

    await fetchSessions();
  }

  // SHARED PREFS : HEDEFİ  GÜNCELLEME
  Future<void> setDailyGoal(int minutes) async {
    dailyGoal = minutes;
    await prefs.setInt('dailyGoal', minutes); //hafızaya  kalıcı olarak yaz
    notifyListeners(); //ekranı yenile
  }
} //tüm kodları ve değişkenleri oku bakalım ne nerede kulanılmış
