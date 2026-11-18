package com.smartlibrary.repository;

import com.smartlibrary.entity.BookCopy;
import com.smartlibrary.enums.CopyStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookCopyRepository extends JpaRepository<BookCopy, Long> {
    List<BookCopy> findByBookId(Long bookId);
    Optional<BookCopy> findByCopyBarcode(String copyBarcode);
    Optional<BookCopy> findFirstByBookIdAndStatus(Long bookId, CopyStatus status);
    long countByBookIdAndStatus(Long bookId, CopyStatus status);
}
