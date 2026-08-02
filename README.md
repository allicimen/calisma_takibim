# calisma_takibim

# 🎯 Flutter State & Local DB Sandbox

Bu proje, Flutter ekosisteminde yerel veri yönetimi ve durum yönetiminin (state management) entegre bir şekilde nasıl çalıştığını test etmek amacıyla geliştirilmiş bir **"Proof of Concept" (Kavram Kanıtı)** uygulamasıdır.

Tema olarak temel bir **KPSS Çalışma Takip** aracı kullanılmış olup, uygulamanın asıl odak noktası karmaşık UI tasarımları değil; arka plandaki mimariyi, veri akışını ve paketlerin birbirleriyle olan iletişimini sağlam temellere oturtmaktır.

## 🛠️ Kullanılan Teknolojiler

- **Flutter:** Çapraz platform arayüz inşası (Windows Desktop ortamında derlenmiştir).
- **Isar Database:** Yüksek performanslı NoSQL yerel veritabanı (Çalışma seanslarının hafızaya yazılması ve okunması).
- **Provider:** Durum yönetimi (Veritabanı ile UI arasındaki reaktif ve anlık iletişimi sağlamak için).
- **Shared Preferences:** Anahtar-değer saklama (Kullanıcının günlük çalışma hedefini önbellekte tutmak için).

## 💡 Proje Kazanımları (Features)

- Isar model şemalarının (`.g.dart`) `build_runner` ile oluşturulması ve entegrasyonu.
- Veritabanında **CRUD** (Oluşturma, Okuma, Silme) işlemlerinin asenkron olarak yönetilmesi.
- `ChangeNotifier` ve `Consumer` widget'ları kullanılarak performanslı ve reaktif (anında güncellenen) UI inşası.
- Kullanıcı ayarlarının (Shared Preferences) ve ilişkisel verilerin (Isar) tek bir Provider katmanından yönetilmesi.

---

> **Geliştirici Notu:** Bu repo bir öğrenme ve teknoloji test (sandbox) projesi olduğu için aktif olarak geliştirilmemektedir. İlgili teknolojilerin mimari kurulumunu temiz bir iskelet halinde belgelemek ve gelecekteki projelere referans olmak amacıyla bu haliyle dondurulmuştur.
