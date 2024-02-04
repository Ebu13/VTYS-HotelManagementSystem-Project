--create database otelmanage;


-- Otel Tablosu
CREATE TABLE Otel (
    OtelID SERIAL PRIMARY KEY,
    Ad VARCHAR(255),
    Adres VARCHAR(255),
    Telefon VARCHAR(15),
    Email VARCHAR(255),
    WebSitesi VARCHAR(255)
);

-- Oda Tablosu
CREATE TABLE Oda (
    OdaID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    Numara INT,
    Tip VARCHAR(50),
    Durum VARCHAR(50),
    Fiyat DECIMAL(10, 2),
    Kapasite INT,
    Ozellikler TEXT
);

-- Müşteri Tablosu
CREATE TABLE Musteri (
    MusteriID SERIAL PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    TCKimlik VARCHAR(11),
    Telefon VARCHAR(15),
    Email VARCHAR(255)
);

-- Rezervasyon Tablosu
CREATE TABLE Rezervasyon (
    RezervasyonID SERIAL PRIMARY KEY,
    MusteriID INT REFERENCES Musteri(MusteriID),
    OdaID INT REFERENCES Oda(OdaID),
    GirisTarihi DATE,
    CikisTarihi DATE,
    Durum VARCHAR(50),
    OdemeBilgileri TEXT
);

-- Fatura Tablosu
CREATE TABLE Fatura (
    FaturaID SERIAL PRIMARY KEY,
    MusteriID INT REFERENCES Musteri(MusteriID),
    OdaID INT REFERENCES Oda(OdaID),
    ToplamFiyat DECIMAL(10, 2),
    OdemeDurumu VARCHAR(50),
    FaturaTarihi DATE
);

-- Personel Tablosu
CREATE TABLE Personel (
    PersonelID SERIAL PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Departman VARCHAR(50),
    Pozisyon VARCHAR(50),
    IseBaslamaTarihi DATE,
    IzinBilgileri TEXT
);

-- Menu Tablosu
CREATE TABLE Menu (
    MenuID SERIAL PRIMARY KEY,
    YemekAdi VARCHAR(255),
    Fiyat DECIMAL(10, 2),
    Aciklama TEXT
);

-- Restoran Tablosu
CREATE TABLE Restoran (
    RestoranID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    RestoranAdi VARCHAR(255),
    MasaNumaralari TEXT,
    MenuID INT REFERENCES Menu(MenuID),
    CalisanID INT REFERENCES Personel(PersonelID)
);

-- KonferansSalonu Tablosu
CREATE TABLE KonferansSalonu (
    SalonID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    SalonAdi VARCHAR(255),
    Kapasite INT,
    Ucret DECIMAL(10, 2),
    Ozellikler TEXT
);

-- Etkinlik Tablosu
CREATE TABLE Etkinlik (
    EtkinlikID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    EtkinlikAdi VARCHAR(255),
    TarihSaati TIMESTAMP,
    KonferansSalonuID INT REFERENCES KonferansSalonu(SalonID),
    Katilimcilar TEXT
);


-- Rapor Tablosu
CREATE TABLE Rapor (
    RaporID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    Tur VARCHAR(50),
    TarihAraligi VARCHAR(50),
    IlgiliVeriler TEXT
);

-- MenuPersonel Tablosu
CREATE TABLE MenuPersonel (
    MenuPersonelID SERIAL PRIMARY KEY,
    MenuID INT REFERENCES Menu(MenuID),
    PersonelID INT REFERENCES Personel(PersonelID)
);

-- Sikayet Tablosu
CREATE TABLE Sikayet (
    SikayetID SERIAL PRIMARY KEY,
    OtelID INT REFERENCES Otel(OtelID),
    MusteriID INT REFERENCES Musteri(MusteriID),
    Konu VARCHAR(255),
    Aciklama TEXT
);



-- OdaTemizlikTakip Tablosu
CREATE TABLE OdaTemizlikTakip (
    TemizlikID SERIAL PRIMARY KEY,
    OdaID INT REFERENCES Oda(OdaID),
    TemizlikTarihi DATE,
    TemizlikPersoneliID INT REFERENCES Personel(PersonelID)
);


