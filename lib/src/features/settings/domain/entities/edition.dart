class Edition {
  final String name;
  final String apiName;

  Edition({
    required this.name,
    required this.apiName,
  });
}

List<Edition> editionsList = [
  Edition(
      name: "Muhammad Asad's translation of the Holy Quran",
      apiName: "en.asad"),
  Edition(
    name: "Uthmani",
    apiName: "quran-uthmani",
  ),
  Edition(
    name: "تفسير المیسر",
    apiName: "ar.muyassar",
  ),
];
