class CouldNotGetUserException implements Exception {
  final String message;
  const CouldNotGetUserException(
      [this.message = 'Could not retrieve user.']);
  factory CouldNotGetUserException.fromCode(String code) {
    return CouldNotGetUserException(code);
  }
}

class CouldNotSendMessageException implements Exception {
  final String message;
  const CouldNotSendMessageException(
      [this.message = 'Error occurred while sending message.']);
  factory CouldNotSendMessageException.fromCode(String code) {
    return CouldNotSendMessageException(code);
  }
}

class CouldNotGetMessageException implements Exception {
  final String message;
  const CouldNotGetMessageException([this.message = 'Could not get messages.']);
  factory CouldNotGetMessageException.fromCode(String code) {
    return CouldNotGetMessageException(code);
  }
}

class CouldNotCreateChatException implements Exception {
  final String message;
  const CouldNotCreateChatException([this.message = 'Could not create chat.']);
  factory CouldNotCreateChatException.fromCode(String code) {
    return CouldNotCreateChatException(code);
  }
}

class CouldNotGetChatException implements Exception {
  final String message;
  const CouldNotGetChatException([this.message = 'Could not get chats.']);
  factory CouldNotGetChatException.fromCode(String code) {
    return CouldNotGetChatException(code);
  }
}