-- OdaDegisiklik Tablosu
CREATE TABLE OdaDegisiklik (
    DegisiklikID SERIAL PRIMARY KEY,
    RezervasyonID INT REFERENCES Rezervasyon(RezervasyonID),
    YeniOdaID INT REFERENCES Oda(OdaID),
    TalepTarihi DATE,
    Durum VARCHAR(50)
);

-----------------------------------------------------------------------------------


-- Otel tablosuna veri ekleme
INSERT INTO Otel (OtelID, Ad, Adres, Telefon, Email, WebSitesi) 
VALUES 
    (1, 'Örnek Otel 1', 'Adres 1', '555-1234', 'otel1@example.com', 'www.otel1.com');

-- Oda tablosuna veri ekleme
INSERT INTO Oda (OdaID, OtelID, Numara, Tip, Durum, Fiyat, Kapasite, Ozellikler) 
VALUES 
    (1, 1, 101, 'Standart', 'Boş', 150.00, 2, 'Televizyon, Wi-Fi'),
    (2, 1, 102, 'Suit', 'Dolu', 300.00, 4, 'Jakuzi, Mini Bar'),
    (3, 1, 201, 'Standart', 'Boş', 120.00, 2, 'Klima, Balkon'),
    (4, 1, 301, 'Suit', 'Dolu', 350.00, 3, 'Sauna, Deniz Manzarası'),
    (5, 1, 401, 'Standart', 'Boş', 130.00, 2, 'Mutfak, Çamaşır Makinesi');

-- Müşteri tablosuna veri ekleme
INSERT INTO Musteri (MusteriID, Ad, Soyad, TCKimlik, Telefon, Email) 
VALUES 
    (1, 'Ahmet', 'Yılmaz', '12345678901', '555-1111', 'ahmet@example.com'),
    (2, 'Ayşe', 'Demir', '23456789012', '555-2222', 'ayse@example.com'),
    (3, 'Mehmet', 'Kaya', '34567890123', '555-3333', 'mehmet@example.com'),
    (4, 'Fatma', 'Çelik', '45678901234', '555-4444', 'fatma@example.com'),
    (5, 'Mustafa', 'Toprak', '56789012345', '555-5555', 'mustafa@example.com');  


-- Rezervasyon tablosuna veri ekleme
INSERT INTO Rezervasyon (RezervasyonID, MusteriID, OdaID, GirisTarihi, CikisTarihi, Durum, OdemeBilgileri) 
VALUES 
    (1, 1, 1, '2023-01-01', '2023-01-05', 'Aktif', 'Kredi Kartı: XXXX-XXXX-XXXX-1234'),
    (2, 2, 3, '2023-02-10', '2023-02-15', 'Aktif', 'Nakit Ödeme'),
    (3, 3, 2, '2023-03-20', '2023-03-25', 'Beklemede', 'Havale: ABC Bankası, Hesap: 12345'),
    (4, 4,  4, '2023-04-05', '2023-04-10', 'Aktif', 'Kredi Kartı: XXXX-XXXX-XXXX-5678'),
    (5, 5, 5, '2023-05-15', '2023-05-20', 'Pasif', 'Havale: XYZ Bankası, Hesap: 67890');

-- Fatura tablosuna veri ekleme
INSERT INTO Fatura (MusteriID, OdaID, ToplamFiyat, OdemeDurumu, FaturaTarihi) 
VALUES 
    (1, 1, 150.00, 'Ödendi', '2023-01-05'),
    (2, 3, 300.00, 'Beklemede', '2023-02-15'),
    (3, 2, 120.00, 'Ödendi', '2023-03-25'),
    (4, 4, 350.00, 'Ödendi', '2023-04-10'),
    (5, 5, 130.00, 'Beklemede', '2023-05-20');

-- Personel tablosuna veri ekleme
INSERT INTO Personel (PersonelID, Ad, Soyad, Departman, Pozisyon, IseBaslamaTarihi, IzinBilgileri) 
VALUES 
    (1, 'Ahmet', 'Çelik', 'Mutfak', 'Şef', '2022-01-15', 'Yıllık izin: 20 gün'),
    (2, 'Ayşe', 'Yılmaz', 'Temizlik', 'Temizlik Görevlisi', '2022-02-20', 'Yıllık izin: 15 gün'),
    (3, 'Mehmet', 'Demir', 'Rezervasyon', 'Resepsiyonist', '2022-03-10', 'Yıllık izin: 18 gün'),
    (4, 'Fatma', 'Kaya', 'Restoran', 'Garson', '2022-04-05', 'Yıllık izin: 22 gün'),
    (5, 'Mustafa', 'Toprak', 'Yönetim', 'Genel Müdür', '2022-05-12', 'Yıllık izin: 25 gün');

