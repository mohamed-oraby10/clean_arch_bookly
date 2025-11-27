import 'package:clean_arch_bookly/Features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

void saveBooks(List<BookEntity> books, String boxsName) {
  var box = Hive.box(boxsName);
  box.addAll(books);
}
