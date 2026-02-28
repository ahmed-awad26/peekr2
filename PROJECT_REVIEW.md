# مراجعة مشروع Peekr

## نظرة عامة سريعة
- المشروع عبارة عن تطبيق Android مبني بـ Kotlin + Jetpack Compose مع هيكلية واضحة نسبيًا (طبقات `ui`, `data`, `core`, `widget`).
- توجد إعدادات لتقنيات أساسية مثل Room, Hilt, Retrofit, WorkManager, وGlance Widgets.
- المشروع يحتوي واجهات متعددة (Feed, Archive, Security, Settings) بالإضافة إلى Widgets لكل منصة.

## نقاط القوة
1. **تنظيم المجلدات جيد**: وجود تقسيم واضح للموديولات المنطقية داخل `app/src/main/java/com/peekr`.
2. **اعتماد تقنيات حديثة**: Compose + Hilt + Room + WorkManager.
3. **دعم Widgets متنوع**: Widget موحّد + Widgets للمنصات الفردية.

## المشاكل الحرجة التي تم اكتشافها
1. **مانيفست كان ينقصه `tools` namespace** رغم استخدام `tools:node`، وهذا يسبب فشل في بناء المشروع.
2. **ملفات نسخ احتياطي مفقودة** (`backup_rules.xml` و `data_extraction_rules.xml`) مع أنها مستخدمة داخل المانيفست، ما يؤدي إلى أخطاء موارد أثناء البناء.

## التحسينات المنفذة في هذه المراجعة
- إضافة `xmlns:tools` في ملف `AndroidManifest.xml`.
- إضافة ملف `backup_rules.xml` لمنع نسخ البيانات الحساسة (قاعدة البيانات/SharedPrefs/الملفات).
- إضافة ملف `data_extraction_rules.xml` بنفس سياسة الحماية لنسخ السحابة ونقل الجهاز.

## توصيات لاحقة
1. إضافة Gradle Wrapper (`gradlew`) داخل المستودع لتسهيل البناء الموحد في جميع البيئات.
2. تشغيل CI بسيط (Build + Lint + Unit Tests) لاكتشاف مشاكل المانيفست والموارد مبكرًا.
3. مراجعة الإعداد `android:usesCleartextTraffic="true"` والتأكد أنه ضروري فعلًا (أمنيًا يفضل HTTPS فقط إن أمكن).
4. إضافة اختبارات أساسية لطبقة الـ repository وواجهات ViewModel الحرجة.


## حالة البناء الحالية
- تم تجاوز مشكلة `Unsupported class file major version 69` باستخدام Java 17 بدل Java 25.
- ما زال بناء APK يتوقف في هذه البيئة لأن الوصول إلى مستودع Google Maven محجوب (HTTP 403 عبر الـ proxy)، وبالتالي لا يمكن تنزيل Android Gradle Plugin.
- بعد توفير اتصال لـ `https://dl.google.com` و `https://maven.google.com` أو توفير كاش Gradle داخلي، يمكن تنفيذ `:app:assembleDebug` وإنتاج APK.