-- Menu tablosuna veri ekleme
INSERT INTO Menu (MenuID, YemekAdi, Fiyat, Aciklama) 
VALUES 
    (1, 'Izgara Levrek', 45.00, 'Taze levrek ızgara servis edilir.'),
    (2, 'Mantar Sote', 25.00, 'Karışık mantarlarla hazırlanan lezzetli bir sote.'),
    (3, 'Kuzu Tandır', 60.00, 'Yavaşça pişirilmiş kuzu tandır servis edilir.'),
    (4, 'Mevsim Salatası', 18.00, 'Taze mevsim sebzeleri ile hazırlanan sağlıklı bir salata.'),
    (5, 'Çikolatalı Soufflé', 30.00, 'Çikolata dolgulu soufflé, vanilya sos ile servis edilir.');

-- Restoran tablosuna veri ekleme
INSERT INTO Restoran (OtelID, RestoranAdi, MasaNumaralari, MenuID) 
VALUES 
    (1, 'Deniz Manzaralı Restoran', '1,2,3,4,5', 1),
    (1, 'Bahçe Restoranı', '6,7,8,9,10', 2),
    (1, 'Panorama Lounge', '11,12,13,14,15', 3),
    (1, 'Skyline Bistro', '16,17,18,19,20', 4),
    (1, 'Havuz Kenarı Cafe', '21,22,23,24,25', 5);

-- KonferansSalonu tablosuna veri ekleme
INSERT INTO KonferansSalonu (SalonID, OtelID, SalonAdi, Kapasite, Ucret, Ozellikler) 
VALUES 
    (1, 1, 'Toplantı Salonu A', 50, 500.00, 'Projeksiyon, Ses Sistemi'),
    (2, 1, 'Konferans Salonu B', 100, 800.00, 'Interaktif tahta, Wi-Fi'),
    (3, 1, 'Seminer Salonu C', 30, 400.00, 'Kablosuz mikrofon, Klima'),
    (4, 1, 'Eğitim Salonu D', 80, 600.00, 'Akustik düzenleme, Kahve Makinesi'),
    (5 ,1, 'Sosyal Etkinlik Salonu E', 120, 1000.00, 'Dj sistemi, Işıklandırma');

-- Etkinlik tablosuna veri ekleme
INSERT INTO Etkinlik (OtelID, EtkinlikAdi, TarihSaati, KonferansSalonuID, Katilimcilar) 
VALUES 
    (1, 'Yönetim Toplantısı', '2023-01-10 14:00:00', 1, 'Yönetim Kadrosu'),
    (1, 'Teknoloji Konferansı', '2023-02-20 10:00:00', 2, 'Teknoloji Uzmanları'),
    (1, 'Müzik Konseri', '2023-03-15 20:00:00', 5, 'Genel Katılım'),
    (1, 'Eğitim Semineri', '2023-04-05 09:30:00', 4, 'Eğitim Personeli'),
    (1, 'Sanat Sergisi', '2023-05-25 18:00:00', 3, 'Sanatseverler');

-- Rapor tablosuna veri ekleme
INSERT INTO Rapor (OtelID, Tur, TarihAraligi, IlgiliVeriler) 
VALUES 
    (1, 'Finansal Rapor', '2023-01-01 - 2023-01-31', 'Gelir: 100,000 TL, Gider: 80,000 TL'),
    (1, 'Personel İzin Raporu', '2023-02-01 - 2023-02-28', 'Toplam İzin Günleri: 150 gün'),
    (1, 'Yemek Satış Raporu', '2023-03-01 - 2023-03-31', 'En Çok Satılan Yemek: Izgara Levrek'),
    (1, 'Oda Doluluk Raporu', '2023-04-01 - 2023-04-30', 'Doluluk Oranı: %80'),
    (1, 'Etkinlik Katılımcı Raporu', '2023-05-01 - 2023-05-31', 'Toplam Katılımcı Sayısı: 500');

