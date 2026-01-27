class DialogEntity {
  final int page;
  final String title;
  final String content;

  const DialogEntity({
    required this.page,
    required this.title,
    required this.content,
  });
}

final List<DialogEntity> dialogs = [
  const DialogEntity(
    page: 0,
    title: "What's your preferred name?",
    content: "We'll use it to make your experience more personal",
  ),
  const DialogEntity(page: 1, title: "", content: ""),
  const DialogEntity(
    page: 2,
    title: "Let us know how often you plan meal",
    content: "This helps us shape the right program for you",
  ),
  const DialogEntity(
    page: 3,
    title: "What's your activity level?",
    content:
        "Please enter your best guess. We'll use this to personalize your plan",
  ),
];
