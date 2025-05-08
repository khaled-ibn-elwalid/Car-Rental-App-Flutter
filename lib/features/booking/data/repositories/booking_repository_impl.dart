import 'package:car_rental_app_clean_arch/core/error/exception.dart';
import 'package:car_rental_app_clean_arch/core/error/failure.dart';
import 'package:car_rental_app_clean_arch/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:car_rental_app_clean_arch/features/booking/domain/entites/booking.dart';
import 'package:car_rental_app_clean_arch/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/fpdart.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Booking>> createBooking({
    required String userId,
    required String itemId,
    required String rentalType,
    required DateTime startDate,
    required DateTime endDate,
    required double price,
    required String ownerId,
  }) async {
    try {
      await remoteDataSource.createBooking(
        userId: userId,
        itemId: itemId,
        rentalType: rentalType,
        startDate: startDate,
        endDate: endDate,
        price: price,
        ownerId: ownerId,
      );
      
      // Fetch the created booking to return it
      final bookings = await remoteDataSource.showBookingForItem(
        itemId: itemId,
        rentalType: rentalType,
      );
      
      if (bookings.isEmpty) {
        return Left(Failure('Failed to create booking'));
      }
      
      return Right(bookings.first);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getItemBookings({
    required String itemId,
    required String rentalType,
  }) async {
    try {
      final bookings = await remoteDataSource.showBookingForItem(
        itemId: itemId,
        rentalType: rentalType,
      );
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Failed to fetch bookings'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getOwnerBookings({
    required String ownerId,
    String? rentalType,
  }) async {
    try {
      final bookings = await remoteDataSource.showBookingForOwner(
        ownerId: ownerId,
        rentalType: rentalType,
      );
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Failed to fetch owner bookings'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getUserBookings({
    required String userId,
    String? rentalType,
  }) async {
    try {
      final bookings = await remoteDataSource.showBookingForUser(
        userId: userId,
        rentalType: rentalType,
      );
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Failed to fetch user bookings'));
    }
  }

  @override
  Future<Either<Failure, Booking>> updateBookingApproval({
    required String bookingId,
    required bool isApproved,
  }) async {
    try {
      await remoteDataSource.ownerRequestApprove(
        ownerId: '', // This should be fetched from the booking
        isApproved: isApproved,
        bookingId: bookingId,
      );
      
      // Fetch the updated booking
      final bookings = await remoteDataSource.showBookingForItem(
        itemId: bookingId,
        rentalType: '', // This should be fetched from the booking
      );
      
      if (bookings.isEmpty) {
        return Left(Failure('Failed to update booking'));
      }
      
      return Right(bookings.first);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Failed to update booking approval'));
    }
  }

  @override
  Future<Either<Failure, Booking>> updatePaymentStatus({
    required String bookingId,
    required String paymentStatus,
  }) async {
    try {
      await remoteDataSource.paymentApprove(
        bookingId: bookingId,
        paymentStatus: paymentStatus,
      );
      
      // Fetch the updated booking
      final bookings = await remoteDataSource.showBookingForItem(
        itemId: bookingId,
        rentalType: '', // This should be fetched from the booking
      );
      
      if (bookings.isEmpty) {
        return Left(Failure('Failed to update payment status'));
      }
      
      return Right(bookings.first);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Failed to update payment status'));
    }
  }
}

