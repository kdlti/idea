class IdeMenuResponse {
  final String title;
  final String uid;
  bool? isChecked;

  IdeMenuResponse({
    required this.title,
    required this.uid,
    this.isChecked,
  });

  @override
  String toString() {
    return 'Instance of IdeMenuResponse: (title:$title, value: $isChecked, uid:$uid)';
  }
}
