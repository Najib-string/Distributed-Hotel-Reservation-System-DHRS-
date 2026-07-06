-- 1. Data lokal Jakarta
SELECT * FROM hotel;

-- 2. FDW Surabaya
SELECT * FROM hotel_surabaya;

-- 3. FDW Makassar
SELECT * FROM hotel_makassar;

-- 4. Global View
SELECT * FROM hotel_nasional;

-- 5. Booking berhasil
SELECT booking_kamar(2,2,'2026-08-01','2026-08-03');

-- 6. Lihat reservasi nasional
SELECT * FROM reservasi_nasional;

-- 7. Booking gagal (double booking)
SELECT booking_kamar(3,2,'2026-08-02','2026-08-04');