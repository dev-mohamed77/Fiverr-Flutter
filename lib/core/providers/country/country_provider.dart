import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final countries = [
  "India",
  "China",
  "United States",
  "Indonesia",
  "Pakistan",
  "Nigeria",
  "Brazil",
  "Bangladesh",
  "Russia",
  "Mexico",
  "Ethiopia",
  "Japan",
  "Philippines",
  "Egypt",
  "DR Congo",
  "Vietnam",
  "Iran",
  "Turkey",
  "Germany",
  "Thailand",
  "United Kingdom",
  "Tanzania",
  "France",
  "South Africa",
  "Italy",
  "Kenya",
  "Myanmar",
  "Colombia",
  "South Korea",
  "Uganda",
  "Sudan",
  "Spain",
  "Argentina",
  "Algeria",
  "Iraq",
  "Afghanistan",
  "Poland",
  "Canada",
  "Morocco",
  "Saudi Arabia",
  "Ukraine",
  "Angola",
  "Uzbekistan",
  "Yemen",
  "Peru",
  "Malaysia",
  "Ghana",
  "Mozambique",
  "Nepal",
  "Madagascar",
  "Côte dIvoire",
  "Venezuela",
  "Cameroon",
  "Niger",
  "Australia",
  "North Korea",
  "Mali",
  "Burkina Faso",
  "Syria",
  "Sri Lanka",
  "Malawi",
  "Zambia",
  "Romania",
  "Chile",
  "Kazakhstan",
  "Chad",
  "Ecuador",
  "Somalia",
  "Guatemala",
  "Senegal",
  "Netherlands",
  "Cambodia",
  "Zimbabwe",
  "Guinea",
  "Rwanda",
  "Benin",
  "Burundi",
  "Tunisia",
  "Bolivia",
  "Haiti",
  "Belgium",
  "Jordan",
  "Dominican Republic",
  "Cuba",
  "South Sudan",
  "Sweden",
  "Honduras",
  "Czech Republic (Czechia)",
  "Azerbaijan",
  "Greece",
  "Papua New Guinea",
  "Portugal",
  "Hungary",
  "Tajikistan",
  "United Arab Emirates",
  "Belarus",
  "Togo",
  "Austria",
  "Switzerland",
  "Sierra Leone",
  "Laos",
  "Serbia",
  "Nicaragua",
  "Libya",
  "Paraguay",
  "Kyrgyzstan",
  "Bulgaria",
  "Turkmenistan",
  "El Salvador",
  "Congo",
  "Singapore",
  "Denmark",
  "Slovakia",
  "Central African Republic",
  "Finland",
  "Norway",
  "Liberia",
  "Palestine",
  "Lebanon",
  "New Zealand",
  "Costa Rica",
  "Ireland",
  "Mauritania",
  "Oman",
  "Panama",
  "Kuwait",
  "Croatia",
  "Eritrea",
  "Georgia",
  "Mongolia",
  "Moldova",
  "Uruguay",
  "Bosnia and Herzegovina",
  "Albania",
  "Jamaica",
  "Armenia",
  "Gambia",
  "Lithuania",
  "Qatar",
  "Botswana",
  "Namibia",
  "Gabon",
  "Lesotho",
  "Guinea-Bissau",
  "Slovenia",
  "North Macedonia",
  "Latvia",
  "Equatorial Guinea",
  "Trinidad and Tobago",
  "Bahrain",
  "Timor-Leste",
  "Estonia",
  "Mauritius",
  "Cyprus",
  "Eswatini",
  "Djibouti",
  "Fiji",
  "Comoros",
  "Guyana",
  "Bhutan",
  "Solomon Islands",
  "Luxembourg",
  "Montenegro",
  "Suriname",
  "Cabo Verde",
  "Micronesia",
  "Malta",
  "Maldives",
  "Brunei",
  "Bahamas",
  "Belize",
  "Iceland",
  "Vanuatu",
  "Barbados",
  "Sao Tome & Principe",
  "Samoa",
  "Saint Lucia",
  "Kiribati",
  "Grenada",
  "Tonga",
  "Seychelles",
  "St. Vincent & Grenadines",
  "Antigua and Barbuda",
  "Andorra",
  "Dominica",
  "Saint Kitts & Nevis",
  "Marshall Islands",
  "Liechtenstein",
  "Monaco",
  "San Marino",
];

final countriesProvider = Provider((ref) => countries);

class CountriesManager extends StateNotifier<List<String>> {
  CountriesManager(this.ref) : super(countries) {
    init();
  }

  final Ref ref;

  init() {
    final selectCountry = ref.watch(selectCountryProvider);

    if (selectCountry != null) {
      List<String> country = state;
      int index = country.indexOf(selectCountry);
      if (index > -1) {
        country.removeAt(index);
        country.insert(0, selectCountry);

        state = country;
      }
    }
  }

  searchCountry(String letter) {
    state = state.where((element) {
      return element.toLowerCase().contains(letter);
    }).toList();
  }
}

final countriesManagerProvider =
    StateNotifierProvider.autoDispose<CountriesManager, List<String>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  return CountriesManager(ref);
});

// final countryManageProvider = StateProvider.autoDispose<List<String>>((ref) {
//   final country = ref.watch(countryProvider);
//   final selectCountry = ref.watch(selectCountryProvider);

//   if (selectCountry != null) {
//     int index = country.indexOf(selectCountry);
//     if (index > -1) {
//       country.removeAt(index);
//       country.insert(0, selectCountry);

//       return country;
//     }
//   }
//   return country;
// });

final selectCountryProvider = StateProvider<String?>((ref) => null);

// final searchCountryProvider = StateProvider.family((ref, String word) {
//   final country = ref.watch(countryProvider);

//   return country.where((element) => element.contains(word)).toList();
// });
