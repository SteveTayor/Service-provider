import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated cloud with wifi symbol
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.cloud_off_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
              ),

              const SizedBox(height: 32),

              // Main message
              Text(
                "You're offline",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 12),

              // Descriptive text
              Text(
                "Check your connection and try again",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Visual connection indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildConnectionDot(false),
                  _buildConnectionLine(),
                  _buildConnectionDot(false),
                  _buildConnectionLine(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.smartphone,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Subtle hint text
              // Text(
              //   "Pull down to refresh when back online",
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Colors.grey[500],
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionDot(bool isConnected) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isConnected ? Colors.green : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildConnectionLine() {
    return Container(
      width: 24,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
