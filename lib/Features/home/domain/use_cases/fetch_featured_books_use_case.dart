import 'package:clean_arch_bookly/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase({required this.homeRepo});
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() {
    return homeRepo.fetchFeaturedBooks();
  }
}
