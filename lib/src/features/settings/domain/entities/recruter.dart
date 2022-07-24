import 'package:equatable/equatable.dart';

class Recruter extends Equatable {
  final String name;
  final String apiName;

  const Recruter({
    required this.name,
    required this.apiName,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, apiName];
}

List<Recruter> recrutersList = const [
  Recruter(
      name: "Abu bakr Ash-shaatree", apiName: "Abu_Bakr_Ash-Shaatree_128kbps"),
  Recruter(name: "AlAfasy", apiName: "Alafasy_128kbps"),
  Recruter(name: "AbdulSamad", apiName: "AbdulSamad_64kbps_QuranExplorer.Com"),
];