-- MenuPersonel tablosuna veri ekleme
INSERT INTO MenuPersonel (MenuID, PersonelID) 
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);
-- Sikayet tablosuna veri ekleme
INSERT INTO Sikayet (OtelID, MusteriID, Konu, Aciklama) 
VALUES 
    (1, 1, 'Oda Temizliği', 'Odamın temizliği yetersizdi.'),
    (1, 2, 'Personel Davranışı', 'Restoran çalışanları ilgisizdi.'),
    (1, 3, 'Gürültü Problemi', 'Gece saatlerinde çok fazla gürültü vardı.'),
    (1, 4, 'Oda Konforu', 'Yatağımın rahatlığı yeterli değildi.'),
    (1, 5, 'Otopark Sorunu', 'Otopark yerleri yetersizdi.');

-- OdaTemizlikTakip tablosuna veri ekleme
INSERT INTO OdaTemizlikTakip (OdaID, TemizlikTarihi, TemizlikPersoneliID) 
VALUES 
    (1, '2023-01-02', 2),
    (2, '2023-02-15', 3),
    (3, '2023-03-20', 1),
    (4, '2023-04-10', 4),
    (5, '2023-05-25', 5);

-- OdaDegisiklik tablosuna veri ekleme
INSERT INTO OdaDegisiklik (RezervasyonID, YeniOdaID, TalepTarihi, Durum) 
VALUES 
    (1, 2, '2023-01-05', 'Onaylandı'),
    (2, 4, '2023-02-20', 'Beklemede'),
    (3, 1, '2023-03-25', 'Onaylandı'),
    (4, 3, '2023-04-10', 'Reddedildi'),
    (5, 5, '2023-05-20', 'Onaylandı');

------------------------------------------------------------------------

-- Toplam Rezervasyon Sayısı
SELECT COUNT(*) AS ToplamRezervasyonSayisi FROM Rezervasyon;

-- Tüm müşterilerin yaptığı rezervasyonların detayları
SELECT R.*, O.Ad AS OtelAdi, Oda.Numara AS OdaNumarasi, Oda.Tip AS OdaTipi
FROM Rezervasyon R
JOIN Oda ON R.OdaID = Oda.OdaID
JOIN Otel O ON Oda.OtelID = O.OtelID

-- Belirli bir tarih aralığındaki rezervasyonlar
SELECT * FROM Rezervasyon WHERE GirisTarihi BETWEEN '2023-01-01' AND '2023-02-01';

-- Beklemede olan rezervasyonlar ve ilgili müşteri bilgileri
SELECT R.*, M.*
FROM Rezervasyon R
JOIN Musteri M ON R.MusteriID = M.MusteriID
WHERE R.Durum = 'Beklemede';

-- Toplam Oda Sayısı, Dolu Oda Sayısı ve Doluluk Oranı
SELECT COUNT(*) AS ToplamOdaSayisi, 
       (SELECT COUNT(*) FROM Rezervasyon WHERE Durum = 'Aktif') AS DoluOdaSayisi,
       (SELECT COUNT(*) FROM Rezervasyon WHERE Durum = 'Aktif') / COUNT(*) * 100 AS DolulukOrani
FROM Oda;

-- Toplam Müşteri Sayısı
SELECT COUNT(*) AS ToplamMusteriSayisi FROM Musteri;

-- Belirli bir müşterinin yaptığı şikayetler
SELECT S.*, O.Ad AS OtelAdi
FROM Sikayet S
JOIN Otel O ON S.OtelID = O.OtelID
WHERE S.MusteriID = 1;

-- Belirli bir personelin çalıştığı departmandaki toplam personel sayısı
SELECT COUNT(*) AS ToplamPersonelSayisi
FROM Personel
WHERE Departman = 'Mutfak';

-- Belirli bir etkinlik için katılımcı sayısı ve katılımcılar
SELECT
    E.EtkinlikAdi,
    COUNT(*) AS KatilimciSayisi,
    STRING_AGG(M.Ad || ' ' || M.Soyad, ', ') AS Katilimcilar
FROM
    Etkinlik E
JOIN
    Rezervasyon R ON E.OtelID = R.OdaID -- Eğer OdaID kullanılıyorsa, bu kısmı doğrulayın
JOIN
    Musteri M ON R.MusteriID = M.MusteriID
GROUP BY
    E.EtkinlikAdi, E.Katilimcilar;


