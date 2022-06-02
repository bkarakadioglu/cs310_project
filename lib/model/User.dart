class UserObject {
  String email;
  String displayName;
  String userName;
  String userPic;
  int userLikes;
  Map userPosts;
  int userFollowers;
  List userFollowings;
  UserObject({required this.email, required this.userName, required this.displayName, required this.userFollowers, required this.userFollowings,
    required this.userLikes, required this.userPic, required this.userPosts
  });
  Map<String, dynamic> toJson() => {
    'email':email,
    'displayName':displayName,
    'userName':userName,
    'userPic':userPic,
    'userLikes':userLikes,
    'userPosts':userPosts,
    'userFollowers':userFollowers,
    'userFollowings':userFollowings
  };
  static UserObject fromJson(Map<String, dynamic> json) => UserObject(email: json["email"], userName: json["userName"], displayName: json["displayName"],
      userFollowers: json["userFollowers"], userFollowings: json["userFollowings"], userLikes: json["userLikes"], userPic: json["userPic"],
      userPosts: json["userPosts"]
  );
}