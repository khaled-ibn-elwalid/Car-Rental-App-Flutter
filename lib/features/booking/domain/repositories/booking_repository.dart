import 'package:car_rental_app_clean_arch/core/error/failure.dart';
import 'package:car_rental_app_clean_arch/features/booking/domain/entites/booking.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BookingRepository {
  // Create a new booking
  Future<Either<Failure, Booking>> createBooking({
    required String userId,
    required String itemId,
    required String rentalType,
    required DateTime startDate,
    required DateTime endDate,
    required double price,
    required String ownerId,
  });

  // Get bookings for an owner with optional type filter
  Future<Either<Failure, List<Booking>>> getOwnerBookings({
    required String ownerId,
    String? rentalType,
  });

  // Get bookings for a specific item
  Future<Either<Failure, List<Booking>>> getItemBookings({
    required String itemId,
    required String rentalType,
  });

  // Get bookings for a user with optional type filter
  Future<Either<Failure, List<Booking>>> getUserBookings({
    required String userId,
    String? rentalType,
  });

  // Update booking approval status
  Future<Either<Failure, Booking>> updateBookingApproval({
    required String bookingId,
    required bool isApproved,
  });

  // Update booking payment status
  Future<Either<Failure, Booking>> updatePaymentStatus({
    required String bookingId,
    required String paymentStatus,
  });
}
