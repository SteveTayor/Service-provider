enum DeviceType { phone, tablet, desktop }

class ResponsiveConfig {
  final double phoneMaxWidth;
  final double tabletMaxWidth;

  const ResponsiveConfig({
    this.phoneMaxWidth = 599,
    this.tabletMaxWidth = 1023,
  });
}
