python -m streamlit run app.py

docker exec -it pg-jakarta psql -U admin -d db_jakarta

docker exec -it pg-surabaya psql -U admin -d db_surabaya

docker exec -it pg-makassar psql -U admin -d db_makassar

SELECT * FROM hotel_nasional;

SELECT * FROM kamar_nasional;

SELECT booking_kamar(
2,
'SBY02',
'2026-10-05',
'2026-10-07'
);

SELECT booking_kamar(
3,
'MKS01',
'2026-10-10',
'2026-10-12'
);


-- 1. Data lokal 
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