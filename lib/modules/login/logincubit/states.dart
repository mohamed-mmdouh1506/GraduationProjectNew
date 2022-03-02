abstract class LoginStates {

}

class InitialState extends LoginStates{

}

class ValidateState extends LoginStates{

}

class ShowPasswordState extends LoginStates{

}

class UserLoginSuccessState extends LoginStates{
  final String uId ;
  UserLoginSuccessState(this.uId);
}

class UserLoginErrorState extends LoginStates{

}

