import 'package:equatable/equatable.dart';

class WeatherConditionModel extends Equatable {
  final String text;
  final String icon;
  final int code;

  const WeatherConditionModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
      text: json['text'] as String,
      icon: json['icon'] as String,
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'icon': icon, 'code': code};
  }

  @override
  List<Object?> get props => [text, icon, code];
}
