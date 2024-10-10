// lib/models/comments_page.dart
class Comment {
  final String profileImageUrl;
  final String text;
  final int likeCount;

  Comment({
    required this.profileImageUrl,
    required this.text,
    required this.likeCount,
  });
}

