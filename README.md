# Лабораторна робота. Варіант 4 — «Онлайн-магазин»

**Мета:** створити інтерфейс онлайн-магазину на Flutter та навчитися писати
Widget- і Integration-тести з `flutter_test`, `testWidgets`, `WidgetTester`
та `integration_test`.

У проєкті є каталог товарів, кнопка додавання у кошик, керування кількістю,
підсумкова сума, перевірка форми замовлення та екран успішного оформлення.
Стан кошика керується через **Provider / ChangeNotifierProvider**.

## 1. Що потрібно для запуску

- Windows 10/11 із встановленим **Flutter SDK**.
- **VS Code** з розширеннями **Flutter** та **Dart**.
- Google Chrome — щоб запускати магазин у браузері.
- Для Integration-тесту потрібен запущений Android-емулятор або підключений телефон
  з увімкненим налагодженням USB. Android SDK можна встановити через Android Studio.

Відкрийте термінал VS Code (`Terminal → New Terminal`) і перевірте:

```bash
flutter --version
flutter doctor
```

Якщо `flutter` не розпізнається, потрібно додати папку `flutter/bin` до
змінної середовища Windows `Path` і перезапустити VS Code.

## 2. Покроковий запуск у VS Code

1. Розпакуйте архів у зручну папку, наприклад `C:\Projects\online_store_flutter`.
2. У VS Code виберіть **File → Open Folder** і відкрийте цю папку.
3. У терміналі VS Code виконайте:

   ```bash
   flutter create . --project-name online_store --platforms=android,web,windows
   flutter pub get
   ```

   Перша команда генерує стандартні платформні файли Flutter (`android/`,
   `web/`, `windows/`), яких у навчальному архіві немає. **Не запускайте
   `flutter create` з `--overwrite`**, щоб не перезаписати код лабораторної.

4. Запустіть проєкт у Chrome:

   ```bash
   flutter run -d chrome
   ```

5. Додайте товар кнопкою **«До кошика»**, відкрийте кошик угорі праворуч,
   змініть кількість, перейдіть до оформлення й уведіть дані.

> На Windows можна також запустити `scripts\setup_windows.bat` — він виконає
> створення платформних файлів і встановлення залежностей. Після цього
> `scripts\run_web.bat` запустить магазин у Chrome.

## 3. Запуск тестів

**Усі Widget- та unit-тести:**

```bash
flutter test
```

**Тільки Widget-тести:**

```bash
flutter test test/widget
```

**Integration-тест на Android:**

1. Запустіть Android-емулятор через Android Studio або підключіть телефон.
2. Виконайте команду:

   ```bash
   flutter devices
   ```

3. Скопіюйте ID Android-пристрою й виконайте (замініть `emulator-5554`
   на ID, показаний на вашому комп’ютері):

   ```bash
   flutter test integration_test/app_test.dart -d emulator-5554
   ```

Integration-тест перевіряє повну послідовність дій: відкриття каталогу →
додавання товару → кошик → збільшення кількості → форма замовлення →
підтвердження → екран успіху.

**Примітка:** архів підготовлений без установленого Flutter SDK у середовищі
створення, тому тут не було можливості фактично виконати `flutter test`.
Команди наведені для перевірки на вашому ПК.

## 4. Структура проєкту

