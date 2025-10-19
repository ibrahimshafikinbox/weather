import 'package:equatable/equatable.dart';

class AstroModel extends Equatable {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  const AstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory AstroModel.fromJson(Map<String, dynamic> json) {
    return AstroModel(
      sunrise: json['sunrise'] as String,
      sunset: json['sunset'] as String,
      moonrise: json['moonrise'] as String,
      moonset: json['moonset'] as String,
      moonPhase: json['moon_phase'] as String,
      moonIllumination: json['moon_illumination'] as int,
    );
  }

  @override
  List<Object?> get props => [sunrise, sunset, moonPhase];
}
