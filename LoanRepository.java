package com.smartlibrary.repository;

import com.smartlibrary.entity.Loan;
import com.smartlibrary.enums.LoanStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface LoanRepository extends JpaRepository<Loan, Long> {
    Optional<Loan> findByLoanNumber(String loanNumber);
    List<Loan> findByMemberIdOrderByBorrowDateDesc(Long memberId);
    List<Loan> findByBookIdOrderByBorrowDateDesc(Long bookId);
    List<Loan> findByStatusOrderByBorrowDateDesc(LoanStatus status);
    List<Loan> findByMemberIdAndStatus(Long memberId, LoanStatus status);
    long countByMemberIdAndStatus(Long memberId, LoanStatus status);
    long countByStatus(LoanStatus status);

    @Query("SELECT l FROM Loan l WHERE l.status = 'ISSUED' AND l.dueDate < :today ORDER BY l.dueDate ASC")
    List<Loan> findActiveOverdueLoans(@Param("today") LocalDate today);

    @Query("SELECT l FROM Loan l WHERE " +
           "(:status IS NULL OR l.status = :status) AND " +
           "(:startDate IS NULL OR l.borrowDate >= :startDate) AND " +
           "(:endDate IS NULL OR l.borrowDate <= :endDate) " +
           "ORDER BY l.borrowDate DESC")
    List<Loan> filterLoans(@Param("status") LoanStatus status,
                           @Param("startDate") LocalDate startDate,
                           @Param("endDate") LocalDate endDate);

    @Query("SELECT l.book.id, l.book.title, l.book.author, l.book.isbn, COUNT(l) " +
           "FROM Loan l GROUP BY l.book.id, l.book.title, l.book.author, l.book.isbn " +
           "ORDER BY COUNT(l) DESC")
    List<Object[]> findMostBorrowedBooksRaw();
}
