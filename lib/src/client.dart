import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://developers.zomato.com/api/v2.1/',
    headers: {
      'user-key': DotEnv().env['ZOMATO_API_KEY'],
      'Accept': 'application/json',
    },
  ),
);
