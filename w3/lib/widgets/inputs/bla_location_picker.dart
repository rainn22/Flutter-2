// import 'package:flutter/material.dart';
// import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
// import 'package:week_3_blabla_project/screens/ride_pref/widgets/location_tile.dart';
// import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
// import '../../../model/ride/locations.dart';

// class BlaLocationPicker extends StatefulWidget {
//   final Location;

//   const BlaLocationPicker({super.key, required this.onLocationSelected});

//   @override
//   State<BlaLocationPicker> createState() => _BlaLocationPickerState();
// }

// class _BlaLocationPickerState extends State<BlaLocationPicker> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Location> _filteredLocations = [];
//   bool _showInitialState = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: TextField(
//           controller: _searchController,
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Search city or country',
//             border: InputBorder.none,
//             suffixIcon: _searchController.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: _clearSearch,
//                   )
//                 : null,
//           ),
//           onChanged: (query) {
//             setState(() => _showInitialState = query.isEmpty);
//             _filterLocations(query);
//           },
//         ),
//       ),
//       body: _buildBodyContent(),
//     );
//   }

//   Widget _buildBodyContent() {
//     if (_showInitialState) {
//       return const Center(
//         child: Text(
//           'Start typing to search locations',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     }

//     if (_filteredLocations.isEmpty) {
//       return const Center(
//         child: Text(
//           'No locations found',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     }

//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       itemCount: _filteredLocations.length,
//       separatorBuilder: (_, __) => BlaDivider(),
//       itemBuilder: (context, index) => LocationTile(
//         location: _filteredLocations[index],
//         onTap: () => widget.onLocationSelected(_filteredLocations[index]),
//       ),
//     );
//   }

//   void _filterLocations(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredLocations = [];
//       } else {
//         _filteredLocations = fakeLocations.where((loc) {
//           final nameMatch = loc.name.toLowerCase().contains(query.toLowerCase());
//           final countryMatch = loc.country.name.toLowerCase().contains(query.toLowerCase());
//           return nameMatch || countryMatch;
//         }).toList();
//       }
//     });
//   }

//   void _clearSearch() {
//     setState(() {
//       _searchController.clear();
//       _filteredLocations = [];
//       _showInitialState = true;
//     });
//   }
// }