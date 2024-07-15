class DataModel {
  const DataModel({
    required this.idStr,
    required this.cleanTxt,
    required this.label,
    required this.lang,
    required this.userIdStr,
    required this.conversationIdStr,
    required this.username,
    required this.tweetUrl,
    required this.createdAt,
    required this.quoteCount,
    required this.replyCount,
    required this.retweetCount,
    required this.favCount,
  });

  final String cleanTxt,
      label,
      lang,
      username,
      tweetUrl,
      createdAt;
  final int idStr,conversationIdStr, userIdStr, quoteCount, replyCount, retweetCount, favCount;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      idStr: json['id_str'] ?? '',
      cleanTxt: json['clean_text'] ?? '',
      label: json['Label'] ?? '',
      lang: json['lang'] ?? '',
      userIdStr: json['user_id_str'] ?? '',
      conversationIdStr: json['conversation_id_str'] ?? '',
      username: json['username'] ?? '',
      tweetUrl: json['tweet_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      quoteCount: json['quote_count'] ?? 0,
      replyCount: json['reply_count'] ?? 0,
      retweetCount: json['retweet_count'] ?? 0,
      favCount: json['favorite_count'] ?? 0,
    );
  }
}
