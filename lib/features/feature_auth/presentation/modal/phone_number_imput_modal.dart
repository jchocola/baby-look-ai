import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class PhoneNumberImputModal extends StatefulWidget {
  const PhoneNumberImputModal({super.key});

  @override
  State<PhoneNumberImputModal> createState() => _PhoneNumberImputModalState();
}

class _PhoneNumberImputModalState extends State<PhoneNumberImputModal> {
  late bool isStep1;
  String? _verificationId; // Сохраняем verificationId
  String? _phoneNumber; // Сохраняем номер телефона
  final TextEditingController _smsCodeController = TextEditingController();
  bool _isLoading = false;
  final PinTheme _pinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  void initState() {
    super.initState();
    isStep1 = true;
  }

  @override
  void dispose() {
    _smsCodeController.dispose();
    super.dispose();
  }

  void changeToStep2() {
    setState(() {
      isStep1 = false;
    });
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // ✅ Шаг 1: Отправка номера телефона
  Future<void> _sendPhoneNumber(String phoneNumber) async {
    try {
      setState(() => _isLoading = true);

      // Форматируем номер для Firebase
      final formattedPhone = phoneNumber.startsWith('+')
          ? phoneNumber
          : '+$phoneNumber';

      logger.d('Отправка номера: $formattedPhone');

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          logger.d('Автоподтверждение (Android): $credential');
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          logger.e('Ошибка верификации: ${error.code} - ${error.message}');

          String errorMessage;
          switch (error.code) {
            case 'invalid-phone-number':
              errorMessage = 'Неправильный формат номера телефона';
              break;
            case 'too-many-requests':
              errorMessage = 'Слишком много попыток. Попробуйте позже';
              break;
            case 'quota-exceeded':
              errorMessage = 'Превышен лимит запросов';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Вход по телефону отключен';
              break;
            default:
              errorMessage = 'Ошибка верификации: ${error.message}';
          }

          _showErrorSnackBar(errorMessage);
          setState(() => _isLoading = false);
        },
        codeSent: (String verificationId, int? resendToken) {
          logger.d('Код отправлен. verificationId: $verificationId');

          _verificationId = verificationId;
          _phoneNumber = formattedPhone;

          setState(() => _isLoading = false);
          changeToStep2();

          _showSuccessSnackBar('SMS код отправлен на $formattedPhone');
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          logger.d('Таймаут автоматического получения кода: $verificationId');
          // Для Android: автоматическое получение кода не сработало
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      logger.e('Ошибка при отправке номера: $e');
      _showErrorSnackBar('Неизвестная ошибка: $e');
      setState(() => _isLoading = false);
    }
  }

  // ✅ Шаг 2: Подтверждение SMS кода
  Future<void> _verifySmsCode(String smsCode) async {
    try {
      if (_verificationId == null) {
        _showErrorSnackBar('Не найден verificationId. Попробуйте заново');
        return;
      }

      setState(() => _isLoading = true);

      // Создаем credential с SMS кодом
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _signInWithCredential(credential);
    } catch (e) {
      logger.e('Ошибка при верификации кода: $e');

      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = 'Неверный SMS код';
            break;
          case 'session-expired':
            errorMessage = 'Сессия истекла. Запросите новый код';
            break;
          default:
            errorMessage = 'Ошибка аутентификации: ${e.message}';
        }
      } else {
        errorMessage = 'Неизвестная ошибка: $e';
      }

      _showErrorSnackBar(errorMessage);
      setState(() => _isLoading = false);
    }
  }

  // ✅ Общий метод для входа по credential
  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      logger.d('Успешный вход: ${userCredential.user?.uid}');

      // Проверяем, новый ли пользователь
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser) {
        logger.d('Новый пользователь. Создаем профиль...');
        // Здесь можно создать профиль пользователя в Firestore
        await _createUserProfile(userCredential.user!);
      }

      // Успешная аутентификация - закрываем модалку или переходим дальше
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      logger.e('Ошибка входа: ${e.code} - ${e.message}');
      _showErrorSnackBar('Ошибка входа: ${e.message}');
      setState(() => _isLoading = false);
    }
  }

  // ✅ Создание профиля пользователя (опционально)
  Future<void> _createUserProfile(User user) async {
    try {
      // Пример создания профиля в Firestore
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(user.uid)
      //     .set({
      //       'phoneNumber': _phoneNumber,
      //       'createdAt': FieldValue.serverTimestamp(),
      //       'freeGenerationsUsed': 0,
      //       'premium': false,
      //     });

      logger.d('Профиль создан для ${user.uid}');
    } catch (e) {
      logger.e('Ошибка создания профиля: $e');
      // Можно продолжить, т.к. пользователь уже аутентифицирован
    }
  }

  // ✅ Повторная отправка SMS кода
  Future<void> _resendSmsCode() async {
    if (_phoneNumber == null) {
      _showErrorSnackBar('Номер телефона не найден');
      return;
    }

    await _sendPhoneNumber(_phoneNumber!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isStep1 ? 'Введите номер телефона' : 'Введите SMS код'),
        leading: !isStep1
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    isStep1 = true;
                    _smsCodeController.clear();
                  });
                },
              )
            : null,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstant.appPadding,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Visibility(visible: isStep1, child: buildStep1(context)),
                  Visibility(visible: !isStep1, child: buildStep2(context)),
                ],
              ),
            ),
    );
  }

  Widget buildStep1(BuildContext context) {
    String? phoneNumber;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Введите номер телефона',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Мы отправим SMS с кодом подтверждения',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 24),

        InternationalPhoneNumberInput(
          countries: const ["VN", "RU", "US", "CA", "KZ", "UA", "BY"],
         // initialValue: PhoneNumber(isoCode: 'RU'),
          // selectorConfig: const SelectorConfig(
          //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          // ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          onInputChanged: (PhoneNumber number) {
            phoneNumber = number.phoneNumber;
            logger.d(number);
          },
          onInputValidated: (bool value) {
            logger.d('Номер валиден: $value');
          },
          ignoreBlank: false,
          hintText: 'Номер телефона',
          inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                _sendPhoneNumber(phoneNumber!);
              } else {
                _showErrorSnackBar('Введите номер телефона');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Отправить код', style: TextStyle(fontSize: 16)),
          ),
        ),

        SizedBox(height: 16),

        Text(
          'Нажимая "Отправить код", вы соглашаетесь с нашими Условиями использования и Политикой конфиденциальности',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildStep2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Введите SMS код',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            children: [
              TextSpan(text: 'Код отправлен на '),
              TextSpan(
                text: _phoneNumber ?? '',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        Center(
          child: Pinput(
            length: 6,
            controller: _smsCodeController,
            defaultPinTheme: _pinTheme,
            focusedPinTheme: _pinTheme.copyWith(
              decoration: _pinTheme.decoration?.copyWith(
                border: Border.all(color: Colors.blue),
              ),
            ),
            onCompleted: (pin) {
              _verifySmsCode(pin);
            },
            validator: (value) {
              if (value == null || value.length != 6) {
                return 'Введите 6 цифр';
              }
              return null;
            },
          ),
        ),

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Не получили код?', style: TextStyle(color: Colors.grey[600])),
            TextButton(
              onPressed: _resendSmsCode,
              child: Text('Отправить снова'),
            ),
          ],
        ),

        SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final smsCode = _smsCodeController.text;
              if (smsCode.length == 6) {
                _verifySmsCode(smsCode);
              } else {
                _showErrorSnackBar('Введите 6-значный код');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Подтвердить', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
