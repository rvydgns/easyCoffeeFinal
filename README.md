# EasyCoffee ☕️

EasyCoffee, Flutter ile geliştirilmiş; Firebase Authentication, Cloud Firestore, Supabase ve SQLite altyapısıyla güçlendirilmiş bir kahve sipariş uygulamasıdır. Kullanıcıların kahve tercihlerini kaydedebileceği, sipariş verebileceği ve favori içeceklerini yönetebileceği mobil bir deneyim sunar. Modern tasarımı, tema desteği ve cihaz uyumluluğu ile fark yaratmayı amaçlamaktadır.

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

* Sipariş kartları, favori kahveler, profil ve ayarlara hızlı erişim

### 4. Siparişler Ekranı

* Sipariş listeleme, düzenleme, silme

### 5. Yeni Sipariş Ekle

* Sipariş içeriği girme ve kaydetme

### 6. Profil Sayfası

Kullanıcının ad, soyad, telefon, adres, cinsiyet, doğum tarihi ve doğum yeri bilgileri görüntülenir ve güncellenebilir.

Bu veriler Supabase’e ve Firebase'e yazılır.

SharedPreferences ile tema ve oturum bilgisi tutulur.

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

## 👥 Katkı Sağlayanlar

**Rüveyda Nur Güneş**

* Ana sayfa, sipariş listesi, yeni sipariş, favoriler, ayarlar sayfaları
* Logo ve tema yönetimi, responsive tasarım, Firebase ve Supabase yapılandırması

**Serhat Vahapoğlu**

* Giriş, kayıt, şifre yenileme sayfaları
* Authentication ve SQLite/Supabase oturum yönetimi

---

Teşekkürler!
