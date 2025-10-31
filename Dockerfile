FROM node:12 AS builder

# تحديد مجلد العمل داخل الحاوية
WORKDIR /usr/src/app

# تثبيت الأدوات الضرورية لبناء المكتبات (مثل bcrypt)
# هذا الأمر خاص بتوزيعات Debian (مثل صورة node:12)
RUN apt-get update && apt-get install -y python make g++ --no-install-recommends

# نسخ ملفات package.json أولاً للاستفادة من التخزين المؤقت لـ Docker
COPY package*.json ./

# تثبيت كل المكتبات (بما في ذلك bcrypt)
RUN npm install

# نسخ باقي ملفات التطبيق
COPY . .


# --- المرحلة الثانية: الصورة النهائية (Final Stage) ---
# نستخدم صورة صغيرة ونظيفة للتشغيل فقط
FROM node:12-slim

# تحديد مجلد العمل
WORKDIR /usr/src/app

# نسخ الملفات التي تم تثبيتها وبناؤها من المرحلة الأولى
COPY --from=builder /usr/src/app .

# فتح المنفذ الذي يعمل عليه التطبيق
EXPOSE 3000

# الأمر الذي سيتم تشغيله عند بدء الحاوية
CMD [ "npm", "start" ]