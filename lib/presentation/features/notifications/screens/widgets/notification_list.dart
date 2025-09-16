import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/notification_listtile.dart';
import 'package:flutter/material.dart';

class NotificationListWidget extends StatefulWidget {
  final List<NotificationItem> notifications;
  final Function(NotificationItem) onNotificationTap;

  const NotificationListWidget({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget>
    with TickerProviderStateMixin {
  late AnimationController _listAnimationController;
  final List<AnimationController> _itemControllers = [];
  final List<Animation<double>> _fadeAnimations = [];

  @override
  void initState() {
    super.initState();
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _initializeItemAnimations();
    _animateList();
  }

  void _initializeItemAnimations() {
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    _itemControllers.clear();
    _fadeAnimations.clear();

    for (int i = 0; i < widget.notifications.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );

      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            i * 0.1,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      );

      _itemControllers.add(controller);
      _fadeAnimations.add(fade);
    }
  }

  void _animateList() {
    _listAnimationController.forward();

    for (int i = 0; i < _itemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 80), () {
        if (mounted) {
          _itemControllers[i].forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(NotificationListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notifications.length != widget.notifications.length) {
      _initializeItemAnimations();
      _animateList();
    }
  }

  @override
  void dispose() {
    _listAnimationController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _listAnimationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _listAnimationController,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.notifications.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = widget.notifications[index];

                    return FadeTransition(
                      opacity: _fadeAnimations[index],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _itemControllers[index],
                          curve: Curves.easeOutCubic,
                        )),
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.8,
                            end: 1.0,
                          ).animate(CurvedAnimation(
                            parent: _itemControllers[index],
                            curve: Curves.elasticOut,
                          )),
                          child: AnimatedNotificationTile(
                            notification: notification,
                            onTap: () => _handleNotificationTap(notification),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleNotificationTap(NotificationItem notification) {
    widget.onNotificationTap(notification);
  }
}

// Enhanced notification tile with hover and tap animations
class AnimatedNotificationTile extends StatefulWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const AnimatedNotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  State<AnimatedNotificationTile> createState() =>
      _AnimatedNotificationTileState();
}

class _AnimatedNotificationTileState extends State<AnimatedNotificationTile>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _tapController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _tapController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _isPressed ? 0.98 : _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: widget.notification.isRead
                  ? Colors.transparent
                  : const Color(0xFFBBC6D0).withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: _elevationAnimation.value > 0
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: _elevationAnimation.value,
                        offset: Offset(0, _elevationAnimation.value / 2),
                      ),
                    ]
                  : null,
            ),
            child: GestureDetector(
              onTapDown: (_) {
                setState(() => _isPressed = true);
                _tapController.forward();
              },
              onTapUp: (_) {
                setState(() => _isPressed = false);
                _tapController.reverse();
                widget.onTap();
              },
              onTapCancel: () {
                setState(() => _isPressed = false);
                _tapController.reverse();
              },
              child: MouseRegion(
                onEnter: (_) => _hoverController.forward(),
                onExit: (_) => _hoverController.reverse(),
                child: NotificationTile(
                  notification: widget.notification,
                  onTap: widget.onTap,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
