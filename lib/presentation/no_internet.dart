import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor,
              AppColors.primaryColor.withOpacity(0.8)
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cloud with avatar illustration
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      Positioned(
                        top: 8,
                        child: Icon(
                          Icons.wifi_off,
                          size: 24,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Main message
                Text(
                  "No Internet Connection",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[100],
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 12),

                // Descriptive text
                Text(
                  "Verify your connection and give it another try:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[200],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 28),

                // Troubleshooting checklist
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChecklistItem(
                        "Mobile data or WiFi is enabled",
                      ),
                      const SizedBox(height: 12),
                      _buildChecklistItem(
                        "Device has active internet access",
                      ),
                      const SizedBox(height: 12),
                      _buildChecklistItem(
                        "App permissions allow network usage",
                      ),
                    ],
                  ),
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
                      child: const Icon(
                        Icons.smartphone,
                        size: 20,
                        color: AppColors.grey19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[200],
              height: 1.4,
            ),
          ),
        ),
      ],
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
