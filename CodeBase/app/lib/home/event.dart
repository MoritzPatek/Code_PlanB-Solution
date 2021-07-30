class Event {
  String imageURL;
  String name;
  String address;
  String budget;
  String url;
  String personCount;
  String kidFriendly;
  String kidPause;
  String dogFriendly;

  Event(
      {required this.imageURL,
      required this.name,
      required this.address,
      required this.url,
      required this.budget,
      required this.dogFriendly,
      required this.kidFriendly,
      required this.kidPause,
      required this.personCount});

  Map toJson() {
    return {
      'imageURL': imageURL,
      'name': name,
      'address': address,
      'budget': budget,
      'url': url,
      'personCount': personCount,
      'kidFriendly': kidFriendly,
      'kidPause': kidPause,
      'dogFriendly': dogFriendly
    };
  }
}
