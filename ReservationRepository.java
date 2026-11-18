package com.smartlibrary.repository;

import com.smartlibrary.entity.Reservation;
import com.smartlibrary.enums.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    Optional<Reservation> findByReservationNumber(String reservationNumber);
    List<Reservation> findByMemberIdOrderByReservationDateDesc(Long memberId);
    List<Reservation> findByBookIdOrderByReservationDateDesc(Long bookId);
    List<Reservation> findByStatusOrderByReservationDateAsc(ReservationStatus status);
    List<Reservation> findByBookIdAndStatusOrderByReservationDateAsc(Long bookId, ReservationStatus status);
    Optional<Reservation> findFirstByBookIdAndStatusOrderByReservationDateAsc(Long bookId, ReservationStatus status);
    long countByStatus(ReservationStatus status);
    long countByBookIdAndStatus(Long bookId, ReservationStatus status);
    boolean existsByMemberIdAndBookIdAndStatus(Long memberId, Long bookId, ReservationStatus status);
}
