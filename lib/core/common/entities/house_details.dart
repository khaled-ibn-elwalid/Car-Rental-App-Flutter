class HouseDetails {
  final String ownerId;
  final String location;
  final String houseName;
  final String houseNumber;
  bool isBooked;
  final double pricePerDay;
  final String houseUrl;
  final int bedrooms;
  final int bathrooms;
  final double area; // in square meters/feet
  final String description;
  final List<String> amenities; // e.g., ["wifi", "parking", "pool", etc.]

  HouseDetails({
    required this.ownerId,
    required this.location,
    required this.houseName,
    required this.houseNumber,
    required this.isBooked,
    required this.pricePerDay,
    required this.houseUrl,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.description,
    required this.amenities,
  });
} 