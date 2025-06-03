# EasyCoffee ☕️

EasyCoffee, Flutter ile geliştirilmiş; Firebase Authentication, Cloud Firestore, Supabase ve SQLite altyapısıyla güçlendirilmiş bir kahve sipariş uygulamasıdır. Kullanıcıların kahve tercihlerini kaydedebileceği, sipariş verebileceği ve favori içeceklerini yönetebileceği mobil bir deneyim sunar. Modern tasarımı ve cihaz uyumluluğu ile kullanıcı tarafındaki kullanım kolaylığı ön planda tutularak geliştirildi.

---

## 🌍 Projenin Amacı

EasyCoffee uygulaması, kahve tutkunlarının mobil ortamda hızlı ve pratik bir şekilde sipariş oluşturmasını, favori içeceklerini listelemesini ve profil yönetimini sağlamasını hedefler. Firebase Authentication ile güvenli giriş, Firestore ile gerçek zamanlı veri saklama, Supabase ile kullanıcı profillerini yönetme ve SQLite ile cihaz içi oturum yönetimi sağlanmıştır.

---

## 🔧 Teknik Mimari ve Kullanılan Teknolojiler

* **Flutter** – Uygulama geliştirme platformu
* **Firebase Authentication** – Kimlik doğrulama
* **Cloud Firestore** – Veri saklama (Doğum Tarihi, Doğum Yeri, Yaşanan İl)
* **Supabase** – Kullanıcı profili ve detaylarının saklanması, sipariş özetinin saklanması
* **SQLite** – Cihaz içi lokal veri saklama (oturum bilgileri)
* **Provider** – Durum yönetimi

---

## 🌟 Öne Çıkan Özellikler

* Firebase Authentication ile giriş ve kayıt
* Supabase ile kullanıcı adı, soyadı, telefon, adres, doğum tarihi gibi bilgilerin yönetimi
* Sipariş ekleme, düzenleme, silme
* Responsive tasarım ve mobil uyumlu arayüz
* Firebase ve Supabase veritabanı yapılandırmaları (Android, iOS, Web, macOS, Windows desteği)
* SQLite ile giriş yapan kullanıcı bilgilerinin cihazda tutulması

---

## 🔧 Teknik Mimari

| Katman | Teknoloji | Açıklama |
|-------|-----------|----------|
| UI    | Flutter   | Modern ve responsive mobil arayüz |
| Auth  | Firebase Authentication | Giriş ve kayıt işlemleri |
| Veri Saklama | Cloud Firestore | Doğum bilgileri, il |
| Veri Yönetimi | Supabase | Kullanıcı profili, adres, telefon vb. |
| Lokal Depolama | SQLite | UID ve e-posta gibi oturum bilgileri |
| Durum Yönetimi | Provider | UI ve veri akışı kontrolü |
| Ekstra | SharedPreferences | Oturum saklama |

---

## 📄 SQLite Kullanıcı Saklama Kanıtı

Kullanıcı girişi yapıldıktan sonra SQLite veritabanına UID ve e-posta bilgisi yazılmakta, terminal üzerinden aşağıdaki çıktı alınmaktadır:

```bash
I/flutter ( 8762): ✅ SQLite: Kullanıcı eklendi -> UID: EAbwPeqlaHeVbQRfAhcb1cLWG6r1, Email: ruveyda@gmail.com
```

Bu özellik sayesinde kullanıcı bilgileri uygulama kapatılsa dahi cihazda tutulur ve oturum yönetimi sağlanabilir hale gelir.

Test için kullanılabilecek Firebase hesabı:

* **E-posta**: `ruveyda@gmail.com`
* **Şifre**: `123456`

---

## 📅 Sayfa İçerikleri

### 1. Giriş Sayfası

* E-posta/şifre girişi
* "Kayıt Ol" ve "Şifremi Unuttum" yönlendirmeleri

### 2. Kayıt Sayfası

* Firebase Authentication ile yeni kullanıcı kaydı

### 3. Ana Sayfa

* Sipariş kartları, profil ve ayarlara hızlı erişim

### 4. Siparişler Ekranı

* Sipariş listeleme, düzenleme, silme

### 5. Yeni Sipariş Ekle

* Sipariş içeriği girme ve kaydetme

### 6. Profil Sayfası

Kullanıcının ad, soyad, telefon, adres, cinsiyet, doğum tarihi ve doğum yeri bilgileri görüntülenir ve güncellenebilir.
Bu veriler Supabase’e ve Firebase'e yazılır.
SharedPreferences ile tema ve oturum bilgisi tutulur.

### 7. Navigasyon Sistemi

**Drawer tabanlı merkezi bir navigasyon yapısı** kullanılmaktadır. Bu yapı `AppDrawer` adlı özel bir widget ile sağlanır ve `BasePage` tabanlı tüm sayfalarda kullanılır.

### 📌 AppDrawer içerikleri

- Menü sayfası
- Sepet sayfası
- Profil Sayfası
- Çıkış butonu

---

## 🕹️ Modüler ve Kod Organizasyonu

* `controllers/` klasörü: Firebase, Supabase ve SQLite işlemleri
* `components/`: Drawer ve AppBar gibi bileşenler
* `pages/`: Tüm sayfalar ayrı ayrı yapılandırıldı

---

## 🏠 Geliştirme Ortamı

* Flutter SDK
* Firebase CLI
* Supabase CLI
* Android Studio

---

## 📬 İletişim / Katkı

Bu projeye katkı sağlamak isterseniz, aşağıdaki yöntemlerle iletişime geçebilir veya katkıda bulunabilirsiniz:

### 🔧 Katkı Sağlamak İçin:
- 🐛 Hata mı buldunuz? → Yeni bir [issue](https://github.com/rvydgns/easyCoffeeFinal/issues) açın.
- 💡 Yeni bir özellik mi eklemek istiyorsunuz? → Forklayıp pull request gönderin.
- 📦 Projeye destek olmak istiyorsanız → README, dökümantasyon veya UI iyileştirmeleri konusunda katkıda bulunabilirsiniz.

### 👥 Geliştiriciler
| İsim | Rol | GitHub |
|------|-----|--------|
| **Serhat Vahapoğlu** | Firebase Authentication, SQLite, Supabase profilleri | [@SerhatVahappogglu](https://github.com/SerhatVahappogglu) |
| **Rüveyda Nur Güneş** | UI tasarımı, ana sayfa, sipariş sistemi, tema | [@rvydgns](https://github.com/rvydgns) |

> ✉️ Geliştiricilere özel olarak ulaşmak isterseniz GitHub profilleri üzerinden iletişime geçebilirsiniz.

---

Teşekkürler!
