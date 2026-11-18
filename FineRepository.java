package com.smartlibrary.repository;

import com.smartlibrary.entity.Fine;
import com.smartlibrary.enums.FineStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long> {
    Optional<Fine> findByFineNumber(String fineNumber);
    List<Fine> findByMemberIdOrderByFineDateDesc(Long memberId);
    Optional<Fine> findByLoanId(Long loanId);
    List<Fine> findByStatus(FineStatus status);

    @Query("SELECT f FROM Fine f WHERE f.member.id = :memberId AND (f.status = 'UNPAID' OR f.status = 'PARTIALLY_PAID')")
    List<Fine> findUnpaidFinesByMemberId(@Param("memberId") Long memberId);

    @Query("SELECT COALESCE(SUM(f.amount - f.paidAmount), 0) FROM Fine f WHERE f.status = 'UNPAID' OR f.status = 'PARTIALLY_PAID'")
    BigDecimal sumTotalOutstandingFines();

    @Query("SELECT COALESCE(SUM(f.paidAmount), 0) FROM Fine f")
    BigDecimal sumTotalCollectedFines();

    @Query("SELECT COALESCE(SUM(f.amount - f.paidAmount), 0) FROM Fine f WHERE f.member.id = :memberId AND (f.status = 'UNPAID' OR f.status = 'PARTIALLY_PAID')")
    BigDecimal sumOutstandingFinesByMemberId(@Param("memberId") Long memberId);
}