```text
online_store_flutter/
├── lib/
│   ├── main.dart                     запуск і ChangeNotifierProvider
│   ├── app.dart                      MaterialApp, тема
│   ├── data/products.dart            каталог із 6 товарів
│   ├── models/product.dart           модель товару
│   ├── state/cart_model.dart         стан кошика через ChangeNotifier
│   ├── utils/format_price.dart       форматування ціни
│   ├── screens/
│   │   ├── shop_screen.dart          каталог
│   │   ├── cart_screen.dart          кошик
│   │   ├── checkout_screen.dart      оформлення
│   │   └── success_screen.dart       успішне замовлення
│   └── widgets/
│       ├── product_card.dart         карточка товару
│       ├── empty_cart_widget.dart    порожній кошик
│       └── checkout_form.dart        форма і валідація
├── test/
│   ├── widget_test.dart             1 smoke Widget-тест
│   ├── cart_model_test.dart          3 додаткові unit-тести
│   └── widget/
│       ├── screens/cart_screen_test.dart
│       └── widgets/
│           ├── product_card_test.dart
│           └── checkout_form_test.dart
├── integration_test/
│   └── app_test.dart                 повний шлях користувача
├── scripts/                          швидкий запуск у Windows
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## 5. Покриття завдань тестами

| Вимога | Де перевіряється |
| --- | --- |
| ProductCard — ціна зі знижкою | `product_card_test.dart`: тест 1 |
| ProductCard — Add to Cart | тест 2 |
| ProductCard — disabled для відсутнього товару | тест 3 |
| ProductCard — правильні rating stars | тести 4, 5 |
| CartScreen — товари, кількість, ціна | `cart_screen_test.dart`: тест 6 |
| CartScreen — збільшення кількості | тест 7 |
| CartScreen — кількість не менше 1 | тест 8 |
| CartScreen — перерахунок Total | тести 9, 12 |
| CartScreen — EmptyCartWidget | тести 10, 11 |
| CheckoutForm — обов’язкові поля | `checkout_form_test.dart`: тести 13, 16, 18 |
| CheckoutForm — формат телефону | тест 14 |
| CheckoutForm — адреса від 10 символів | тест 15 |
| CheckoutForm — активна кнопка лише при валідній формі | тести 16–18 |
| Integration — повний user flow | `integration_test/app_test.dart` |
| Стан через Provider | `lib/main.dart`, `lib/state/cart_model.dart` |
| Finders | `find.byKey`, `find.text`, `find.byType`, `find.byIcon` |
| Matchers | `findsOneWidget`, `findsNothing`, `findsNWidgets` |
| Додаток запускається | `test/widget_test.dart`: тест 19 |

**Разом:** 19 Widget-тестів, 3 unit-тести та 1 Integration-тест.

## 6. Приклади даних для оформлення

- Ім’я та прізвище: `Олена Петренко`
- Телефон: `+380671234567` (дозволені 10–15 цифр і необов’язковий `+`;
  пробіли, дефіси й дужки ігноруються)
- Адреса: `Київ, вул. Центральна, 15` (мінімум 10 символів)

Після правильного заповнення стає активною кнопка **«Підтвердити замовлення»**.
Підтвердження відкриває `SuccessScreen` та очищує кошик.

## 7. Підказки, якщо щось не запускається

- `flutter: command not found` / «не є внутрішньою чи зовнішньою командою»:
  Flutter SDK не встановлений або його `bin` не додано до `Path`.
- `Target of URI doesn't exist: package:provider/provider.dart`:
  виконайте `flutter pub get`.
- `No supported devices connected` для Integration-тесту:
  запустіть Android-емулятор, перевірте `flutter devices`, потім повторіть тест.
- Не бачите Chrome серед пристроїв: виконайте `flutter config --enable-web`,
  перевірте встановлений браузер і повторіть `flutter devices`.
- `No pubspec.yaml file found`: термінал відкритий не в корені проєкту.
- Для Windows desktop-запуску знадобиться Visual Studio з компонентом
  **Desktop development with C++**. Для запуску в Chrome це не потрібно.

## 8. Здача роботи через GitHub

Після `flutter create .` і успішного запуску тестів створіть порожній
репозиторій на [github.com/new](https://github.com/new). Потім виконайте
в терміналі папки проєкту:

```bash
git init
git add .
git commit -m "Flutter online store with widget and integration tests"
git branch -M main
git remote add origin https://github.com/USERNAME/online_store.git
git push -u origin main
```

Замініть `USERNAME` на свій логін GitHub, а `online_store` — на назву
створеного репозиторію. Посилання на репозиторій та цей `README.md`
і є частиною форми здачі. За потреби додайте до звіту скриншот магазину
та скриншот результатів виконання тестів на вашому ПК.
