class IdeRadioListOption {
  final String title;
  final String? subtitle;
  final String value;
  final bool enabled;

  IdeRadioListOption({
    required this.title,
    required this.value,
    this.subtitle,
    this.enabled = true,
  });
}
