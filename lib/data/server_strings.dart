class ServerStrings{

  static const serverAddress = 'https://jsonplaceholder.typicode.com/';
  static const _albumSuffix = 'albums';
  static const _userSuffix = '/users';

  static String get albums => serverAddress  + _albumSuffix;
  static String get users => serverAddress  + _userSuffix;
}

