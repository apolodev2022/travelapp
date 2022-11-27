class Place {
  var _id;
  var _name;
  var _city;
  var _deparment;
  var _temperature;
  var _rating;
  var _description;

  Place(this._id, this._name, this._city, this._deparment, this._temperature,
      this._rating, this._description);

  get description => _description;

  set description(value) {
    _description = value;
  }

  get rating => _rating;

  set rating(value) {
    _rating = value;
  }

  get temperature => _temperature;

  set temperature(value) {
    _temperature = value;
  }

  get deparment => _deparment;

  set deparment(value) {
    _deparment = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'deparment': deparment,
        'temperature': temperature,
        'rating': rating,
        'description': description,
      };

  Place.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _city = json['city'],
        _deparment = json['deparment'],
        _temperature = json['temperature'],
        _rating = json['rating'],
        _description = json['description'];
}
