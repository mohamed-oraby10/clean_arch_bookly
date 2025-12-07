import 'package:clean_arch_bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_arch_bookly/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly/constants.dart';
import 'package:clean_arch_bookly/core/utils/api_service.dart';
import 'package:clean_arch_bookly/core/utils/functions/save_books.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber=0});
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiService.get(
      endPoint: 'volumes?Filtering-free-ebooks&q=Programming&startIndex=${pageNumber * 10}',
    );
    List<BookEntity> featuredBooks = getBooksList(data);
    saveBooks(featuredBooks, kFeaturedBox);
    return featuredBooks;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiService.get(
      endPoint: 'volumes?Filtering-free-ebooks&Sorting=newest&q=Programming',
    );
    List<BookEntity> newestBooks = getBooksList(data);
    saveBooks(newestBooks, kNewestBox);
    return newestBooks;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var book in data['items']) {
      books.add(BookModel.fromJson(book));
    }
    return books;
  }
}
