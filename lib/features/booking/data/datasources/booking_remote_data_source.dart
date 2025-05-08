import 'package:car_rental_app_clean_arch/core/error/exception.dart';
import 'package:car_rental_app_clean_arch/features/booking/data/models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class BookingRemoteDataSource {
  Future<void> createBooking({
    required String userId,
    required String itemId,
    required String rentalType,
    required DateTime startDate,
    required DateTime endDate,
    required double price,
    required String ownerId,
  });

  Future<List<BookingModel>> showBookingForItem({
    required String itemId,
    required String rentalType,
  });

  Future<List<BookingModel>> showBookingForOwner({
    required String ownerId,
    String? rentalType,
  });

  Future<List<BookingModel>> showBookingForUser({
    required String userId,
    String? rentalType,
  });

  Future<void> ownerRequestApprove({
    required String ownerId,
    required bool isApproved,
    required String bookingId,
  });

  Future<void> paymentApprove({
    required String paymentStatus,
    required String bookingId,
  });
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> createBooking({
    required String userId,
    required String itemId,
    required String rentalType,
    required DateTime startDate,
    required DateTime endDate,
    required double price,
    required String ownerId,
  }) async {
    try {
      final booking = BookingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        itemId: itemId,
        rentalType: rentalType,
        startDate: startDate,
        endDate: endDate,
        price: price,
        status: 'pending',
        isApproved: false,
        ownerId: ownerId,
        paymentStatus: 'pending',
      );

      await firestore.collection('bookings').doc(booking.id).set(booking.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> showBookingForItem({
    required String itemId,
    required String rentalType,
  }) async {
    try {
      final snapshot = await firestore
          .collection('bookings')
          .where('itemId', isEqualTo: itemId)
          .where('rentalType', isEqualTo: rentalType)
          .get();

      return snapshot.docs
          .map((doc) => BookingModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> showBookingForOwner({
    required String ownerId,
    String? rentalType,
  }) async {
    try {
      Query query = firestore
          .collection('bookings')
          .where('ownerId', isEqualTo: ownerId);
      
      if (rentalType != null) {
        query = query.where('rentalType', isEqualTo: rentalType);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => BookingModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> showBookingForUser({
    required String userId,
    String? rentalType,
  }) async {
    try {
      Query query = firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId);
      
      if (rentalType != null) {
        query = query.where('rentalType', isEqualTo: rentalType);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => BookingModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> ownerRequestApprove({
    required String ownerId,
    required bool isApproved,
    required String bookingId,
  }) async {
    try {
      await firestore.collection('bookings').doc(bookingId).update({
        'isApproved': isApproved,
        'status': isApproved ? 'approved' : 'rejected',
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> paymentApprove({
    required String paymentStatus,
    required String bookingId,
  }) async {
    try {
      await firestore.collection('bookings').doc(bookingId).update({
        'paymentStatus': paymentStatus,
        'status': paymentStatus == 'paid' ? 'confirmed' : 'pending',
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
