import 'package:isar/isar.dart';

//part adında  yeni bir  satır  ekliyoruz
//bu satır Isar ın üreteceği kodların bu dosyayla bağlantılı olduğunu söylüyoruz

part 'study_session.g.dart'; // terminalde build_runner komutu çalışmadığı sürece altı kırmızıdır

@collection
class StudySession {
  // her veri bloğunun bir ID si olmalı  autoIncrement bu ID atama işini bizim yerimize yapacak
  Id id = Isar.autoIncrement;

  // ders  değişkeni
  late String lessonName;
  //zaman değişkeni ama derse çalışma süresi bakımından
  late int durationInMinutes;
  //zaman değişkeni ama ne zaman çalışıldığının tarihi
  late DateTime date;
}
