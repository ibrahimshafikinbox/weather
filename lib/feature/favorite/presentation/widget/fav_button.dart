import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoriteButton extends StatefulWidget {
  final String locationName;
  final String country;
  final double latitude;
  final double longitude;
  final Color? color;
  final double? size;

  const FavoriteButton({
    super.key,
    required this.locationName,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.color,
    this.size,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await context.read<FavoritesCubit>().checkIsFavorite(
      widget.latitude,
      widget.longitude,
    );
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onToggleFavorite() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    context.read<FavoritesCubit>().toggleFavorite(
      name: widget.locationName,
      country: widget.country,
      latitude: widget.latitude,
      longitude: widget.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoriteToggleSuccessState) {
          setState(() {
            _isFavorite = state.isAdded;
          });

          final message = state.isAdded
              ? '${state.locationName} added to favorites'
              : '${state.locationName} removed from favorites';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is FavoritesErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: IconButton(
          onPressed: _onToggleFavorite,
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: widget.color ?? Colors.red,
            size: widget.size ?? 24.sp,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
