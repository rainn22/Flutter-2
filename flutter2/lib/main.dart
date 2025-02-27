import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  DateTime today = DateTime.now();

  List<Ride> ridesToday = RidesService.availableRides.where((ride) =>
      ride.departureDate.year == today.year &&
      ride.departureDate.month == today.month &&
      ride.departureDate.day == today.day).toList();

  if (ridesToday.isEmpty) {
    print("No rides available today.");
  } else {
    for (var ride in ridesToday) {
      print(
          "From: ${ride.departureLocation.name}"  
          "To: ${ride.arrivalLocation.name}"
          "Driver: ${ride.driver.firstName}"
          "Seats: ${ride.remainingSeats}"
          "Price: \$${ride.pricePerSeat.toStringAsFixed(2)}");
    }
  }
}

