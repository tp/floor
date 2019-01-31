import 'package:analyzer/dart/element/element.dart';
import 'package:floor_generator/misc/type_utils.dart';
import 'package:floor_generator/model/entity.dart';
import 'package:floor_generator/model/query_method.dart';
import 'package:source_gen/source_gen.dart';

class Database {
  final ClassElement clazz;

  Database(this.clazz);

  String get name => clazz.displayName;

  List<MethodElement> get methods => clazz.methods;

  List<QueryMethod> get queryMethods {
    return methods
        .where((method) => method.metadata.any(isQueryAnnotation))
        .map((method) => QueryMethod(method))
        .toList();
  }

  List<Entity> getEntities(LibraryReader library) {
    return library.classes
        .where((clazz) =>
            !clazz.isAbstract && clazz.metadata.any(isEntityAnnotation))
        .map((entity) => Entity(entity))
        .toList();
  }
}