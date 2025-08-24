class ApiRoutes {
  static const signup = '/v1/auth/signup';
  static const login = '/v1/auth/login';
  static const autoLogin = '/v1/auth/refresh';
  static const logout = '/v1/auth/logout';

  static const consultingResult = '/v1/consultings/generate';
  static const aiConsulting = '/v1/consulting/generate';
  static const latestConsulting = '/v1/consulting/:id';
  // static const deleteConsulting = '/consulting/delete';
  //
  static const chatbotMessage = '/chat/message';
  // static const sessionDetail = '/chat/session';
  // static const deleteSession = '/chat/session/delete';
}
