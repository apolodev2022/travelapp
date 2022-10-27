class User {
  var _name;
  var _email;
  var _password;

  get password => _password;

  set password(value) {
    _password = value;
  }

  User.Empty();

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': _password,
      };

  User.fromJson(Map<String, dynamic> json) : _name = json['name'], _email = json['email'], _password = json['password'];

  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  User(this._name, this._email, this._password);
}
