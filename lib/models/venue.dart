class Venue {
  int id;
  String url;
  String venueName;
  String image;
  String address;
  String district;
  int minGuestCapacity;
  int maxGuestCapacity;
  int price;
  int contact;
  String description;
  String website;
  String openTime;
  String closingTime;
  List<int> addService;

  Venue(
      {this.id,
        this.url,
        this.venueName,
        this.image,
        this.address,
        this.district,
        this.minGuestCapacity,
        this.maxGuestCapacity,
        this.price,
        this.contact,
        this.description,
        this.website,
        this.openTime,
        this.closingTime,
        this.addService});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    venueName = json['venueName'];
    image = json['image'];
    address = json['address'];
    district = json['district'];
    minGuestCapacity = json['min_guestCapacity'];
    maxGuestCapacity = json['max_guestCapacity'];
    price = json['price'];
    contact = json['contact'];
    description = json['description'];
    website = json['website'];
    openTime = json['openTime'];
    closingTime = json['closingTime'];
    addService = json['addService'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['venueName'] = this.venueName;
    data['image'] = this.image;
    data['address'] = this.address;
    data['district'] = this.district;
    data['min_guestCapacity'] = this.minGuestCapacity;
    data['max_guestCapacity'] = this.maxGuestCapacity;
    data['price'] = this.price;
    data['contact'] = this.contact;
    data['description'] = this.description;
    data['website'] = this.website;
    data['openTime'] = this.openTime;
    data['closingTime'] = this.closingTime;
    data['addService'] = this.addService;
    return data;
  }
}
