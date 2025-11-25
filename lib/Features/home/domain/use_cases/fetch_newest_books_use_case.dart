import 'package:clean_arch_bookly/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:clean_arch_bookly/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>,NoParams>{
final HomeRepo homeRepo;

  FetchNewestBooksUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParams? param]) async{
   return await homeRepo.fetchNewestBooks();
  }
}