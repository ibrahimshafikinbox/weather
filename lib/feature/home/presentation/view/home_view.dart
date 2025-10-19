import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/feature/favorite/presentation/cubit/favorites_cubit.dart';
import 'package:weather_app/feature/favorite/presentation/cubit/favorites_state.dart';
import 'package:weather_app/feature/home/presentation/widget/weather_error_widget.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../home/data/forcast_entry_model.dart';
import '../../../home/data/hourly_entry_model.dart';
import '../../../home/presentation/widget/aqi_pill.dart';
import '../../../home/presentation/widget/condition_and_range.dart';
import '../../../home/presentation/widget/forecast_summary_card.dart';
import '../../../home/presentation/widget/hourly_forecast_card.dart';
import '../../../home/presentation/widget/metrics_grid.dart';
import '../../../home/presentation/widget/temperature_display.dart.dart';
import '../../../home/presentation/widget/top_bar_title.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherCubit(weatherRepository: context.read())
            ..loadCompleteWeatherData(forecastDays: 5),
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatelessWidget {
  const _HomeViewContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final onText = textTheme.bodyMedium?.color ?? Colors.white;

    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, weatherState) {
            if (weatherState is WeatherLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (weatherState is WeatherErrorState) {
              return Weathererrorwidget();
            }

            if (weatherState is! WeatherCompleteState) {
              return const SizedBox.shrink();
            }

            final currentWeather = weatherState.currentWeather;
            final forecast = weatherState.forecast;
            final location = weatherState.location;

            return BlocConsumer<FavoritesCubit, FavoritesState>(
              listener: (context, favState) {
                if (favState is FavoriteToggleSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        favState.isAdded
                            ? '❤️ ${favState.locationName} added to favorites'
                            : '  ${favState.locationName} removed from favorites',
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: favState.isAdded
                          ? Colors.green
                          : Colors.orange,
                    ),
                  );
                }

                if (favState is FavoritesErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${favState.errorMessage}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, favState) {
                bool isFavorite = false;

                if (favState is FavoritesLoadedState) {
                  final key = _generateKey(
                    location.latitude,
                    location.longitude,
                  );
                  isFavorite = favState.favoriteKeys.contains(key);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<WeatherCubit>().refreshWeather();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        SliverToBoxAdapter(
                          child: TopBarTitle(
                            title: location.name,
                            color: onText,
                            isFavorite: isFavorite,
                            onAddTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Search feature coming soon'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            onFavoriteTap: () {
                              context.read<FavoritesCubit>().toggleFavorite(
                                name: location.name,
                                country: location.country,
                                latitude: location.latitude,
                                longitude: location.longitude,
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _AnimatedTemperatureDisplay(
                                temperatureC: currentWeather.temperatureCelsius
                                    .round(),
                                color: onText.withOpacity(0.95),
                              ),
                              SizedBox(height: 8.h),
                              ConditionAndRangeText(
                                condition: currentWeather.condition.text,
                                highC: forecast
                                    .forecastDays
                                    .first
                                    .day
                                    .maxTempCelsius
                                    .round(),
                                lowC: forecast
                                    .forecastDays
                                    .first
                                    .day
                                    .minTempCelsius
                                    .round(),
                                color: onText.withOpacity(0.8),
                              ),
                              SizedBox(height: 12.h),
                              if (currentWeather.airQuality != null)
                                AqiPill(
                                  aqi: currentWeather.airQuality!.usEpaIndex,
                                ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(milliseconds: 800),
                            child: ForecastSummaryCard(
                              headerTitle:
                                  '${forecast.forecastDays.length}-day forecast',
                              headerActionText: 'More details',
                              items: forecast.forecastDays
                                  .map(
                                    (day) => ForecastEntry(
                                      day: DateFormat('EEE').format(day.date),
                                      label: day.day.condition.text,
                                      highC: day.day.maxTempCelsius.round(),
                                      lowC: day.day.minTempCelsius.round(),
                                      icon: _getWeatherIcon(
                                        day.day.condition.code,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onActionTap: () {},
                              onTextColor: onText,
                              primary: colors.primary,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                        SliverToBoxAdapter(
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(milliseconds: 1000),
                            child: HourlyForecastCard(
                              onTextColor: onText,
                              primary: colors.primary,
                              items: forecast.forecastDays.first.hourlyForecasts
                                  .take(24)
                                  .map((hour) {
                                    final isNow =
                                        hour.time.hour == DateTime.now().hour;
                                    return HourlyEntry(
                                      hour: isNow
                                          ? 'Now'
                                          : DateFormat(
                                              'HH:mm',
                                            ).format(hour.time),
                                      tempC: hour.temperatureCelsius.round(),
                                      windKmh: hour.windSpeedKph,
                                      icon: _getWeatherIcon(
                                        hour.condition.code,
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                        SliverToBoxAdapter(
                          child: MetricsGrid(
                            onTextColor: onText,
                            primary: colors.primary,
                            windDirection: currentWeather.windDirection,
                            windSpeedKmh: currentWeather.windSpeedKph,
                            humidity: currentWeather.humidity,
                            realFeel: currentWeather.feelsLikeCelsius.round(),
                            uvIndex: currentWeather.uvIndex.round(),
                            sunrise: forecast.forecastDays.first.astro.sunrise,
                            sunset: forecast.forecastDays.first.astro.sunset,
                            pressureMbar: currentWeather.pressureMb.round(),
                            chanceOfRainPct: forecast
                                .forecastDays
                                .first
                                .day
                                .dailyChanceOfRain,
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _generateKey(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
  }

  IconData _getWeatherIcon(int conditionCode) {
    if (conditionCode == 1000) return Icons.wb_sunny_outlined;
    if (conditionCode >= 1003 && conditionCode <= 1009) {
      return Icons.cloud_queue;
    }
    if (conditionCode >= 1063 && conditionCode <= 1072) {
      return Icons.grain;
    }
    if (conditionCode >= 1180 && conditionCode <= 1201) {
      return Icons.umbrella;
    }
    return Icons.wb_cloudy_outlined;
  }
}

class _AnimatedTemperatureDisplay extends StatefulWidget {
  final int temperatureC;
  final Color color;

  const _AnimatedTemperatureDisplay({
    required this.temperatureC,
    required this.color,
  });

  @override
  State<_AnimatedTemperatureDisplay> createState() =>
      _AnimatedTemperatureDisplayState();
}

class _AnimatedTemperatureDisplayState
    extends State<_AnimatedTemperatureDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: TemperatureDisplay(
          temperatureC: widget.temperatureC,
          color: widget.color,
        ),
      ),
    );
  }
}
