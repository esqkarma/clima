class WeatherModel {
  String
   weatherCondition,
      date,
   location = 'Kollam',
      country,
      imagePath,
      latitude,
      longitude,
      windSpeed;
  double temperature;
  int airQuality;

  WeatherModel(
      {
        required this.weatherCondition,
        required this.temperature,
        required this.date,
        required this.location,
        required this.country,
        required this.latitude,
        required this.longitude,
        required this.airQuality,
        required this.windSpeed,
        required this.imagePath,
      });

  factory WeatherModel.fromJson(Map<String,dynamic> json)
  {
    return WeatherModel(
        weatherCondition: json['current']['condition']['text'].toString(),
        temperature: json['current']['temp_c'],
        date: json['location']['localtime'].toString(),
        location: json['location']['name'].toString(),
        country: json['location']['country'].toString(),
        latitude: json['location']['lat'].toString(),
        longitude: json['location']['lon'].toString(),
        airQuality: json['current']['air_quality']['us-epa-index'],
        windSpeed: json['current']['wind_kph'].toString(),
        imagePath: json['current']['condition']['icon'].toString());
  }
}