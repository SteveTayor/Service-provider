enum DeviceType { phone, tablet, desktop }

class ResponsiveConfig {
  const ResponsiveConfig({
    this.phoneMaxWidth = 599,
    this.tabletMaxWidth = 1023,
  });
  final double phoneMaxWidth;
  final double tabletMaxWidth;
}
