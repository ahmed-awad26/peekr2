# Peekr 📱
### تطبيق أندرويد لمتابعة كل المحتوى في مكان واحد

[![Build APK](https://github.com/YOUR_USERNAME/peekr/actions/workflows/build.yml/badge.svg)](https://github.com/YOUR_USERNAME/peekr/actions/workflows/build.yml)

---

## المنصات المدعومة
- 📺 **YouTube** - متابعة القنوات
- 💬 **Telegram** - قنوات وجروبات
- 💚 **WhatsApp** - جروبات وقنوات
- 📘 **Facebook** - صفحات وجروبات
- 📰 **RSS** - أي موقع أخبار

## المميزات
- ✅ فيد موحد من كل المنصات
- ✅ أرشيف مع تصنيفات وملاحظات
- ✅ أدوات HTML قابلة للإضافة
- ✅ 7 ويدجيز للشاشة الرئيسية
- ✅ نسخ احتياطي + Google Drive
- ✅ قفل بـ PIN + بصمة
- ✅ Dark Mode

---

## إعداد المشروع

### 1. استنساخ المشروع
```bash
git clone https://github.com/YOUR_USERNAME/peekr.git
cd peekr
```

### 2. إنشاء secrets.properties
```bash
cp secrets.properties.example secrets.properties
```
افتح الملف وأضف مفاتيح API:
```properties
YOUTUBE_API_KEY=your_key_here
FACEBOOK_APP_ID=your_id_here
TELEGRAM_API_ID=your_id_here
TELEGRAM_API_HASH=your_hash_here
```

### 3. TDLib (تليجرام فقط)
- حمّل من: https://github.com/tdlib/td/releases
- ضع الملفات في:
```
app/libs/tdlib.jar
app/src/main/jniLibs/arm64-v8a/libtdjni.so
app/src/main/jniLibs/armeabi-v7a/libtdjni.so
```

### 4. Google Drive (اختياري)
- حمّل `google-services.json` من `console.cloud.google.com`
- ضعه في مجلد `app/`

### 5. Build
```bash
./gradlew assembleDebug
```

---

## GitHub Actions Secrets
أضف في Repository Settings > Secrets:
```
YOUTUBE_API_KEY
FACEBOOK_APP_ID
TELEGRAM_API_ID
TELEGRAM_API_HASH
```

---

## التقنيات المستخدمة
`Kotlin` `Jetpack Compose` `Room` `Hilt` `Retrofit` `WorkManager` `Glance`
