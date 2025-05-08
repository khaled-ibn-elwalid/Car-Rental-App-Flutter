import 'package:car_rental_app_clean_arch/features/booking/data/models/booking_model.dart';
import 'package:car_rental_app_clean_arch/features/booking/domain/entites/booking.dart';

class BookingMapper {
  static Booking toEntity(BookingModel model) {
    return Booking(
      id: model.id,
      userId: model.userId,
      itemId: model.itemId,
      rentalType: model.rentalType,
      startDate: model.startDate,
      endDate: model.endDate,
      price: model.price,
      status: model.status,
      isApproved: model.isApproved,
      ownerId: model.ownerId,
      paymentStatus: model.paymentStatus,
    );
  }

  static BookingModel toModel(Booking entity) {
    return BookingModel(
      id: entity.id,
      userId: entity.userId,
      itemId: entity.itemId,
      rentalType: entity.rentalType,
      startDate: entity.startDate,
      endDate: entity.endDate,
      price: entity.price,
      status: entity.status,
      isApproved: entity.isApproved,
      ownerId: entity.ownerId,
      paymentStatus: entity.paymentStatus,
    );
  }

  static List<Booking> toEntityList(List<BookingModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static List<BookingModel> toModelList(List<Booking> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
} 