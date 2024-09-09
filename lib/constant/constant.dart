import 'package:flutter/material.dart';

const cardBackgroundColor = Color(0xFFFFFFFF);
//const cardBackgroundColor = Color(0xFF2A2D3E);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColor = Color(0xFFF3F4F8);
const d_green_accent = Color(0x8AFFEF);
const d_green = Color(0xFF2697FF);

const defaultPadding = 20.0;

const kPrimaryColor = Color(0xFF2697FF);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

const String pieChart = 'assets/images/pieChart.png';
const String trophy = 'assets/images/trophy.png';
const String chat = 'assets/images/chat.png';
const String whiteShape = 'assets/images/whitebg.svg';
const String logo = 'assets/images/shoppingBag.png';
const String profile = 'assets/images/profile.jpg';
const String bg = 'assets/images/background.jpg';
const String manShoes = 'assets/images/manShoes.jpg';
const String success = 'assets/images/success.gif';
const String chatBubble = 'assets/images/emptyChat.png';
const String emptyOrders = 'assets/images/orders.png';
const String callCenter = 'assets/images/center.png';
const String conversation = 'assets/images/conversation.png';

List<Map<String, String>> introData = [
  {
    'image': pieChart,
    'headText': 'Track your routine',
    'descText':
    "Whether it's sets, reps, weight used, you can track it all with our intuitive interface.",
  },
  {
    'image': trophy,
    'headText': 'Set personal goals',
    'descText':
    "We're all in the gym for a reason: goals. set goals for diet and fitness.",
  },
  {
    'image': chat,
    'headText': 'Chat with others',
    'descText': "Inspire and help each other reach fitness and diet goals.",
  },
];

final labels = [
  'Notifications',
  'Payments',
  'Message',
  'My Orders',
  'Setting Account',
  'Call Center',
  'About Application',
];

final icons = [
  Icons.notifications,
  Icons.payment,
  Icons.message,
  Icons.local_dining,
  Icons.settings,
  Icons.person,
  Icons.info,
];

final paymentLabels = [
  'OM (Orange Money)',
  'MoMo (MTN Mobile Money)',
  'Paypal',
  'Yoomee wallet',
];

final paymentIcons = [
  Icons.credit_card,
  Icons.money_off,
  Icons.payment,
  Icons.account_balance_wallet,
];