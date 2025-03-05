import 'package:week_3_blabla_project/model/ride/locations.dart';
import '../../utils/date_time_util.dart';
import '../user/user.dart';

enum RideStatus {
  created,
  published,
  ongoing,
  finished;
}

///
/// This model describes a Ride.
///
class Ride {
  final Location departureLocation;
  final DateTime departureDate;

  final Location arrivalLocation;
  final DateTime arrivalDateTime;

  final User driver;
  final int availableSeats;
  final double pricePerSeat;
  final bool acceptsPets; 

  RideStatus status = RideStatus.created;
  final List<User> passengers = [];

  Ride({
    required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.arrivalDateTime,
    required this.driver,
    required this.availableSeats,
    required this.pricePerSeat,
    required this.acceptsPets,
  });

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => availableSeats - passengers.length;

  @override
  String toString() {
    return 'Ride from ${departureLocation.name} at ${DateTimeUtils.formatDateTime(departureDate)} '
        'to ${arrivalLocation.name} arriving at ${DateTimeUtils.formatDateTime(arrivalDateTime)}, '
        'Driver: ${driver.toString()}, Seats: $availableSeats, Pets Allowed: ${acceptsPets ? "Yes" : "No"}, '
        'Price: \$${pricePerSeat.toStringAsFixed(2)}';
  }
}