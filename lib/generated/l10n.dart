// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Поиск товаров`
  String get search_for_markets_or_products {
    return Intl.message(
      'Поиск товаров',
      name: 'search_for_markets_or_products',
      desc: '',
      args: [],
    );
  }

  /// `ТОП Магазинов`
  String get top_markets {
    return Intl.message(
      'ТОП Магазинов',
      name: 'top_markets',
      desc: '',
      args: [],
    );
  }

  /// `Введите название товара`
  String get ordered_by_nearby_first {
    return Intl.message(
      'Введите название товара',
      name: 'ordered_by_nearby_first',
      desc: '',
      args: [],
    );
  }

  /// `Популярные за неделю`
  String get trending_this_week {
    return Intl.message(
      'Популярные за неделю',
      name: 'trending_this_week',
      desc: '',
      args: [],
    );
  }

  /// `Категории Товаров`
  String get product_categories {
    return Intl.message(
      'Категории Товаров',
      name: 'product_categories',
      desc: '',
      args: [],
    );
  }

  /// `Лучшие Магазины`
  String get most_popular {
    return Intl.message(
      'Лучшие Магазины',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Новые Отзывы`
  String get recent_reviews {
    return Intl.message(
      'Новые Отзывы',
      name: 'recent_reviews',
      desc: '',
      args: [],
    );
  }

  String get our_buyers_choise {
    return Intl.message(
      'Наши покупатели выбирают',
      name: 'our_buyers_choise',
      desc: '',
      args: [],
    );
  }

  /// `Подробнее`
  String get more {
    return Intl.message(
      'Подробнее',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get login {
    return Intl.message(
      'Войти',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Пропустить`
  String get skip {
    return Intl.message(
      'Пропустить',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Обо Мне`
  String get about {
    return Intl.message(
      'Обо Мне',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Применить`
  String get submit {
    return Intl.message(
      'Применить',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Проверка`
  String get verify {
    return Intl.message(
      'Проверка',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Выберите предпочитаемые языки`
  String get select_your_preferred_languages {
    return Intl.message(
      'Выберите предпочитаемые языки',
      name: 'select_your_preferred_languages',
      desc: '',
      args: [],
    );
  }

  /// `Номер Заказа`
  String get order_id {
    return Intl.message(
      'Номер Заказа',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Сортировать`
  String get sort {
    return Intl.message(
      'Сортировать',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Показать все`
  String get show_all {
    return Intl.message(
      'Показать все',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона\nдля входа в аккаунт`
  String get type_phone_to_log_in {
    return Intl.message(
      'Введите номер телефона\nдля входа в аккаунт',
      name: 'type_phone_to_log_in',
      desc: '',
      args: [],
    );
  }

  /// `Категория`
  String get category {
    return Intl.message(
      'Категория',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `К оформлению`
  String get checkout {
    return Intl.message(
      'К оформлению',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Способ оплаты`
  String get payment_mode {
    return Intl.message(
      'Способ оплаты',
      name: 'payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Выберите предпочтительный способ оплаты`
  String get select_your_preferred_payment_mode {
    return Intl.message(
      'Выберите предпочтительный способ оплаты',
      name: 'select_your_preferred_payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Или оформить заказ с`
  String get or_checkout_with {
    return Intl.message(
      'Или оформить заказ с',
      name: 'or_checkout_with',
      desc: '',
      args: [],
    );
  }

  /// `Подитог`
  String get subtotal {
    return Intl.message(
      'Подитог',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Итого`
  String get total {
    return Intl.message(
      'Итого',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Подтверждение Оплаты`
  String get confirm_payment {
    return Intl.message(
      'Подтверждение Оплаты',
      name: 'confirm_payment',
      desc: '',
      args: [],
    );
  }

  /// `Информация`
  String get information {
    return Intl.message(
      'Информация',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Невозможно создать букет из выбранных цветов`
  String get impossible_to_create_bouquet {
    return Intl.message(
      'Невозможно создать букет из выбранных цветов',
      name: 'impossible_to_create_bouquet',
      desc: '',
      args: [],
    );
  }

  /// `Повод`
  String get occasion {
    return Intl.message(
      'Повод',
      name: 'occasion',
      desc: '',
      args: [],
    );
  }

  /// `Состав`
  String get variety {
    return Intl.message(
      'Состав',
      name: 'variety',
      desc: '',
      args: [],
    );
  }

  /// `Кому`
  String get recipients {
    return Intl.message(
      'Кому',
      name: 'recipients',
      desc: '',
      args: [],
    );
  }

  /// `Курьер`
  String get delivery_man {
    return Intl.message(
      'Курьер',
      name: 'delivery_man',
      desc: '',
      args: [],
    );
  }

  /// `Место получения`
  String get pickup_address {
    return Intl.message(
      'Место получения',
      name: 'pickup_address',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы уточнить адрес`
  String get click_to_set_delivery_address {
    return Intl.message(
      'Нажмите, чтобы уточнить адрес',
      name: 'click_to_set_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы выбрать место получения`
  String get click_to_set_pickup_address {
    return Intl.message(
      'Нажмите, чтобы выбрать место получения',
      name: 'click_to_set_pickup_address',
      desc: '',
      args: [],
    );
  }

  /// `Цвет`
  String get color {
    return Intl.message(
      'Цвет',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Добавить адрес`
  String get add_address {
    return Intl.message(
      'Добавить адрес',
      name: 'add_address',
      desc: '',
      args: [],
    );
  }

  /// `Место получения заказа`
  String get place_of_pickup_address {
    return Intl.message(
      'Место получения заказа',
      name: 'place_of_pickup_address',
      desc: '',
      args: [],
    );
  }

  /// `Изменить`
  String get change {
    return Intl.message(
      'Изменить',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `и выше`
  String get and_higher {
    return Intl.message(
      'и выше',
      name: 'and_higher',
      desc: '',
      args: [],
    );
  }

  /// `Цена`
  String get price {
    return Intl.message(
      'Цена',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Рейтинг покупателей`
  String get users_reviews {
    return Intl.message(
      'Рейтинг покупателей',
      name: 'users_reviews',
      desc: '',
      args: [],
    );
  }

  /// `+7`
  String get country_code {
    return Intl.message(
      '+7',
      name: 'country_code',
      desc: '',
      args: [],
    );
  }

  /// `Введите код подтверждения`
  String get write_otp {
    return Intl.message(
      'Введите код подтверждения',
      name: 'write_otp',
      desc: '',
      args: [],
    );
  }

  /// `Код отправлен на`
  String get code_sent_to {
    return Intl.message(
      'Код отправлен на',
      name: 'code_sent_to',
      desc: '',
      args: [],
    );
  }

  /// `Создать букет`
  String get create_bouquet {
    return Intl.message(
      'Создать букет',
      name: 'create_bouquet',
      desc: '',
      args: [],
    );
  }

  /// `Чтобы создать аккаунт, согласитесь на обработку персональных данных`
  String get personal_data_validate {
    return Intl.message(
      'Чтобы создать аккаунт, согласитесь на обработку персональных данных',
      name: 'personal_data_validate',
      desc: '',
      args: [],
    );
  }

  /// `Рекомендуемые товары`
  String get featured_products {
    return Intl.message(
      'Рекомендуемые товары',
      name: 'featured_products',
      desc: '',
      args: [],
    );
  }

  /// `Отзывы о магазине`
  String get what_they_say {
    return Intl.message(
      'Отзывы о магазине',
      name: 'what_they_say',
      desc: '',
      args: [],
    );
  }

  /// `Избранные Товары`
  String get favorite_products {
    return Intl.message(
      'Избранные Товары',
      name: 'favorite_products',
      desc: '',
      args: [],
    );
  }

  /// `Параметры`
  String get options {
    return Intl.message(
      'Параметры',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Выберите параметры, чтобы добавить их к товару`
  String get select_options_to_add_them_on_the_product {
    return Intl.message(
      'Выберите параметры, чтобы добавить их к товару',
      name: 'select_options_to_add_them_on_the_product',
      desc: '',
      args: [],
    );
  }

  /// `Отзывы`
  String get reviews {
    return Intl.message(
      'Отзывы',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Количество`
  String get quantity {
    return Intl.message(
      'Количество',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Добавить в Корзину`
  String get add_to_cart {
    return Intl.message(
      'Добавить в Корзину',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Помощь`
  String get faq {
    return Intl.message(
      'Помощь',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Помощь и Поддержка`
  String get help_supports {
    return Intl.message(
      'Помощь и Поддержка',
      name: 'help_supports',
      desc: '',
      args: [],
    );
  }

  /// `Язык приложения`
  String get app_language {
    return Intl.message(
      'Язык приложения',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Забыли пароль?`
  String get i_forgot_password {
    return Intl.message(
      'Забыли пароль?',
      name: 'i_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Нет аккаунта`
  String get i_dont_have_an_account {
    return Intl.message(
      'Нет аккаунта',
      name: 'i_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `На Карте`
  String get maps_explorer {
    return Intl.message(
      'На Карте',
      name: 'maps_explorer',
      desc: '',
      args: [],
    );
  }

  /// `Все Товары`
  String get all_product {
    return Intl.message(
      'Все Товары',
      name: 'all_product',
      desc: '',
      args: [],
    );
  }

  /// `Уведомления`
  String get notifications {
    return Intl.message(
      'Уведомления',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Подтверждение`
  String get confirmation {
    return Intl.message(
      'Подтверждение',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Спасибо! Ваш заказ получен!`
  String get your_order_has_been_successfully_submitted {
    return Intl.message(
      'Спасибо! Ваш заказ получен!',
      name: 'your_order_has_been_successfully_submitted',
      desc: '',
      args: [],
    );
  }

  /// `Налог`
  String get tax {
    return Intl.message(
      'Налог',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Мои заказы`
  String get my_orders {
    return Intl.message(
      'Мои заказы',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Мой профиль`
  String get profile {
    return Intl.message(
      'Мой профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Избранное`
  String get favorites {
    return Intl.message(
      'Избранное',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Главная`
  String get home {
    return Intl.message(
      'Главная',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Варианты Оплаты`
  String get payment_options {
    return Intl.message(
      'Варианты Оплаты',
      name: 'payment_options',
      desc: '',
      args: [],
    );
  }

  /// `Оплата при доставке`
  String get cash_on_delivery {
    return Intl.message(
      'Оплата при доставке',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Оплата PayPal`
  String get paypal_payment {
    return Intl.message(
      'Оплата PayPal',
      name: 'paypal_payment',
      desc: '',
      args: [],
    );
  }

  /// `Последние Заказы`
  String get recent_orders {
    return Intl.message(
      'Последние Заказы',
      name: 'recent_orders',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Настройки Профиля`
  String get profile_settings {
    return Intl.message(
      'Настройки Профиля',
      name: 'profile_settings',
      desc: '',
      args: [],
    );
  }

  /// `Имя и Фамилия`
  String get full_name {
    return Intl.message(
      'Имя и Фамилия',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Телефон`
  String get phone {
    return Intl.message(
      'Телефон',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Адрес`
  String get address {
    return Intl.message(
      'Адрес',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Настройки платежей`
  String get payments_settings {
    return Intl.message(
      'Настройки платежей',
      name: 'payments_settings',
      desc: '',
      args: [],
    );
  }

  /// `Банковская карта по умолчанию`
  String get default_credit_card {
    return Intl.message(
      'Банковская карта по умолчанию',
      name: 'default_credit_card',
      desc: '',
      args: [],
    );
  }

  /// `Настройки Приложения`
  String get app_settings {
    return Intl.message(
      'Настройки Приложения',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Языки`
  String get languages {
    return Intl.message(
      'Языки',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Русский`
  String get english {
    return Intl.message(
      'Русский',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Поддержка`
  String get help_support {
    return Intl.message(
      'Поддержка',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get register {
    return Intl.message(
      'Регистрация',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрируйтесь!`
  String get lets_start_with_register {
    return Intl.message(
      'Зарегистрируйтесь!',
      name: 'lets_start_with_register',
      desc: '',
      args: [],
    );
  }

  /// `Должно быть больше 3 символов`
  String get should_be_more_than_3_letters {
    return Intl.message(
      'Должно быть больше 3 символов',
      name: 'should_be_more_than_3_letters',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get john_doe {
    return Intl.message(
      'John Doe',
      name: 'john_doe',
      desc: '',
      args: [],
    );
  }

  /// `Должен быть действующий email`
  String get should_be_a_valid_email {
    return Intl.message(
      'Должен быть действующий email',
      name: 'should_be_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Должно быть больше 6 символов`
  String get should_be_more_than_6_letters {
    return Intl.message(
      'Должно быть больше 6 символов',
      name: 'should_be_more_than_6_letters',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Есть аккаунт? Войдите`
  String get i_have_account_back_to_login {
    return Intl.message(
      'Есть аккаунт? Войдите',
      name: 'i_have_account_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Отслеживание заказа`
  String get tracking_order {
    return Intl.message(
      'Отслеживание заказа',
      name: 'tracking_order',
      desc: '',
      args: [],
    );
  }

  /// `Discover & Explorer`
  String get discover__explorer {
    return Intl.message(
      'Discover & Explorer',
      name: 'discover__explorer',
      desc: '',
      args: [],
    );
  }

  /// `Откройте для себя новые магазины, выберите и купите лучшие товары с доставкой на дом или в офис.`
  String get you_can_discover_markets {
    return Intl.message(
      'Откройте для себя новые магазины, выберите и купите лучшие товары с доставкой на дом или в офис.',
      name: 'you_can_discover_markets',
      desc: '',
      args: [],
    );
  }

  /// `Сбросить корзину?`
  String get reset_cart {
    return Intl.message(
      'Сбросить корзину?',
      name: 'reset_cart',
      desc: '',
      args: [],
    );
  }

  /// `Корзина`
  String get cart {
    return Intl.message(
      'Корзина',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Корзина`
  String get shopping_cart {
    return Intl.message(
      'Корзина',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте и нажмите оформить заказ`
  String get verify_your_quantity_and_click_checkout {
    return Intl.message(
      'Проверьте и нажмите оформить заказ',
      name: 'verify_your_quantity_and_click_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Войдите в систему!`
  String get lets_start_with_login {
    return Intl.message(
      'Войдите в систему!',
      name: 'lets_start_with_login',
      desc: '',
      args: [],
    );
  }

  /// `Должно быть более 3 символов`
  String get should_be_more_than_3_characters {
    return Intl.message(
      'Должно быть более 3 символов',
      name: 'should_be_more_than_3_characters',
      desc: '',
      args: [],
    );
  }

  /// `Вы должны добавить товары из одного магазина, выберите товары только из одного магазина!`
  String get you_must_add_products_of_the_same_markets_choose_one {
    return Intl.message(
      'Вы должны добавить товары из одного магазина, выберите товары только из одного магазина!',
      name: 'you_must_add_products_of_the_same_markets_choose_one',
      desc: '',
      args: [],
    );
  }

  /// `Сбросьте товары в корзине и закажите заново из одного магазина`
  String get reset_your_cart_and_order_meals_form_this_market {
    return Intl.message(
      'Сбросьте товары в корзине и закажите заново из одного магазина',
      name: 'reset_your_cart_and_order_meals_form_this_market',
      desc: '',
      args: [],
    );
  }

  /// `Сохраните товары из этого магазина`
  String get keep_your_old_meals_of_this_market {
    return Intl.message(
      'Сохраните товары из этого магазина',
      name: 'keep_your_old_meals_of_this_market',
      desc: '',
      args: [],
    );
  }

  /// `Очистить`
  String get reset {
    return Intl.message(
      'Очистить',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Закрыть`
  String get close {
    return Intl.message(
      'Закрыть',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Настройки приложения`
  String get application_preferences {
    return Intl.message(
      'Настройки приложения',
      name: 'application_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Поддержка`
  String get help__support {
    return Intl.message(
      'Поддержка',
      name: 'help__support',
      desc: '',
      args: [],
    );
  }

  /// `Светлая Тема`
  String get light_mode {
    return Intl.message(
      'Светлая Тема',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Тёмная Тема`
  String get dark_mode {
    return Intl.message(
      'Тёмная Тема',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Выход`
  String get log_out {
    return Intl.message(
      'Выход',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Версия`
  String get version {
    return Intl.message(
      'Версия',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Ваши данные`
  String get personal_data {
    return Intl.message(
      'Ваши данные',
      name: 'personal_data',
      desc: '',
      args: [],
    );
  }

  /// `Способ получения`
  String get shipping_method {
    return Intl.message(
      'Способ получения',
      name: 'shipping_method',
      desc: '',
      args: [],
    );
  }

  /// `Дата и время получения`
  String get shipping_datetime {
    return Intl.message(
      'Дата и время получения',
      name: 'shipping_datetime',
      desc: '',
      args: [],
    );
  }

  /// `Оплата`
  String get payment {
    return Intl.message(
      'Оплата',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Обзор`
  String get review {
    return Intl.message(
      'Обзор',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Подтвержденный заказ`
  String get placed_order {
    return Intl.message(
      'Подтвержденный заказ',
      name: 'placed_order',
      desc: '',
      args: [],
    );
  }

  /// `В вашей корзине ничего нет`
  String get dont_have_any_item_in_your_cart {
    return Intl.message(
      'В вашей корзине ничего нет',
      name: 'dont_have_any_item_in_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `Начать`
  String get start_exploring {
    return Intl.message(
      'Начать',
      name: 'start_exploring',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет новых уведомлений`
  String get dont_have_any_item_in_the_notification_list {
    return Intl.message(
      'У вас нет новых уведомлений',
      name: 'dont_have_any_item_in_the_notification_list',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут уведомления\nоб изменениях статусов заказов`
  String get here_notifications {
    return Intl.message(
      'Здесь будут уведомления\nоб изменениях статусов заказов',
      name: 'here_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Настройки оплаты`
  String get payment_settings {
    return Intl.message(
      'Настройки оплаты',
      name: 'payment_settings',
      desc: '',
      args: [],
    );
  }

  /// `Неверный номер`
  String get not_a_valid_number {
    return Intl.message(
      'Неверный номер',
      name: 'not_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить`
  String get continue_step {
    return Intl.message(
      'Продолжить',
      name: 'continue_step',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Данные отправителя`
  String get sender_data {
    return Intl.message(
      'Данные отправителя',
      name: 'sender_data',
      desc: '',
      args: [],
    );
  }

  /// `Данные получателя`
  String get recipient_data {
    return Intl.message(
      'Данные получателя',
      name: 'recipient_data',
      desc: '',
      args: [],
    );
  }

  /// `Ваш заказ`
  String get your_order {
    return Intl.message(
      'Ваш заказ',
      name: 'your_order',
      desc: '',
      args: [],
    );
  }

  /// `Неверная дата`
  String get not_a_valid_date {
    return Intl.message(
      'Неверная дата',
      name: 'not_a_valid_date',
      desc: '',
      args: [],
    );
  }

  /// `Неверный CVC код`
  String get not_a_valid_cvc {
    return Intl.message(
      'Неверный CVC код',
      name: 'not_a_valid_cvc',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Товар закончился`
  String get out_of_stock {
    return Intl.message(
      'Товар закончился',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Ред.`
  String get edit {
    return Intl.message(
      'Ред.',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Неверное Имя и Фамилия`
  String get not_a_valid_full_name {
    return Intl.message(
      'Неверное Имя и Фамилия',
      name: 'not_a_valid_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email Адрес`
  String get email_address {
    return Intl.message(
      'Email Адрес',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Неверный email`
  String get not_a_valid_email {
    return Intl.message(
      'Неверный email',
      name: 'not_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Неверный телефон`
  String get not_a_valid_phone {
    return Intl.message(
      'Неверный телефон',
      name: 'not_a_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Неверный адрес`
  String get not_a_valid_address {
    return Intl.message(
      'Неверный адрес',
      name: 'not_a_valid_address',
      desc: '',
      args: [],
    );
  }

  /// `Неверная профессия`
  String get not_a_valid_biography {
    return Intl.message(
      'Неверная профессия',
      name: 'not_a_valid_biography',
      desc: '',
      args: [],
    );
  }

  /// `Ваша Профессия`
  String get your_biography {
    return Intl.message(
      'Ваша Профессия',
      name: 'your_biography',
      desc: '',
      args: [],
    );
  }

  /// `Ваш Адрес`
  String get your_address {
    return Intl.message(
      'Ваш Адрес',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `Поиск`
  String get search {
    return Intl.message(
      'Поиск',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Недавний поиск`
  String get recents_search {
    return Intl.message(
      'Недавний поиск',
      name: 'recents_search',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте ваше интернет-соединение`
  String get verify_your_internet_connection {
    return Intl.message(
      'Проверьте ваше интернет-соединение',
      name: 'verify_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Корзина успешно обновлена`
  String get carts_refreshed_successfuly {
    return Intl.message(
      'Корзина успешно обновлена',
      name: 'carts_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Товар {productName} был удален из корзины`
  String the_product_was_removed_from_your_cart(Object productName) {
    return Intl.message(
      'Товар $productName был удален из корзины',
      name: 'the_product_was_removed_from_your_cart',
      desc: '',
      args: [productName],
    );
  }

  /// `Категория успешно обновлена`
  String get category_refreshed_successfuly {
    return Intl.message(
      'Категория успешно обновлена',
      name: 'category_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Уведомления успешно обновлены`
  String get notifications_refreshed_successfuly {
    return Intl.message(
      'Уведомления успешно обновлены',
      name: 'notifications_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Заказ успешно обновлен`
  String get order_refreshed_successfuly {
    return Intl.message(
      'Заказ успешно обновлен',
      name: 'order_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Заказы успешно обновлены`
  String get orders_refreshed_successfuly {
    return Intl.message(
      'Заказы успешно обновлены',
      name: 'orders_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Магазин успешно обновлен`
  String get market_refreshed_successfuly {
    return Intl.message(
      'Магазин успешно обновлен',
      name: 'market_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Настройки профиля успешно обновлены`
  String get profile_settings_updated_successfully {
    return Intl.message(
      'Настройки профиля успешно обновлены',
      name: 'profile_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Настройки оплаты успешно обновлены`
  String get payment_settings_updated_successfully {
    return Intl.message(
      'Настройки оплаты успешно обновлены',
      name: 'payment_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Отслеживание успешно обновлено`
  String get tracking_refreshed_successfuly {
    return Intl.message(
      'Отслеживание успешно обновлено',
      name: 'tracking_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Добро Пожаловать!`
  String get welcome {
    return Intl.message(
      'Добро Пожаловать!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Неправильный email или пароль`
  String get wrong_email_or_password {
    return Intl.message(
      'Неправильный email или пароль',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Адреса успешно обновлены`
  String get addresses_refreshed_successfuly {
    return Intl.message(
      'Адреса успешно обновлены',
      name: 'addresses_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Сохраненные адреса`
  String get delivery_addresses {
    return Intl.message(
      'Сохраненные адреса',
      name: 'delivery_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Добавить`
  String get add {
    return Intl.message(
      'Добавить',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Новый адрес успешно добавлен`
  String get new_address_added_successfully {
    return Intl.message(
      'Новый адрес успешно добавлен',
      name: 'new_address_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Адрес успешно обновлен`
  String get the_address_updated_successfully {
    return Intl.message(
      'Адрес успешно обновлен',
      name: 'the_address_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите и удерживайте, чтобы отредактировать или смахните, чтобы удалить`
  String get long_press_to_edit_item_swipe_item_to_delete_it {
    return Intl.message(
      'Нажмите и удерживайте, чтобы отредактировать или смахните, чтобы удалить',
      name: 'long_press_to_edit_item_swipe_item_to_delete_it',
      desc: '',
      args: [],
    );
  }

  /// `Добавить адрес доставки`
  String get add_delivery_address {
    return Intl.message(
      'Добавить адрес доставки',
      name: 'add_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Домашний адрес`
  String get home_address {
    return Intl.message(
      'Домашний адрес',
      name: 'home_address',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get description {
    return Intl.message(
      'Описание',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Улица Невская, Москва 131131, Россия`
  String get hint_full_address {
    return Intl.message(
      'Улица Невская, Москва 131131, Россия',
      name: 'hint_full_address',
      desc: '',
      args: [],
    );
  }

  /// `Полный адрес`
  String get full_address {
    return Intl.message(
      'Полный адрес',
      name: 'full_address',
      desc: '',
      args: [],
    );
  }

  /// `Email для сброса пароля`
  String get email_to_reset_password {
    return Intl.message(
      'Email для сброса пароля',
      name: 'email_to_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Отправить`
  String get send_password_reset_link {
    return Intl.message(
      'Отправить',
      name: 'send_password_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Я помню пароль, вернуться для входа в систему`
  String get i_remember_my_password_return_to_login {
    return Intl.message(
      'Я помню пароль, вернуться для входа в систему',
      name: 'i_remember_my_password_return_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Ссылка для сброса была отправлена на ваш email`
  String get your_reset_link_has_been_sent_to_your_email {
    return Intl.message(
      'Ссылка для сброса была отправлена на ваш email',
      name: 'your_reset_link_has_been_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка! Проверьте настройки email`
  String get error_verify_email_settings {
    return Intl.message(
      'Ошибка! Проверьте настройки email',
      name: 'error_verify_email_settings',
      desc: '',
      args: [],
    );
  }

  /// `Гость`
  String get guest {
    return Intl.message(
      'Гость',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Вы должны войти в систему, чтобы получить доступ к этому разделу`
  String get you_must_signin_to_access_to_this_section {
    return Intl.message(
      'Вы должны войти в систему, чтобы получить доступ к этому разделу',
      name: 'you_must_signin_to_access_to_this_section',
      desc: '',
      args: [],
    );
  }

  /// `Расскажите об этом магазине`
  String get tell_us_about_this_market {
    return Intl.message(
      'Расскажите об этом магазине',
      name: 'tell_us_about_this_market',
      desc: '',
      args: [],
    );
  }

  /// `Как бы вы оценили этот магазин?`
  String get how_would_you_rate_this_market_ {
    return Intl.message(
      'Как бы вы оценили этот магазин?',
      name: 'how_would_you_rate_this_market_',
      desc: '',
      args: [],
    );
  }

  /// `Расскажите об этом товаре`
  String get tell_us_about_this_product {
    return Intl.message(
      'Расскажите об этом товаре',
      name: 'tell_us_about_this_product',
      desc: '',
      args: [],
    );
  }

  /// `Вы оценили магазин`
  String get the_market_has_been_rated_successfully {
    return Intl.message(
      'Вы оценили магазин',
      name: 'the_market_has_been_rated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Вы оценили товар`
  String get the_product_has_been_rated_successfully {
    return Intl.message(
      'Вы оценили товар',
      name: 'the_product_has_been_rated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Отзывы успешно обновлены!`
  String get reviews_refreshed_successfully {
    return Intl.message(
      'Отзывы успешно обновлены!',
      name: 'reviews_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Плата за доставку`
  String get delivery_fee {
    return Intl.message(
      'Плата за доставку',
      name: 'delivery_fee',
      desc: '',
      args: [],
    );
  }

  /// `Статус заказа изменен`
  String get order_status_changed {
    return Intl.message(
      'Статус заказа изменен',
      name: 'order_status_changed',
      desc: '',
      args: [],
    );
  }

  /// `Новый заказ от клиента`
  String get new_order_from_client {
    return Intl.message(
      'Новый заказ от клиента',
      name: 'new_order_from_client',
      desc: '',
      args: [],
    );
  }

  /// `Покупки`
  String get shopping {
    return Intl.message(
      'Покупки',
      name: 'shopping',
      desc: '',
      args: [],
    );
  }

  /// `Доставка или Самовывоз`
  String get delivery_or_pickup {
    return Intl.message(
      'Доставка или Самовывоз',
      name: 'delivery_or_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Доставка и Самовывоз`
  String get delivery_and_pickup {
    return Intl.message(
      'Доставка и Самовывоз',
      name: 'delivery_and_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Платежная карта успешно обновлена`
  String get payment_card_updated_successfully {
    return Intl.message(
      'Платежная карта успешно обновлена',
      name: 'payment_card_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Доставляется`
  String get deliverable {
    return Intl.message(
      'Доставляется',
      name: 'deliverable',
      desc: '',
      args: [],
    );
  }

  /// `Нет Доставки`
  String get not_deliverable {
    return Intl.message(
      'Нет Доставки',
      name: 'not_deliverable',
      desc: '',
      args: [],
    );
  }

  /// `Шт.`
  String get items {
    return Intl.message(
      'Шт.',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Доставка`
  String get delivery {
    return Intl.message(
      'Доставка',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Самовывоз`
  String get pickup {
    return Intl.message(
      'Самовывоз',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Закрыто`
  String get closed {
    return Intl.message(
      'Закрыто',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Открыто`
  String get open {
    return Intl.message(
      'Открыто',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Км`
  String get km {
    return Intl.message(
      'Км',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `mi`
  String get mi {
    return Intl.message(
      'mi',
      name: 'mi',
      desc: '',
      args: [],
    );
  }

  /// `Адрес доставки`
  String get delivery_address {
    return Intl.message(
      'Адрес доставки',
      name: 'delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Текущее местоположение`
  String get current_location {
    return Intl.message(
      'Текущее местоположение',
      name: 'current_location',
      desc: '',
      args: [],
    );
  }

  /// `Адрес доставки успешно удален`
  String get delivery_address_removed_successfully {
    return Intl.message(
      'Адрес доставки успешно удален',
      name: 'delivery_address_removed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Добавить новый адрес доставки`
  String get add_new_delivery_address {
    return Intl.message(
      'Добавить новый адрес доставки',
      name: 'add_new_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Магазины рядом с вами`
  String get markets_near_to_your_current_location {
    return Intl.message(
      'Магазины рядом с вами',
      name: 'markets_near_to_your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Магазины рядом с`
  String get markets_near_to {
    return Intl.message(
      'Магазины рядом с',
      name: 'markets_near_to',
      desc: '',
      args: [],
    );
  }

  /// `Рядом с`
  String get near_to {
    return Intl.message(
      'Рядом с',
      name: 'near_to',
      desc: '',
      args: [],
    );
  }

  /// `Рядом с вашим текущим местоположением`
  String get near_to_your_current_location {
    return Intl.message(
      'Рядом с вашим текущим местоположением',
      name: 'near_to_your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Заберите свой товар с магазина`
  String get pickup_your_product_from_the_market {
    return Intl.message(
      'Заберите свой товар с магазина',
      name: 'pickup_your_product_from_the_market',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердите адрес доставки`
  String get confirm_your_delivery_address {
    return Intl.message(
      'Подтвердите адрес доставки',
      name: 'confirm_your_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Фильтр`
  String get filter {
    return Intl.message(
      'Фильтр',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Очистить`
  String get clear {
    return Intl.message(
      'Очистить',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Применить`
  String get apply_filters {
    return Intl.message(
      'Применить',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Открытые Магазины`
  String get opened_markets {
    return Intl.message(
      'Открытые Магазины',
      name: 'opened_markets',
      desc: '',
      args: [],
    );
  }

  /// `Разделы`
  String get fields {
    return Intl.message(
      'Разделы',
      name: 'fields',
      desc: '',
      args: [],
    );
  }

  /// `Товар добавлен в корзину`
  String get this_product_was_added_to_cart {
    return Intl.message(
      'Товар добавлен в корзину',
      name: 'this_product_was_added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Результат товаров`
  String get products_result {
    return Intl.message(
      'Результат товаров',
      name: 'products_result',
      desc: '',
      args: [],
    );
  }

  /// `Результат товаров`
  String get products_results {
    return Intl.message(
      'Результат товаров',
      name: 'products_results',
      desc: '',
      args: [],
    );
  }

  /// `Результат магазинов`
  String get markets_results {
    return Intl.message(
      'Результат магазинов',
      name: 'markets_results',
      desc: '',
      args: [],
    );
  }

  /// `Все`
  String get all {
    return Intl.message(
      'Все',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Этот магазин закрыт!`
  String get this_market_is_closed_ {
    return Intl.message(
      'Этот магазин закрыт!',
      name: 'this_market_is_closed_',
      desc: '',
      args: [],
    );
  }

  /// `Неизвестно`
  String get unknown {
    return Intl.message(
      'Неизвестно',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Как бы вы оценили этот магазин?`
  String get how_would_you_rate_this_market {
    return Intl.message(
      'Как бы вы оценили этот магазин?',
      name: 'how_would_you_rate_this_market',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите на звезды ниже, чтобы оставить комментарий`
  String get click_on_the_stars_below_to_leave_comments {
    return Intl.message(
      'Нажмите на звезды ниже, чтобы оставить комментарий',
      name: 'click_on_the_stars_below_to_leave_comments',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы подтвердить свой адрес и оплатить, или нажмите и удерживайте, чтобы изменить свой адрес`
  String get click_to_confirm_your_address_and_pay_or_long_press {
    return Intl.message(
      'Нажмите, чтобы подтвердить свой адрес и оплатить, или нажмите и удерживайте, чтобы изменить свой адрес',
      name: 'click_to_confirm_your_address_and_pay_or_long_press',
      desc: '',
      args: [],
    );
  }

  /// `Visa Card`
  String get visa_card {
    return Intl.message(
      'Visa Card',
      name: 'visa_card',
      desc: '',
      args: [],
    );
  }

  /// `MasterCard`
  String get mastercard {
    return Intl.message(
      'MasterCard',
      name: 'mastercard',
      desc: '',
      args: [],
    );
  }

  /// `PayPal`
  String get paypal {
    return Intl.message(
      'PayPal',
      name: 'paypal',
      desc: '',
      args: [],
    );
  }

  /// `Картой онлайн`
  String get pay_online {
    return Intl.message(
      'Картой онлайн',
      name: 'pay_online',
      desc: '',
      args: [],
    );
  }

  /// `При получении`
  String get pay_by_cash {
    return Intl.message(
      'При получении',
      name: 'pay_by_cash',
      desc: '',
      args: [],
    );
  }

  /// `Оплата при самовывозе`
  String get pay_on_pickup {
    return Intl.message(
      'Оплата при самовывозе',
      name: 'pay_on_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы заплатить картой Visa`
  String get click_to_pay_with_your_visa_card {
    return Intl.message(
      'Нажмите, чтобы заплатить картой Visa',
      name: 'click_to_pay_with_your_visa_card',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы оплатить картой MasterCard`
  String get click_to_pay_with_your_mastercard {
    return Intl.message(
      'Нажмите, чтобы оплатить картой MasterCard',
      name: 'click_to_pay_with_your_mastercard',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы заплатить со своей учетной записи PayPal`
  String get click_to_pay_with_your_paypal_account {
    return Intl.message(
      'Нажмите, чтобы заплатить со своей учетной записи PayPal',
      name: 'click_to_pay_with_your_paypal_account',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы оплатить при доставке`
  String get click_to_pay_cash_on_delivery {
    return Intl.message(
      'Нажмите, чтобы оплатить при доставке',
      name: 'click_to_pay_cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы оплатите при самовывозе`
  String get click_to_pay_on_pickup {
    return Intl.message(
      'Нажмите, чтобы оплатите при самовывозе',
      name: 'click_to_pay_on_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Эта учетная запись электронной почты уже есть`
  String get this_email_account_exists {
    return Intl.message(
      'Эта учетная запись электронной почты уже есть',
      name: 'this_email_account_exists',
      desc: '',
      args: [],
    );
  }

  /// `Эта учетная запись не существует`
  String get this_account_not_exist {
    return Intl.message(
      'Эта учетная запись не существует',
      name: 'this_account_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Номер карты`
  String get card_number {
    return Intl.message(
      'Номер карты',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Оплатить заказ`
  String get place_order {
    return Intl.message(
      'Оплатить заказ',
      name: 'place_order',
      desc: '',
      args: [],
    );
  }

  /// `ДАТА ИСТЕЧЕНИЯ СРОКА`
  String get expiry_date {
    return Intl.message(
      'ДАТА ИСТЕЧЕНИЯ СРОКА',
      name: 'expiry_date',
      desc: '',
      args: [],
    );
  }

  /// `CVV/CVC`
  String get cvv_cvc {
    return Intl.message(
      'CVV/CVC',
      name: 'cvv_cvc',
      desc: '',
      args: [],
    );
  }

  /// `Ваша карта недействительна`
  String get your_credit_card_not_valid {
    return Intl.message(
      'Ваша карта недействительна',
      name: 'your_credit_card_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Номер`
  String get number {
    return Intl.message(
      'Номер',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Действует до`
  String get exp_date {
    return Intl.message(
      'Действует до',
      name: 'exp_date',
      desc: '',
      args: [],
    );
  }

  /// `CVC`
  String get cvc {
    return Intl.message(
      'CVC',
      name: 'cvc',
      desc: '',
      args: [],
    );
  }

  /// `Новый отзыв`
  String get new_review {
    return Intl.message(
      'Новый отзыв',
      name: 'new_review',
      desc: '',
      args: [],
    );
  }

  /// `Заказ принят`
  String get we_got_your_order {
    return Intl.message(
      'Заказ принят',
      name: 'we_got_your_order',
      desc: '',
      args: [],
    );
  }

  /// `Отменен`
  String get order_is_canceled {
    return Intl.message(
      'Отменен',
      name: 'order_is_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Оплачен онлайн`
  String get paid_online {
    return Intl.message(
      'Оплачен онлайн',
      name: 'paid_online',
      desc: '',
      args: [],
    );
  }

  /// `Оплачен при получении`
  String get paid_offline {
    return Intl.message(
      'Оплачен при получении',
      name: 'paid_offline',
      desc: '',
      args: [],
    );
  }

  /// `Заказ собирается`
  String get order_is_packing {
    return Intl.message(
      'Заказ собирается',
      name: 'order_is_packing',
      desc: '',
      args: [],
    );
  }

  /// `Информация о заказе`
  String get order_info {
    return Intl.message(
      'Информация о заказе',
      name: 'order_info',
      desc: '',
      args: [],
    );
  }

  /// `Оплата при получении`
  String get pay_when_have_order {
    return Intl.message(
      'Оплата при получении',
      name: 'pay_when_have_order',
      desc: '',
      args: [],
    );
  }

  /// `Ожидайте курьера`
  String get wait_for_delivery_man {
    return Intl.message(
      'Ожидайте курьера',
      name: 'wait_for_delivery_man',
      desc: '',
      args: [],
    );
  }

  /// `Можно забрать`
  String get ready_for_pickup {
    return Intl.message(
      'Можно забрать',
      name: 'ready_for_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Текущие заказы`
  String get current_orders {
    return Intl.message(
      'Текущие заказы',
      name: 'current_orders',
      desc: '',
      args: [],
    );
  }

  /// `Ожидают доставки`
  String get wait_for_delivery {
    return Intl.message(
      'Ожидают доставки',
      name: 'wait_for_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Ожидают получения`
  String get wait_for_pickup {
    return Intl.message(
      'Ожидают получения',
      name: 'wait_for_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Вы пока не сделали ни одного заказа`
  String get you_dont_have_orders {
    return Intl.message(
      'Вы пока не сделали ни одного заказа',
      name: 'you_dont_have_orders',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут отображаться текущие,\nвыполненные и отмененные заказы`
  String get here_your_orders {
    return Intl.message(
      'Здесь будут отображаться текущие,\nвыполненные и отмененные заказы',
      name: 'here_your_orders',
      desc: '',
      args: [],
    );
  }

  /// `Выполненные заказы`
  String get completed_orders {
    return Intl.message(
      'Выполненные заказы',
      name: 'completed_orders',
      desc: '',
      args: [],
    );
  }

  /// `При отмене заказа деньги вернутся на ваш счет в течение 10 рабочих дней`
  String get you_get_money_back_in_10_days {
    return Intl.message(
      'При отмене заказа деньги вернутся на ваш счет в течение 10 рабочих дней',
      name: 'you_get_money_back_in_10_days',
      desc: '',
      args: [],
    );
  }

  /// `Доставлен`
  String get delivered {
    return Intl.message(
      'Доставлен',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Получен`
  String get received {
    return Intl.message(
      'Получен',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Заполните данные своего профиля, чтобы продолжить`
  String get completeYourProfileDetailsToContinue {
    return Intl.message(
      'Заполните данные своего профиля, чтобы продолжить',
      name: 'completeYourProfileDetailsToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Адрес доставки вне радиуса доставки магазина.`
  String get deliveryAddressOutsideTheDeliveryRangeOfThisMarkets {
    return Intl.message(
      'Адрес доставки вне радиуса доставки магазина.',
      name: 'deliveryAddressOutsideTheDeliveryRangeOfThisMarkets',
      desc: '',
      args: [],
    );
  }

  /// `Этот магазин не поддерживает способ доставки.`
  String get thisMarketNotSupportDeliveryMethod {
    return Intl.message(
      'Этот магазин не поддерживает способ доставки.',
      name: 'thisMarketNotSupportDeliveryMethod',
      desc: '',
      args: [],
    );
  }

  /// `Один или несколько товаров в вашей корзине не подлежат доставке.`
  String get oneOrMoreProductsInYourCartNotDeliverable {
    return Intl.message(
      'Один или несколько товаров в вашей корзине не подлежат доставке.',
      name: 'oneOrMoreProductsInYourCartNotDeliverable',
      desc: '',
      args: [],
    );
  }

  /// `Способ доставки не разрешен!`
  String get deliveryMethodNotAllowed {
    return Intl.message(
      'Способ доставки не разрешен!',
      name: 'deliveryMethodNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Посмотреть детали`
  String get viewDetails {
    return Intl.message(
      'Посмотреть детали',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет заказа`
  String get youDontHaveAnyOrder {
    return Intl.message(
      'У вас нет заказа',
      name: 'youDontHaveAnyOrder',
      desc: '',
      args: [],
    );
  }

  /// `Информация для заказа`
  String get orderDetails {
    return Intl.message(
      'Информация для заказа',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Заказ`
  String get order {
    return Intl.message(
      'Заказ',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Заказ принят!`
  String get order_is_placed {
    return Intl.message(
      'Заказ принят!',
      name: 'order_is_placed',
      desc: '',
      args: [],
    );
  }

  /// `Номер заказа: `
  String get order_number {
    return Intl.message(
      'Номер заказа: ',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Подробности`
  String get details {
    return Intl.message(
      'Подробности',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Отменено`
  String get canceled {
    return Intl.message(
      'Отменено',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Отменить заказ`
  String get cancelOrder {
    return Intl.message(
      'Отменить заказ',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Просмотр`
  String get view {
    return Intl.message(
      'Просмотр',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Да`
  String get yes {
    return Intl.message(
      'Да',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены, что хотите отменить этот заказ?`
  String get areYouSureYouWantToCancelThisOrder {
    return Intl.message(
      'Вы уверены, что хотите отменить этот заказ?',
      name: 'areYouSureYouWantToCancelThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Заказ: #{id} был отменен`
  String orderThisorderidHasBeenCanceled(Object id) {
    return Intl.message(
      'Заказ: #$id был отменен',
      name: 'orderThisorderidHasBeenCanceled',
      desc: '',
      args: [id],
    );
  }

  /// `Нажмите на товар, чтобы узнать подробнее.`
  String get clickOnTheProductToGetMoreDetailsAboutIt {
    return Intl.message(
      'Нажмите на товар, чтобы узнать подробнее.',
      name: 'clickOnTheProductToGetMoreDetailsAboutIt',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите еще раз, чтобы выйти`
  String get tapAgainToLeave {
    return Intl.message(
      'Нажмите еще раз, чтобы выйти',
      name: 'tapAgainToLeave',
      desc: '',
      args: [],
    );
  }

  /// `Закладки успешно обновлён`
  String get favorites_refreshed_successfuly {
    return Intl.message(
      'Закладки успешно обновлён',
      name: 'favorites_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Раздел Поддержка успешно обновлен`
  String get faqsRefreshedSuccessfuly {
    return Intl.message(
      'Раздел Поддержка успешно обновлен',
      name: 'faqsRefreshedSuccessfuly',
      desc: '',
      args: [],
    );
  }

  /// `Товар добавлен в закладки`
  String get thisProductWasAddedToFavorite {
    return Intl.message(
      'Товар добавлен в закладки',
      name: 'thisProductWasAddedToFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Этот товар был удален из закладок`
  String get thisProductWasRemovedFromFavorites {
    return Intl.message(
      'Этот товар был удален из закладок',
      name: 'thisProductWasRemovedFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Товар успешно обновлен`
  String get productRefreshedSuccessfuly {
    return Intl.message(
      'Товар успешно обновлен',
      name: 'productRefreshedSuccessfuly',
      desc: '',
      args: [],
    );
  }

  /// `Платеж RazorPay`
  String get razorpayPayment {
    return Intl.message(
      'Платеж RazorPay',
      name: 'razorpayPayment',
      desc: '',
      args: [],
    );
  }

  /// `RazorPay`
  String get razorpay {
    return Intl.message(
      'RazorPay',
      name: 'razorpay',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите, чтобы оплатить с помощью RazorPay`
  String get clickToPayWithRazorpayMethod {
    return Intl.message(
      'Нажмите, чтобы оплатить с помощью RazorPay',
      name: 'clickToPayWithRazorpayMethod',
      desc: '',
      args: [],
    );
  }

  /// `Товары`
  String get products {
    return Intl.message(
      'Товары',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Купон Правильный`
  String get validCouponCode {
    return Intl.message(
      'Купон Правильный',
      name: 'validCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Неверный Купон`
  String get invalidCouponCode {
    return Intl.message(
      'Неверный Купон',
      name: 'invalidCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `У вас есть купон?`
  String get haveCouponCode {
    return Intl.message(
      'У вас есть купон?',
      name: 'haveCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Сообщения`
  String get messages {
    return Intl.message(
      'Сообщения',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет сообщений`
  String get youDontHaveAnyConversations {
    return Intl.message(
      'У вас нет сообщений',
      name: 'youDontHaveAnyConversations',
      desc: '',
      args: [],
    );
  }

  /// `Новое сообщение от`
  String get newMessageFrom {
    return Intl.message(
      'Новое сообщение от',
      name: 'newMessageFrom',
      desc: '',
      args: [],
    );
  }

  /// `Подробности уточняйте в чате.`
  String get forMoreDetailsPleaseChatWithOurManagers {
    return Intl.message(
      'Подробности уточняйте в чате.',
      name: 'forMoreDetailsPleaseChatWithOurManagers',
      desc: '',
      args: [],
    );
  }

  /// `Авторизуйтесь, чтобы общаться в чате`
  String get signinToChatWithOurManagers {
    return Intl.message(
      'Авторизуйтесь, чтобы общаться в чате',
      name: 'signinToChatWithOurManagers',
      desc: '',
      args: [],
    );
  }

  /// `Введите текст, чтобы начать чат`
  String get typeToStartChat {
    return Intl.message(
      'Введите текст, чтобы начать чат',
      name: 'typeToStartChat',
      desc: '',
      args: [],
    );
  }

  /// `Сделать по умолчанию`
  String get makeItDefault {
    return Intl.message(
      'Сделать по умолчанию',
      name: 'makeItDefault',
      desc: '',
      args: [],
    );
  }

  /// `Недействительный адрес`
  String get notValidAddress {
    return Intl.message(
      'Недействительный адрес',
      name: 'notValidAddress',
      desc: '',
      args: [],
    );
  }

  /// `Смахните по уведомлению, чтобы удалить или прочитать`
  String get swipeLeftTheNotificationToDeleteOrReadUnreadIt {
    return Intl.message(
      'Смахните по уведомлению, чтобы удалить или прочитать',
      name: 'swipeLeftTheNotificationToDeleteOrReadUnreadIt',
      desc: '',
      args: [],
    );
  }

  /// `Это уведомление отмечено как непрочитанное`
  String get thisNotificationHasMarkedAsUnread {
    return Intl.message(
      'Это уведомление отмечено как непрочитанное',
      name: 'thisNotificationHasMarkedAsUnread',
      desc: '',
      args: [],
    );
  }

  /// `Уведомление удалено`
  String get notificationWasRemoved {
    return Intl.message(
      'Уведомление удалено',
      name: 'notificationWasRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Это уведомление отмечено как прочитанное`
  String get thisNotificationHasMarkedAsRead {
    return Intl.message(
      'Это уведомление отмечено как прочитанное',
      name: 'thisNotificationHasMarkedAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Бесплатно`
  String get free {
    return Intl.message(
      'Бесплатно',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Войдите в учетную запись или создайте новую`
  String get loginAccountOrCreateNewOneForFree {
    return Intl.message(
      'Войдите в учетную запись или создайте новую',
      name: 'loginAccountOrCreateNewOneForFree',
      desc: '',
      args: [],
    );
  }

  /// `Телефон`
  String get phoneNumber {
    return Intl.message(
      'Телефон',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `SMS отправлен на`
  String get smsHasBeenSentTo {
    return Intl.message(
      'SMS отправлен на',
      name: 'smsHasBeenSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Мы отправляем СМС для проверки вашего номера телефона.`
  String get weAreSendingOtpToValidateYourMobileNumberHang {
    return Intl.message(
      'Мы отправляем СМС для проверки вашего номера телефона.',
      name: 'weAreSendingOtpToValidateYourMobileNumberHang',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить номер телефона`
  String get verifyPhoneNumber {
    return Intl.message(
      'Подтвердить номер телефона',
      name: 'verifyPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Информация о получателе`
  String get customer_info {
    return Intl.message(
      'Информация о получателе',
      name: 'customer_info',
      desc: '',
      args: [],
    );
  }

  /// `Необязательно`
  String get optional {
    return Intl.message(
      'Необязательно',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Иванов Иван`
  String get receiver_name_mock {
    return Intl.message(
      'Иванов Иван',
      name: 'receiver_name_mock',
      desc: '',
      args: [],
    );
  }

  /// `+9 (999) 999-99-99`
  String get receiver_phone_mock {
    return Intl.message(
      '+9 (999) 999-99-99',
      name: 'receiver_phone_mock',
      desc: '',
      args: [],
    );
  }

  /// `Фамилия и Имя`
  String get receiver_name {
    return Intl.message(
      'Фамилия и Имя',
      name: 'receiver_name',
      desc: '',
      args: [],
    );
  }

  /// `Дата доставки`
  String get delivery_date {
    return Intl.message(
      'Дата доставки',
      name: 'delivery_date',
      desc: '',
      args: [],
    );
  }

  /// `Выберите день`
  String get choose_day {
    return Intl.message(
      'Выберите день',
      name: 'choose_day',
      desc: '',
      args: [],
    );
  }

  /// `Сегодня`
  String get today {
    return Intl.message(
      'Сегодня',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Завтра`
  String get tomorrow {
    return Intl.message(
      'Завтра',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Послезавтра`
  String get day_after_tomorrow {
    return Intl.message(
      'Послезавтра',
      name: 'day_after_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `или используйте календарь`
  String get or_use_calendar {
    return Intl.message(
      'или используйте календарь',
      name: 'or_use_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Доступное время с`
  String get available_time_from {
    return Intl.message(
      'Доступное время с',
      name: 'available_time_from',
      desc: '',
      args: [],
    );
  }

  /// `до`
  String get available_time_to {
    return Intl.message(
      'до',
      name: 'available_time_to',
      desc: '',
      args: [],
    );
  }

  /// `Время доставки`
  String get delivery_time {
    return Intl.message(
      'Время доставки',
      name: 'delivery_time',
      desc: '',
      args: [],
    );
  }

  /// `Время получения`
  String get pickup_time {
    return Intl.message(
      'Время получения',
      name: 'pickup_time',
      desc: '',
      args: [],
    );
  }

  /// `Добавление карты`
  String get add_card {
    return Intl.message(
      'Добавление карты',
      name: 'add_card',
      desc: '',
      args: [],
    );
  }

  /// `Укажите время получения заказа`
  String get choose_pickup_time {
    return Intl.message(
      'Укажите время получения заказа',
      name: 'choose_pickup_time',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут добавленные вами товары`
  String get here_will_be_your_items {
    return Intl.message(
      'Здесь будут добавленные вами товары',
      name: 'here_will_be_your_items',
      desc: '',
      args: [],
    );
  }

  /// `Нажмите на изображение товара, чтобы выбрать цветы для создания букета`
  String get tap_to_create_bouquet {
    return Intl.message(
      'Нажмите на изображение товара, чтобы выбрать цветы для создания букета',
      name: 'tap_to_create_bouquet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'CA'),
      Locale.fromSubtags(languageCode: 'in'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
