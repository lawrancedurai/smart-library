package com.smartlibrary.repository;

import com.smartlibrary.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    Optional<Book> findByIsbn(String isbn);
    boolean existsByIsbn(String isbn);
    List<Book> findByCategory(String category);

    @Query("SELECT DISTINCT b.category FROM Book b WHERE b.category IS NOT NULL ORDER BY b.category ASC")
    List<String> findDistinctCategories();

    @Query("SELECT b FROM Book b WHERE " +
           "(:query IS NULL OR :query = '' OR " +
           " LOWER(b.title) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           " LOWER(b.author) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           " LOWER(b.isbn) LIKE LOWER(CONCAT('%', :query, '%'))) AND " +
           "(:category IS NULL OR :category = '' OR LOWER(b.category) = LOWER(:category))")
    List<Book> searchBooks(@Param("query") String query, @Param("category") String category);

    @Query("SELECT COALESCE(SUM(b.totalCopies), 0) FROM Book b")
    long sumTotalCopies();

    @Query("SELECT COALESCE(SUM(b.availableCopies), 0) FROM Book b")
    long sumAvailableCopies();
}
