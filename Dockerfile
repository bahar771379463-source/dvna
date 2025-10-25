
    FROM node:18-alpine AS build

    # حدد مجلد العمل داخل الحاوية
    WORKDIR /app

    # انسخ ملفات package.json و package-lock.json
    COPY package*.json ./

    # ثبت الاعتماديات
    RUN npm install

    # انسخ باقي ملفات التطبيق
    COPY . .

    # --- المرحلة الثانية: تشغيل التطبيق ---
    # استخدم صورة Node.js أصغر حجماً للتشغيل
    FROM node:18-alpine

    WORKDIR /app

    # انسخ الاعتماديات التي تم تثبيتها من مرحلة البناء
    COPY --from=build /app/node_modules ./node_modules

    # انسخ ملفات التطبيق التي تم بناؤها
    COPY --from=build /app .

    # عرّف المنفذ الذي يعمل عليه التطبيق
    EXPOSE 9090

    # الأمر الافتراضي لتشغيل التطبيق
    CMD [ "node", "app.js" ]
    
