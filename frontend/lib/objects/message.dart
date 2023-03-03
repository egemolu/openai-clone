class Message {
  late String message;
  late bool isUserSend;

  Message({
    required this.message,
    required this.isUserSend,
  });

  get getMessage => message;

  set setMessage(message) => this.message = message;

  get getUserSend => isUserSend;

  set setUserSend(userSend) => this.isUserSend = userSend;
}
