// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(id) => "Заказ: #${id} был отменен";

  static m1(productName) => "Товар ${productName} был удален из корзины";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Обо Мне"),
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "add_address": MessageLookupByLibrary.simpleMessage("Добавить адрес"),
        "add_card": MessageLookupByLibrary.simpleMessage("Добавление карты"),
        "add_delivery_address":
            MessageLookupByLibrary.simpleMessage("Добавить адрес доставки"),
        "add_new_delivery_address": MessageLookupByLibrary.simpleMessage(
            "Добавить новый адрес доставки"),
        "add_to_cart":
            MessageLookupByLibrary.simpleMessage("Добавить в Корзину"),
        "address": MessageLookupByLibrary.simpleMessage("Адрес"),
        "addresses_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Адреса успешно обновлены"),
        "all": MessageLookupByLibrary.simpleMessage("Все"),
        "all_product": MessageLookupByLibrary.simpleMessage("Все Товары"),
        "and_higher": MessageLookupByLibrary.simpleMessage("и выше"),
        "app_language": MessageLookupByLibrary.simpleMessage("Язык приложения"),
        "app_settings":
            MessageLookupByLibrary.simpleMessage("Настройки Приложения"),
        "application_preferences":
            MessageLookupByLibrary.simpleMessage("Настройки приложения"),
        "apply_filters": MessageLookupByLibrary.simpleMessage("Применить"),
        "areYouSureYouWantToCancelThisOrder":
            MessageLookupByLibrary.simpleMessage(
                "Вы уверены, что хотите отменить этот заказ?"),
        "available_time_from":
            MessageLookupByLibrary.simpleMessage("Доступное время с"),
        "available_time_to": MessageLookupByLibrary.simpleMessage("до"),
        "back": MessageLookupByLibrary.simpleMessage("Назад"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "cancelOrder": MessageLookupByLibrary.simpleMessage("Отменить заказ"),
        "canceled": MessageLookupByLibrary.simpleMessage("Отменено"),
        "card_number": MessageLookupByLibrary.simpleMessage("Номер карты"),
        "cart": MessageLookupByLibrary.simpleMessage("Корзина"),
        "carts_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Корзина успешно обновлена"),
        "cash_on_delivery":
            MessageLookupByLibrary.simpleMessage("Оплата при доставке"),
        "category": MessageLookupByLibrary.simpleMessage("Категория"),
        "category_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Категория успешно обновлена"),
        "change": MessageLookupByLibrary.simpleMessage("Изменить"),
        "checkout": MessageLookupByLibrary.simpleMessage("К оформлению"),
        "choose_day": MessageLookupByLibrary.simpleMessage("Выберите день"),
        "choose_pickup_time": MessageLookupByLibrary.simpleMessage(
            "Укажите время получения заказа"),
        "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
        "clickOnTheProductToGetMoreDetailsAboutIt":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите на товар, чтобы узнать подробнее."),
        "clickToPayWithRazorpayMethod": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы оплатить с помощью RazorPay"),
        "click_on_the_stars_below_to_leave_comments":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите на звезды ниже, чтобы оставить комментарий"),
        "click_to_confirm_your_address_and_pay_or_long_press":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите, чтобы подтвердить свой адрес и оплатить, или нажмите и удерживайте, чтобы изменить свой адрес"),
        "click_to_pay_cash_on_delivery": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы оплатить при доставке"),
        "click_to_pay_on_pickup": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы оплатите при самовывозе"),
        "click_to_pay_with_your_mastercard":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите, чтобы оплатить картой MasterCard"),
        "click_to_pay_with_your_paypal_account":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите, чтобы заплатить со своей учетной записи PayPal"),
        "click_to_pay_with_your_visa_card":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите, чтобы заплатить картой Visa"),
        "click_to_set_delivery_address": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы уточнить адрес"),
        "click_to_set_pickup_address": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы выбрать место получения"),
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "closed": MessageLookupByLibrary.simpleMessage("Закрыто"),
        "code_sent_to": MessageLookupByLibrary.simpleMessage(
            "Введите последние 4 цифры номера, который позвонит на"),
        "color": MessageLookupByLibrary.simpleMessage("Цвет"),
        "completeYourProfileDetailsToContinue":
            MessageLookupByLibrary.simpleMessage(
                "Заполните данные своего профиля, чтобы продолжить"),
        "completed_orders":
            MessageLookupByLibrary.simpleMessage("Выполненные заказы"),
        "confirm_payment":
            MessageLookupByLibrary.simpleMessage("Подтверждение Оплаты"),
        "confirm_your_delivery_address":
            MessageLookupByLibrary.simpleMessage("Подтвердите адрес доставки"),
        "confirmation": MessageLookupByLibrary.simpleMessage("Подтверждение"),
        "continue_step": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "country_code": MessageLookupByLibrary.simpleMessage("+7"),
        "create_bouquet": MessageLookupByLibrary.simpleMessage("Создать букет"),
        "current_location":
            MessageLookupByLibrary.simpleMessage("Текущее местоположение"),
        "current_orders":
            MessageLookupByLibrary.simpleMessage("Текущие заказы"),
        "customer_info":
            MessageLookupByLibrary.simpleMessage("Информация о получателе"),
        "cvc": MessageLookupByLibrary.simpleMessage("CVC"),
        "cvv_cvc": MessageLookupByLibrary.simpleMessage("CVV/CVC"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("Тёмная Тема"),
        "day_after_tomorrow":
            MessageLookupByLibrary.simpleMessage("Послезавтра"),
        "default_credit_card": MessageLookupByLibrary.simpleMessage(
            "Банковская карта по умолчанию"),
        "deliverable": MessageLookupByLibrary.simpleMessage("Доставляется"),
        "delivered": MessageLookupByLibrary.simpleMessage("Доставлен"),
        "delivery": MessageLookupByLibrary.simpleMessage("Доставка"),
        "deliveryAddressOutsideTheDeliveryRangeOfThisMarkets":
            MessageLookupByLibrary.simpleMessage(
                "Адрес доставки вне радиуса доставки магазина."),
        "deliveryMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
            "Способ доставки не разрешен!"),
        "delivery_address":
            MessageLookupByLibrary.simpleMessage("Адрес доставки"),
        "delivery_address_removed_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Адрес доставки успешно удален"),
        "delivery_addresses":
            MessageLookupByLibrary.simpleMessage("Сохраненные адреса"),
        "delivery_and_pickup":
            MessageLookupByLibrary.simpleMessage("Доставка и Самовывоз"),
        "delivery_date": MessageLookupByLibrary.simpleMessage("Дата доставки"),
        "delivery_fee":
            MessageLookupByLibrary.simpleMessage("Плата за доставку"),
        "delivery_man": MessageLookupByLibrary.simpleMessage("Курьер"),
        "delivery_or_pickup":
            MessageLookupByLibrary.simpleMessage("Доставка или Самовывоз"),
        "delivery_time": MessageLookupByLibrary.simpleMessage("Время доставки"),
        "description": MessageLookupByLibrary.simpleMessage("Описание"),
        "details": MessageLookupByLibrary.simpleMessage("Подробности"),
        "discover__explorer":
            MessageLookupByLibrary.simpleMessage("Discover & Explorer"),
        "dont_have_any_item_in_the_notification_list":
            MessageLookupByLibrary.simpleMessage("У вас нет новых уведомлений"),
        "dont_have_any_item_in_your_cart":
            MessageLookupByLibrary.simpleMessage("В вашей корзине ничего нет"),
        "edit": MessageLookupByLibrary.simpleMessage("Ред."),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_address": MessageLookupByLibrary.simpleMessage("Email Адрес"),
        "email_to_reset_password":
            MessageLookupByLibrary.simpleMessage("Email для сброса пароля"),
        "english": MessageLookupByLibrary.simpleMessage("Русский"),
        "error_verify_email_settings": MessageLookupByLibrary.simpleMessage(
            "Ошибка! Проверьте настройки email"),
        "exp_date": MessageLookupByLibrary.simpleMessage("Действует до"),
        "expiry_date":
            MessageLookupByLibrary.simpleMessage("ДАТА ИСТЕЧЕНИЯ СРОКА"),
        "faq": MessageLookupByLibrary.simpleMessage("Помощь"),
        "faqsRefreshedSuccessfuly": MessageLookupByLibrary.simpleMessage(
            "Раздел Поддержка успешно обновлен"),
        "favorite_products":
            MessageLookupByLibrary.simpleMessage("Избранные Товары"),
        "favorites": MessageLookupByLibrary.simpleMessage("Избранное"),
        "favorites_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Закладки успешно обновлён"),
        "featured_products":
            MessageLookupByLibrary.simpleMessage("Рекомендуемые товары"),
        "fields": MessageLookupByLibrary.simpleMessage("Разделы"),
        "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
        "forMoreDetailsPleaseChatWithOurManagers":
            MessageLookupByLibrary.simpleMessage(
                "Подробности уточняйте в чате."),
        "free": MessageLookupByLibrary.simpleMessage("Бесплатно"),
        "full_address": MessageLookupByLibrary.simpleMessage("Полный адрес"),
        "full_name": MessageLookupByLibrary.simpleMessage("Имя и Фамилия"),
        "guest": MessageLookupByLibrary.simpleMessage("Гость"),
        "haveCouponCode":
            MessageLookupByLibrary.simpleMessage("У вас есть купон?"),
        "help__support": MessageLookupByLibrary.simpleMessage("Поддержка"),
        "help_support": MessageLookupByLibrary.simpleMessage("Поддержка"),
        "help_supports":
            MessageLookupByLibrary.simpleMessage("Помощь и Поддержка"),
        "here_notifications": MessageLookupByLibrary.simpleMessage(
            "Здесь будут уведомления\nоб изменениях статусов заказов"),
        "here_will_be_your_items": MessageLookupByLibrary.simpleMessage(
            "Здесь будут добавленные вами товары"),
        "here_your_orders": MessageLookupByLibrary.simpleMessage(
            "Здесь будут отображаться текущие,\nвыполненные и отмененные заказы"),
        "hint_full_address": MessageLookupByLibrary.simpleMessage(
            "Улица Невская, Москва 131131, Россия"),
        "home": MessageLookupByLibrary.simpleMessage("Главная"),
        "home_address": MessageLookupByLibrary.simpleMessage("Домашний адрес"),
        "how_would_you_rate_this_market": MessageLookupByLibrary.simpleMessage(
            "Как бы вы оценили этот магазин?"),
        "how_would_you_rate_this_market_": MessageLookupByLibrary.simpleMessage(
            "Как бы вы оценили этот магазин?"),
        "i_dont_have_an_account":
            MessageLookupByLibrary.simpleMessage("Нет аккаунта"),
        "i_forgot_password":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "i_have_account_back_to_login":
            MessageLookupByLibrary.simpleMessage("Есть аккаунт? Войдите"),
        "i_remember_my_password_return_to_login":
            MessageLookupByLibrary.simpleMessage(
                "Я помню пароль, вернуться для входа в систему"),
        "impossible_to_create_bouquet": MessageLookupByLibrary.simpleMessage(
            "Невозможно создать букет из выбранных цветов"),
        "information": MessageLookupByLibrary.simpleMessage("Информация"),
        "invalidCouponCode":
            MessageLookupByLibrary.simpleMessage("Неверный Купон"),
        "items": MessageLookupByLibrary.simpleMessage("Шт."),
        "john_doe": MessageLookupByLibrary.simpleMessage("John Doe"),
        "keep_your_old_meals_of_this_market":
            MessageLookupByLibrary.simpleMessage(
                "Сохраните товары из этого магазина"),
        "km": MessageLookupByLibrary.simpleMessage("Км"),
        "languages": MessageLookupByLibrary.simpleMessage("Языки"),
        "lets_start_with_login":
            MessageLookupByLibrary.simpleMessage("Войдите в систему!"),
        "lets_start_with_register":
            MessageLookupByLibrary.simpleMessage("Зарегистрируйтесь!"),
        "light_mode": MessageLookupByLibrary.simpleMessage("Светлая Тема"),
        "log_out": MessageLookupByLibrary.simpleMessage("Выход"),
        "login": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginAccountOrCreateNewOneForFree":
            MessageLookupByLibrary.simpleMessage(
                "Войдите в учетную запись или создайте новую"),
        "long_press_to_edit_item_swipe_item_to_delete_it":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите и удерживайте, чтобы отредактировать или смахните, чтобы удалить"),
        "makeItDefault":
            MessageLookupByLibrary.simpleMessage("Сделать по умолчанию"),
        "maps_explorer": MessageLookupByLibrary.simpleMessage("На Карте"),
        "market_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Магазин успешно обновлен"),
        "markets_near_to":
            MessageLookupByLibrary.simpleMessage("Магазины рядом с"),
        "markets_near_to_your_current_location":
            MessageLookupByLibrary.simpleMessage("Магазины рядом с вами"),
        "markets_results":
            MessageLookupByLibrary.simpleMessage("Результат магазинов"),
        "mastercard": MessageLookupByLibrary.simpleMessage("MasterCard"),
        "messages": MessageLookupByLibrary.simpleMessage("Сообщения"),
        "mi": MessageLookupByLibrary.simpleMessage("mi"),
        "more": MessageLookupByLibrary.simpleMessage("Подробнее"),
        "most_popular": MessageLookupByLibrary.simpleMessage("Лучшие Магазины"),
        "my_orders": MessageLookupByLibrary.simpleMessage("Мои заказы"),
        "near_to": MessageLookupByLibrary.simpleMessage("Рядом с"),
        "near_to_your_current_location": MessageLookupByLibrary.simpleMessage(
            "Рядом с вашим текущим местоположением"),
        "newMessageFrom":
            MessageLookupByLibrary.simpleMessage("Новое сообщение от"),
        "new_address_added_successfully": MessageLookupByLibrary.simpleMessage(
            "Новый адрес успешно добавлен"),
        "new_order_from_client":
            MessageLookupByLibrary.simpleMessage("Новый заказ от клиента"),
        "new_review": MessageLookupByLibrary.simpleMessage("Новый отзыв"),
        "next": MessageLookupByLibrary.simpleMessage("Далее"),
        "notValidAddress":
            MessageLookupByLibrary.simpleMessage("Недействительный адрес"),
        "not_a_valid_address":
            MessageLookupByLibrary.simpleMessage("Неверный адрес"),
        "not_a_valid_biography":
            MessageLookupByLibrary.simpleMessage("Неверная профессия"),
        "not_a_valid_cvc":
            MessageLookupByLibrary.simpleMessage("Неверный CVC код"),
        "not_a_valid_date":
            MessageLookupByLibrary.simpleMessage("Неверная дата"),
        "not_a_valid_email":
            MessageLookupByLibrary.simpleMessage("Неверный email"),
        "not_a_valid_full_name":
            MessageLookupByLibrary.simpleMessage("Неверное Имя и Фамилия"),
        "not_a_valid_number":
            MessageLookupByLibrary.simpleMessage("Неверный номер"),
        "not_a_valid_phone":
            MessageLookupByLibrary.simpleMessage("Неверный телефон"),
        "not_deliverable": MessageLookupByLibrary.simpleMessage("Нет Доставки"),
        "notificationWasRemoved":
            MessageLookupByLibrary.simpleMessage("Уведомление удалено"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notifications_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage(
                "Уведомления успешно обновлены"),
        "number": MessageLookupByLibrary.simpleMessage("Номер"),
        "occasion": MessageLookupByLibrary.simpleMessage("Повод"),
        "oneOrMoreProductsInYourCartNotDeliverable":
            MessageLookupByLibrary.simpleMessage(
                "Один или несколько товаров в вашей корзине не подлежат доставке."),
        "open": MessageLookupByLibrary.simpleMessage("Открыто"),
        "opened_markets":
            MessageLookupByLibrary.simpleMessage("Открытые Магазины"),
        "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
        "options": MessageLookupByLibrary.simpleMessage("Параметры"),
        "or_checkout_with":
            MessageLookupByLibrary.simpleMessage("Или оформить заказ с"),
        "or_use_calendar":
            MessageLookupByLibrary.simpleMessage("или используйте календарь"),
        "order": MessageLookupByLibrary.simpleMessage("Заказ"),
        "orderDetails":
            MessageLookupByLibrary.simpleMessage("Информация для заказа"),
        "orderThisorderidHasBeenCanceled": m0,
        "order_id": MessageLookupByLibrary.simpleMessage("Номер Заказа"),
        "order_info":
            MessageLookupByLibrary.simpleMessage("Информация о заказе"),
        "order_is_canceled": MessageLookupByLibrary.simpleMessage("Отменен"),
        "order_is_packing":
            MessageLookupByLibrary.simpleMessage("Заказ собирается"),
        "order_is_placed":
            MessageLookupByLibrary.simpleMessage("Заказ принят!"),
        "order_number": MessageLookupByLibrary.simpleMessage("Номер заказа: "),
        "order_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Заказ успешно обновлен"),
        "order_status_changed":
            MessageLookupByLibrary.simpleMessage("Статус заказа изменен"),
        "ordered_by_nearby_first":
            MessageLookupByLibrary.simpleMessage("Введите название товара"),
        "orders_refreshed_successfuly":
            MessageLookupByLibrary.simpleMessage("Заказы успешно обновлены"),
        "out_of_stock":
            MessageLookupByLibrary.simpleMessage("Товар закончился"),
        "paid_offline":
            MessageLookupByLibrary.simpleMessage("Оплачен при получении"),
        "paid_online": MessageLookupByLibrary.simpleMessage("Оплачен онлайн"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "pay_by_cash": MessageLookupByLibrary.simpleMessage("При получении"),
        "pay_on_pickup":
            MessageLookupByLibrary.simpleMessage("Оплата при самовывозе"),
        "pay_online": MessageLookupByLibrary.simpleMessage("Картой онлайн"),
        "pay_when_have_order":
            MessageLookupByLibrary.simpleMessage("Оплата при получении"),
        "payment": MessageLookupByLibrary.simpleMessage("Оплата"),
        "payment_card_updated_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Платежная карта успешно обновлена"),
        "payment_mode": MessageLookupByLibrary.simpleMessage("Способ оплаты"),
        "payment_options":
            MessageLookupByLibrary.simpleMessage("Варианты Оплаты"),
        "payment_settings":
            MessageLookupByLibrary.simpleMessage("Настройки оплаты"),
        "payment_settings_updated_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Настройки оплаты успешно обновлены"),
        "payments_settings":
            MessageLookupByLibrary.simpleMessage("Настройки платежей"),
        "paypal": MessageLookupByLibrary.simpleMessage("PayPal"),
        "paypal_payment": MessageLookupByLibrary.simpleMessage("Оплата PayPal"),
        "personal_data": MessageLookupByLibrary.simpleMessage("Ваши данные"),
        "personal_data_validate": MessageLookupByLibrary.simpleMessage(
            "Чтобы создать аккаунт, согласитесь на обработку персональных данных"),
        "phone": MessageLookupByLibrary.simpleMessage("Телефон"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Телефон"),
        "pickup": MessageLookupByLibrary.simpleMessage("Самовывоз"),
        "pickup_address":
            MessageLookupByLibrary.simpleMessage("Место получения"),
        "pickup_time": MessageLookupByLibrary.simpleMessage("Время получения"),
        "pickup_your_product_from_the_market":
            MessageLookupByLibrary.simpleMessage(
                "Заберите свой товар с магазина"),
        "place_of_pickup_address":
            MessageLookupByLibrary.simpleMessage("Место получения заказа"),
        "place_order": MessageLookupByLibrary.simpleMessage("Оплатить заказ"),
        "placed_order":
            MessageLookupByLibrary.simpleMessage("Подтвержденный заказ"),
        "price": MessageLookupByLibrary.simpleMessage("Цена"),
        "productRefreshedSuccessfuly":
            MessageLookupByLibrary.simpleMessage("Товар успешно обновлен"),
        "product_categories":
            MessageLookupByLibrary.simpleMessage("Категории Товаров"),
        "products": MessageLookupByLibrary.simpleMessage("Товары"),
        "products_result":
            MessageLookupByLibrary.simpleMessage("Результат товаров"),
        "products_results":
            MessageLookupByLibrary.simpleMessage("Результат товаров"),
        "profile": MessageLookupByLibrary.simpleMessage("Мой профиль"),
        "profile_settings":
            MessageLookupByLibrary.simpleMessage("Настройки Профиля"),
        "profile_settings_updated_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Настройки профиля успешно обновлены"),
        "quantity": MessageLookupByLibrary.simpleMessage("Количество"),
        "razorpay": MessageLookupByLibrary.simpleMessage("RazorPay"),
        "razorpayPayment":
            MessageLookupByLibrary.simpleMessage("Платеж RazorPay"),
        "ready_for_pickup":
            MessageLookupByLibrary.simpleMessage("Можно забрать"),
        "received": MessageLookupByLibrary.simpleMessage("Получен"),
        "receiver_name": MessageLookupByLibrary.simpleMessage("Фамилия и Имя"),
        "receiver_name_mock":
            MessageLookupByLibrary.simpleMessage("Иванов Иван"),
        "receiver_phone_mock":
            MessageLookupByLibrary.simpleMessage("+9 (999) 999-99-99"),
        "recent_orders":
            MessageLookupByLibrary.simpleMessage("Последние Заказы"),
        "recent_reviews": MessageLookupByLibrary.simpleMessage("Новые Отзывы"),
        "recents_search":
            MessageLookupByLibrary.simpleMessage("Недавний поиск"),
        "recipient_data":
            MessageLookupByLibrary.simpleMessage("Данные получателя"),
        "recipients": MessageLookupByLibrary.simpleMessage("Кому"),
        "register": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "reset": MessageLookupByLibrary.simpleMessage("Очистить"),
        "reset_cart": MessageLookupByLibrary.simpleMessage("Сбросить корзину?"),
        "reset_your_cart_and_order_meals_form_this_market":
            MessageLookupByLibrary.simpleMessage(
                "Сбросьте товары в корзине и закажите заново из одного магазина"),
        "review": MessageLookupByLibrary.simpleMessage("Обзор"),
        "reviews": MessageLookupByLibrary.simpleMessage("Отзывы"),
        "reviews_refreshed_successfully":
            MessageLookupByLibrary.simpleMessage("Отзывы успешно обновлены!"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "search_for_markets_or_products":
            MessageLookupByLibrary.simpleMessage("Поиск товаров"),
        "select_options_to_add_them_on_the_product":
            MessageLookupByLibrary.simpleMessage(
                "Выберите параметры, чтобы добавить их к товару"),
        "select_your_preferred_languages": MessageLookupByLibrary.simpleMessage(
            "Выберите предпочитаемые языки"),
        "select_your_preferred_payment_mode":
            MessageLookupByLibrary.simpleMessage(
                "Выберите предпочтительный способ оплаты"),
        "send_password_reset_link":
            MessageLookupByLibrary.simpleMessage("Отправить"),
        "sender_data":
            MessageLookupByLibrary.simpleMessage("Данные отправителя"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "shipping_datetime":
            MessageLookupByLibrary.simpleMessage("Дата и время получения"),
        "shipping_method":
            MessageLookupByLibrary.simpleMessage("Способ получения"),
        "shopping": MessageLookupByLibrary.simpleMessage("Покупки"),
        "shopping_cart": MessageLookupByLibrary.simpleMessage("Корзина"),
        "should_be_a_valid_email": MessageLookupByLibrary.simpleMessage(
            "Должен быть действующий email"),
        "should_be_more_than_3_characters":
            MessageLookupByLibrary.simpleMessage(
                "Должно быть более 3 символов"),
        "should_be_more_than_3_letters": MessageLookupByLibrary.simpleMessage(
            "Должно быть больше 3 символов"),
        "should_be_more_than_6_letters": MessageLookupByLibrary.simpleMessage(
            "Должно быть больше 6 символов"),
        "show_all": MessageLookupByLibrary.simpleMessage("Показать все"),
        "signinToChatWithOurManagers": MessageLookupByLibrary.simpleMessage(
            "Авторизуйтесь, чтобы общаться в чате"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "smsHasBeenSentTo":
            MessageLookupByLibrary.simpleMessage("SMS отправлен на"),
        "sort": MessageLookupByLibrary.simpleMessage("Сортировать"),
        "start_exploring": MessageLookupByLibrary.simpleMessage("Начать"),
        "submit": MessageLookupByLibrary.simpleMessage("Применить"),
        "subtotal": MessageLookupByLibrary.simpleMessage("Подитог"),
        "swipeLeftTheNotificationToDeleteOrReadUnreadIt":
            MessageLookupByLibrary.simpleMessage(
                "Смахните по уведомлению, чтобы удалить или прочитать"),
        "tapAgainToLeave": MessageLookupByLibrary.simpleMessage(
            "Нажмите еще раз, чтобы выйти"),
        "tap_to_create_bouquet": MessageLookupByLibrary.simpleMessage(
            "Нажмите на изображение товара, чтобы выбрать цветы для создания букета"),
        "tax": MessageLookupByLibrary.simpleMessage("Налог"),
        "tell_us_about_this_market":
            MessageLookupByLibrary.simpleMessage("Расскажите об этом магазине"),
        "tell_us_about_this_product":
            MessageLookupByLibrary.simpleMessage("Расскажите об этом товаре"),
        "the_address_updated_successfully":
            MessageLookupByLibrary.simpleMessage("Адрес успешно обновлен"),
        "the_market_has_been_rated_successfully":
            MessageLookupByLibrary.simpleMessage("Вы оценили магазин"),
        "the_product_has_been_rated_successfully":
            MessageLookupByLibrary.simpleMessage("Вы оценили товар"),
        "the_product_was_removed_from_your_cart": m1,
        "thisMarketNotSupportDeliveryMethod":
            MessageLookupByLibrary.simpleMessage(
                "Этот магазин не поддерживает способ доставки."),
        "thisNotificationHasMarkedAsRead": MessageLookupByLibrary.simpleMessage(
            "Это уведомление отмечено как прочитанное"),
        "thisNotificationHasMarkedAsUnread":
            MessageLookupByLibrary.simpleMessage(
                "Это уведомление отмечено как непрочитанное"),
        "thisProductWasAddedToFavorite":
            MessageLookupByLibrary.simpleMessage("Товар добавлен в закладки"),
        "thisProductWasRemovedFromFavorites":
            MessageLookupByLibrary.simpleMessage(
                "Этот товар был удален из закладок"),
        "this_account_not_exist": MessageLookupByLibrary.simpleMessage(
            "Эта учетная запись не существует"),
        "this_email_account_exists": MessageLookupByLibrary.simpleMessage(
            "Эта учетная запись электронной почты уже есть"),
        "this_market_is_closed_":
            MessageLookupByLibrary.simpleMessage("Этот магазин закрыт!"),
        "this_product_was_added_to_cart":
            MessageLookupByLibrary.simpleMessage("Товар добавлен в корзину"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "top_markets": MessageLookupByLibrary.simpleMessage("ТОП Магазинов"),
        "total": MessageLookupByLibrary.simpleMessage("Итого"),
        "tracking_order":
            MessageLookupByLibrary.simpleMessage("Отслеживание заказа"),
        "tracking_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
            "Отслеживание успешно обновлено"),
        "trending_this_week":
            MessageLookupByLibrary.simpleMessage("Популярные за неделю"),
        "typeToStartChat": MessageLookupByLibrary.simpleMessage(
            "Введите текст, чтобы начать чат"),
        "type_phone_to_log_in": MessageLookupByLibrary.simpleMessage(
            "Введите номер телефона\nдля входа в аккаунт"),
        "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
        "users_reviews":
            MessageLookupByLibrary.simpleMessage("Рейтинг покупателей"),
        "validCouponCode":
            MessageLookupByLibrary.simpleMessage("Купон Правильный"),
        "variety": MessageLookupByLibrary.simpleMessage("Состав"),
        "verify": MessageLookupByLibrary.simpleMessage("Проверка"),
        "verifyPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Подтвердить номер телефона"),
        "verify_your_internet_connection": MessageLookupByLibrary.simpleMessage(
            "Проверьте ваше интернет-соединение"),
        "verify_your_quantity_and_click_checkout":
            MessageLookupByLibrary.simpleMessage(
                "Проверьте и нажмите оформить заказ"),
        "version": MessageLookupByLibrary.simpleMessage("Версия"),
        "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
        "viewDetails":
            MessageLookupByLibrary.simpleMessage("Посмотреть детали"),
        "visa_card": MessageLookupByLibrary.simpleMessage("Visa Card"),
        "wait_for_delivery":
            MessageLookupByLibrary.simpleMessage("Ожидают доставки"),
        "wait_for_delivery_man":
            MessageLookupByLibrary.simpleMessage("Ожидайте курьера"),
        "wait_for_pickup":
            MessageLookupByLibrary.simpleMessage("Ожидают получения"),
        "weAreSendingOtpToValidateYourMobileNumberHang":
            MessageLookupByLibrary.simpleMessage(
                "Мы отправляем СМС для проверки вашего номера телефона."),
        "we_got_your_order":
            MessageLookupByLibrary.simpleMessage("Заказ принят"),
        "welcome": MessageLookupByLibrary.simpleMessage("Добро Пожаловать!"),
        "what_they_say":
            MessageLookupByLibrary.simpleMessage("Отзывы о магазине"),
        "write_otp":
            MessageLookupByLibrary.simpleMessage("Введите код подтверждения"),
        "wrong_email_or_password": MessageLookupByLibrary.simpleMessage(
            "Неправильный email или пароль"),
        "yes": MessageLookupByLibrary.simpleMessage("Да"),
        "youDontHaveAnyConversations":
            MessageLookupByLibrary.simpleMessage("У вас нет сообщений"),
        "youDontHaveAnyOrder":
            MessageLookupByLibrary.simpleMessage("У вас нет заказа"),
        "you_can_discover_markets": MessageLookupByLibrary.simpleMessage(
            "Откройте для себя новые магазины, выберите и купите лучшие товары с доставкой на дом или в офис."),
        "you_dont_have_orders": MessageLookupByLibrary.simpleMessage(
            "Вы пока не сделали ни одного заказа"),
        "you_get_money_back_in_10_days": MessageLookupByLibrary.simpleMessage(
            "При отмене заказа деньги вернутся на ваш счет в течение 10 рабочих дней"),
        "you_must_add_products_of_the_same_markets_choose_one":
            MessageLookupByLibrary.simpleMessage(
                "Вы должны добавить товары из одного магазина, выберите товары только из одного магазина!"),
        "you_must_signin_to_access_to_this_section":
            MessageLookupByLibrary.simpleMessage(
                "Вы должны войти в систему, чтобы получить доступ к этому разделу"),
        "your_address": MessageLookupByLibrary.simpleMessage("Ваш Адрес"),
        "your_biography":
            MessageLookupByLibrary.simpleMessage("Ваша Профессия"),
        "your_credit_card_not_valid":
            MessageLookupByLibrary.simpleMessage("Ваша карта недействительна"),
        "your_order": MessageLookupByLibrary.simpleMessage("Ваш заказ"),
        "your_order_has_been_successfully_submitted":
            MessageLookupByLibrary.simpleMessage("Спасибо! Ваш заказ получен!"),
        "your_reset_link_has_been_sent_to_your_email":
            MessageLookupByLibrary.simpleMessage(
                "Ссылка для сброса была отправлена на ваш email")
      };
}
