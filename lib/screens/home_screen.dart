import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/study_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KPSS Çalisma Takibi'),
        actions: [
          // Sağ üstteki ayar butonu (Shared Preferences testi)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Butona basıldığında hedefi 150 dakika yap
              context.read<StudyProvider>().setDailyGoal(150);
            },
          ),
        ],
      ),
      // EKRANI DİNLEYEN KISIM: Consumer
      body: Consumer<StudyProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // 1. KISIM: Shared Preferences'tan gelen ayar
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.deepPurple.shade50,
                width: double.infinity,
                child: Text(
                  'Günlük Hedef: ${provider.dailyGoal} Dakika',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                'Çalışma Geçmişi',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

              // 2. KISIM: Isar Veritabanından Gelen Liste
              Expanded(
                child: ListView.builder(
                  itemCount: provider.sessions.length,
                  itemBuilder: (context, index) {
                    final session = provider.sessions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.book,
                          color: Colors.deepPurple,
                        ),
                        title: Text(
                          session.lessonName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${session.date.day}/${session.date.month}/${session.date.year}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize
                              .min, //Row'un ekrandan taşıp hata vermesini engeller
                          children: [
                            //1. elemanımız  text
                            Text(
                              '${session.durationInMinutes} Dk',
                              style: const TextStyle(fontSize: 16),
                            ),
                            //2. elamınımız: çöp  teknesi ikonu
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                //butona tıkladığında silderecek olan fonksiyon
                                context.read<StudyProvider>().deleteSesions(
                                  session.id,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      // SAĞ ALTTAKİ EKLEME BUTONU (Isar veritabanı testi)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Butona basıldığında Isar'a yeni bir "Tarih" dersi seansı ekle
          context.read<StudyProvider>().addSession('Tarih', 87);
        },
        icon: const Icon(Icons.add),
        label: const Text('Seans Ekle'),
      ),
    );
  }
}
