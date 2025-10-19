import 'package:equatable/equatable.dart';

class AirQualityModel extends Equatable {
  final double carbonMonoxide;
  final double nitrogenDioxide;
  final double ozone;
  final double sulphurDioxide;
  final double pm2_5;
  final double pm10;
  final int usEpaIndex;
  final int gbDefraIndex;

  const AirQualityModel({
    required this.carbonMonoxide,
    required this.nitrogenDioxide,
    required this.ozone,
    required this.sulphurDioxide,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    return AirQualityModel(
      carbonMonoxide: (json['co'] as num).toDouble(),
      nitrogenDioxide: (json['no2'] as num).toDouble(),
      ozone: (json['o3'] as num).toDouble(),
      sulphurDioxide: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      usEpaIndex: json['us-epa-index'] as int,
      gbDefraIndex: json['gb-defra-index'] as int,
    );
  }

  @override
  List<Object?> get props => [
    carbonMonoxide,
    nitrogenDioxide,
    ozone,
    sulphurDioxide,
    pm2_5,
    pm10,
    usEpaIndex,
    gbDefraIndex,
  ];
}
