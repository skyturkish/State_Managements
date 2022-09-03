import 'package:flutter/foundation.dart' show immutable;
import 'package:testingbloc_course/bloc/person.dart';

const persons1Url = 'http://192.168.0.29:5500/learn/testingbloc_course/api/person1.json';
const persons2Url = 'http://192.168.0.29:5500/learn/testingbloc_course/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}

// enum PersonUrl {
//   person1('http://192.168.0.29:5500/learn/testingbloc_course/api/person1.json'), // TODO ip'ini commit atmadan önce sil
//   person2('http://192.168.0.29:5500/learn/testingbloc_course/api/person2.json');

//   final String personUrl;
//   const PersonUrl(this.personUrl);

//   String getPersonUrl() {
//     return personUrl;
//   }
// }
