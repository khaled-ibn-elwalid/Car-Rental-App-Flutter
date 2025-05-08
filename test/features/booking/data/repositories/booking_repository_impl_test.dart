import 'package:car_rental_app_clean_arch/core/error/exception.dart';
import 'package:car_rental_app_clean_arch/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:car_rental_app_clean_arch/features/booking/data/models/booking_model.dart';
import 'package:car_rental_app_clean_arch/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BookingRemoteDataSource])
void main() {
  late BookingRepositoryImpl repository;
  late MockBookingRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockBookingRemoteDataSource();
    repository = BookingRepositoryImpl(mockDataSource);
  });

  group('createBooking', () {
    final tBookingModel = BookingModel(
      id: '1',
      userId: 'user1',
      itemId: 'item1',
      rentalType: 'car',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      price: 100.0,
      status: 'pending',
      isApproved: false,
      ownerId: 'owner1',
      paymentStatus: 'pending',
    );

    test(
      'should return Booking when remote data source is successful',
      () async {
        // arrange
        when(mockDataSource.createBooking(
          userId: anyNamed('userId'),
          itemId: anyNamed('itemId'),
          rentalType: anyNamed('rentalType'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          price: anyNamed('price'),
          ownerId: anyNamed('ownerId'),
        )).thenAnswer((_) async => null);

        when(mockDataSource.showBookingForItem(
          itemId: anyNamed('itemId'),
          rentalType: anyNamed('rentalType'),
        )).thenAnswer((_) async => [tBookingModel]);

        // act
        final result = await repository.createBooking(
          userId: 'user1',
          itemId: 'item1',
          rentalType: 'car',
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          price: 100.0,
          ownerId: 'owner1',
        );

        // assert
        expect(result.isRight(), true);
        verify(mockDataSource.createBooking(
          userId: 'user1',
          itemId: 'item1',
          rentalType: 'car',
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          price: 100.0,
          ownerId: 'owner1',
        ));
      },
    );

    test(
      'should return Failure when remote data source throws ServerException',
      () async {
        // arrange
        when(mockDataSource.createBooking(
          userId: anyNamed('userId'),
          itemId: anyNamed('itemId'),
          rentalType: anyNamed('rentalType'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          price: anyNamed('price'),
          ownerId: anyNamed('ownerId'),
        )).thenThrow(ServerException('Server error'));

        // act
        final result = await repository.createBooking(
          userId: 'user1',
          itemId: 'item1',
          rentalType: 'car',
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          price: 100.0,
          ownerId: 'owner1',
        );

        // assert
        expect(result.isLeft(), true);
        verify(mockDataSource.createBooking(
          userId: 'user1',
          itemId: 'item1',
          rentalType: 'car',
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          price: 100.0,
          ownerId: 'owner1',
        ));
      },
    );
  });
} 