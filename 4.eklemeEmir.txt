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




-------------------------------------------------------------------------------------


--Otel ekleme 
INSERT INTO Otel (Ad, Adres, Telefon, Email, WebSitesi)
VALUES
    ('Grand Hotel', 'İstanbul, Örnek Cad. No: 123', '555-1234', 'info@grandhotel.com', 'www.grandhotel.com')

-------------------------------------------------------------------------------------

-- Oda Ekleme
INSERT INTO Oda (OtelID, Numara, Tip, Durum, Fiyat, Kapasite, Ozellikler)
VALUES
    (1, 101, 'Standart', 'Boş', 150.00, 2, 'Televizyon, Wi-Fi'),
    (1, 102, 'Deluxe', 'Dolu', 250.00, 3, 'Jakuzi, Deniz Manzarası'),
    (1, 103, 'Suite', 'Boş', 200.00, 2, 'Klima, Mini Bar'),
    (1, 104, 'Standart', 'Dolu', 180.00, 2, 'Televizyon, Balkon'),
    (1, 105, 'Deluxe', 'Boş', 220.00, 3, 'Jakuzi, Deniz Manzarası'),
    (1, 106, 'Suite', 'Boş', 300.00, 4, 'Klima, Mini Bar'),
    (1, 107, 'Standart', 'Boş', 160.00, 2, 'Televizyon, Wi-Fi'),
    (1, 108, 'Deluxe', 'Dolu', 250.00, 3, 'Jakuzi, Deniz Manzarası'),
    (1, 109, 'Suite', 'Boş', 220.00, 2, 'Klima, Mini Bar'),
    (1, 110, 'Standart', 'Boş', 180.00, 2, 'Televizyon, Balkon');

-------------------------------------------------------------------------------------

-- Müşteri Ekleme
INSERT INTO Musteri (Ad, Soyad, TCKimlik, Telefon, Email)
VALUES
    ('Ahmet', 'Yılmaz', '12345678901', '555-1111', 'ahmet@example.com'),
    ('Ayşe', 'Demir', '23456789012', '555-2222', 'ayse@example.com'),
    ('Mehmet', 'Şahin', '34567890123', '555-3333', 'mehmet@example.com'),
    ('Zeynep', 'Yıldız', '45678901234', '555-4444', 'zeynep@example.com'),
    ('Hakan', 'Aydın', '56789012345', '555-5555', 'hakan@example.com'),
    ('Elif', 'Özdemir', '67890123456', '555-6666', 'elif@example.com'),
    ('Gökhan', 'Kaya', '78901234567', '555-7777', 'gokhan@example.com'),
    ('Selin', 'Yılmaz', '89012345678', '555-8888', 'selin@example.com'),
    ('Cem', 'Aydın', '90123456789', '555-9999', 'cem@example.com'),
    ('Aslı', 'Demir', '01234567890', '555-0000', 'asli@example.com');


-------------------------------------------------------------------------------------

-- Rezervasyon Ekleme
INSERT INTO Rezervasyon (MusteriID, OdaID, GirisTarihi, CikisTarihi, Durum, OdemeBilgileri)
VALUES
    (1, 1, '2024-01-10', '2024-01-15', 'Onaylandı', 'Kredi Kartı'),
    (2, 2, '2024-02-05', '2024-02-10', 'Beklemede', NULL),
    (3, 3, '2024-03-20', '2024-03-25', 'Beklemede', NULL),
    (4, 4, '2024-04-15', '2024-04-20', 'Onaylandı', 'Nakit'),
    (5, 5, '2024-05-10', '2024-05-15', 'Onaylandı', 'Kredi Kartı'),
    (6, 6, '2024-06-05', '2024-06-10', 'Beklemede', NULL),
    (7, 7, '2024-07-01', '2024-07-05', 'Onaylandı', 'Havale'),
    (8, 8, '2024-08-18', '2024-08-23', 'Beklemede', NULL),
    (9, 9, '2024-09-12', '2024-09-17', 'Onaylandı', 'Kredi Kartı'),
    (10, 10, '2024-10-08', '2024-10-13', 'Beklemede', NULL);

-------------------------------------------------------------------------------------

-- Fatura Ekleme
INSERT INTO Fatura (MusteriID, OdaID, ToplamFiyat, OdemeDurumu, FaturaTarihi)
VALUES
    (1, 1, 200.00, 'Ödendi', '2024-01-15'),
    (2, 2, 300.00, 'Beklemede', '2024-02-10'),
    (3, 3, 250.00, 'Ödendi', '2024-03-25'),
    (4, 4, 180.00, 'Beklemede', '2024-04-20'),
    (5, 5, 220.00, 'Ödendi', '2024-05-15'),
    (6, 6, 350.00, 'Beklemede', '2024-06-10'),
    (7, 7, 160.00, 'Ödendi', '2024-07-05'),
    (8, 8, 250.00, 'Beklemede', '2024-08-23'),
    (9, 9, 280.00, 'Ödendi', '2024-09-17'),
    (10, 10, 200.00, 'Beklemede', '2024-10-13');

-------------------------------------------------------------------------------------
-- Personel Ekleme
INSERT INTO Personel (Ad, Soyad, Departman, Pozisyon, IseBaslamaTarihi, IzinBilgileri)
VALUES
    ('Ahmet', 'Yılmaz', 'Temizlik', 'Personel', '2020-01-01', 'Yıllık İzin: 14 gün'),
    ('Ayşe', 'Demir', 'Rezervasyon', 'Resepsiyonist', '2019-03-15', 'Yıllık İzin: 21 gün'),
    ('Mehmet', 'Şahin', 'Mutfak', 'Şef', '2018-05-20', 'Yıllık İzin: 28 gün'),
    ('Zeynep', 'Yıldız', 'Temizlik', 'Personel', '2021-02-10', 'Yıllık İzin: 14 gün'),
    ('Hakan', 'Aydın', 'Rezervasyon', 'Resepsiyonist', '2019-11-05', 'Yıllık İzin: 21 gün'),
    ('Elif', 'Özdemir', 'Mutfak', 'Aşçı', '2020-07-18', 'Yıllık İzin: 28 gün'),
    ('Gökhan', 'Kaya', 'Temizlik', 'Personel', '2022-04-03', 'Yıllık İzin: 14 gün'),
    ('Selin', 'Yılmaz', 'Rezervasyon', 'Resepsiyonist', '2021-09-08', 'Yıllık İzin: 21 gün'),
    ('Cem', 'Aydın', 'Mutfak', 'Aşçı', '2023-06-12', 'Yıllık İzin: 28 gün'),
    ('Aslı', 'Demir', 'Rezervasyon', 'Resepsiyonist', '2022-10-20', 'Yıllık İzin: 21 gün');

-------------------------------------------------------------------------------------

-- Menu Ekleme
INSERT INTO Menu(YemekAdi, Fiyat, Aciklama)
VALUES('Izgara Levrek', 50.00, 'Taze deniz levreği ızgara'),
    ('Kuzu Tandır', 40.00, '14 saat fırında pişirilmiş kuzu tandır'),
    ('Mantar Risotto', 30.00, 'Taze mantar ve parmesan peyniri ile yapılan risotto'),
    ('Anadolu Kebabı', 35.00, 'Anadolunun özel baharatlarıyla hazırlanan kebap'),
    ('Deniz Mahsulleri Linguine', 45.00, 'Deniz mahsulleri ve taze otlarla yapılan linguine makarna'),
    ('Sebzeli Quesadilla', 25.00, 'Sebzeli ve peynirli çıtır quesadilla'),
    ('Karides Güveç', 55.00, 'Taze karides, domates ve baharatlarla yapılan güveç'),
    ('Köfte Burger', 20.00, 'Ev yapımı köfte ile hazırlanan burger'),
    ('Tavuk Şinitzel', 30.00, 'Çıtır tavuk şinitzel'),
    ('Meyve Salatası', 15.00, 'Taze meyvelerle hazırlanan hafif salata');


-------------------------------------------------------------------------------------


-- KonferansSalonu Ekleme
INSERT INTO KonferansSalonu (OtelID, SalonAdi, Kapasite, Ucret, Ozellikler)
VALUES
    (1, 'Toplantı Salonu A', 50, 500.00, 'Projeksiyon, Ses Sistemi'),
    (1, 'Toplantı Salonu B', 30, 300.00, 'Whiteboard, Flipchart'),
    (1, 'Konferans Salonu 1', 100, 1000.00, 'Sahne, Ses ve Işık Sistemi'),
    (1, 'Konferans Salonu 2', 80, 800.00, 'Projeksiyon, Ses Sistemi'),
    (1, 'Toplantı Salonu C', 40, 400.00, 'Whiteboard, Flipchart'),
    (1, 'Konferans Salonu 3', 120, 1200.00, 'Sahne, Ses ve Işık Sistemi'),
    (1, 'Toplantı Salonu D', 60, 600.00, 'Projeksiyon, Ses Sistemi'),
    (1, 'Toplantı Salonu E', 25, 250.00, 'Whiteboard, Flipchart'),
    (1, 'Konferans Salonu 4', 150, 1500.00, 'Sahne, Ses ve Işık Sistemi'),
    (1, 'Toplantı Salonu F', 35, 350.00, 'Projeksiyon, Ses Sistemi');



-------------------------------------------------------------------------------------

-- Etkinlik Ekleme
INSERT INTO Etkinlik (OtelID, EtkinlikAdi, TarihSaati, KonferansSalonuID, Katilimcilar)
VALUES
    (1, 'Yoga Dersleri', '2024-01-20 15:00:00', 1, 'Yoga Uzmanı Aysun Yılmaz, Yoga Eğitmeni Burak Demir, Yoga Pratikçisi Elif Kaya'),
    (1, 'Müzik Konseri', '2024-02-10 20:00:00', 3, 'Klasik Müzik Sanatçısı Can Arslan, Caz Piyano Virtüözü Aylin Şahin, Rock Gitaristi Emre Kaya'),
    (1, 'Eğitim Semineri', '2024-03-05 14:30:00', 2, 'İş Geliştirme Uzmanı Prof. Dr. Ahmet Yıldırım, Kariyer Koçu Aslı Demir, Yazar ve Konuşmacı Mehmet Şahin'),
    (1, 'Dans Gösterisi', '2024-04-18 19:00:00', 3, 'Modern Dansçı Zeynep Arslan, Klasik Bale Sanatçısı Deniz Öztürk, Hiphop Dansçısı Cem Aydın'),
    (1, 'Kitap Okuma Günleri', '2024-05-12 17:00:00', 1, 'Roman Yazarı Ayşe Kaya, Şiir Kitabı Yazarı Mehmet Demir, Çocuk Kitapları Yazarı Elif Yılmaz'),
    (1, 'Gastronomi Festivali', '2024-06-25 12:00:00', 3, 'Gastronomi Uzmanı Şef Canan Yılmaz, Gurme Aşçı Mehmet Şahin, Lokanta Sahibi ve Şef Zeynep Demir'),
    (1, 'Teknoloji Sempozyumu', '2024-07-10 10:00:00', 2, 'Bilgisayar Mühendisi Prof. Dr. Hakan Aydın, Yapay Zeka Uzmanı Doç. Dr. Selin Yıldız, Robotik Teknoloji Geliştiricisi Cem Kaya'),
    (1, 'Film Gösterimi', '2024-08-28 18:30:00', 1, 'Yönetmen ve Senarist Can Demir, Başrol Oyuncusu Zeynep Yılmaz, Yardımcı Oyuncu Gökhan Kaya'),
    (1, 'Moda Defilesi', '2024-09-15 21:00:00', 3, 'Moda Tasarımcısı Zehra Özdemir, Manken Aylin Şahin, Manken Cem Aydın'),
    (1, 'Bilim Konferansı', '2024-10-05 11:30:00', 2, 'Fizik Profesörü Prof. Dr. Elif Öz, Biyoloji Uzmanı Prof. Dr. Gökhan Kaya, Kimya Bilimci Doç. Dr. Aslı Demir');

-------------------------------------------------------------------------------------


-- MenuPersonel Ekleme
INSERT INTO MenuPersonel (MenuID, PersonelID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);


-------------------------------------------------------------------------------------
-- OdaDegisiklik Ekleme
INSERT INTO OdaDegisiklik (RezervasyonID, YeniOdaID, TalepTarihi, Durum)
VALUES
    (1, 2, '2024-01-11', 'Beklemede'),
    (2, 3, '2024-02-06', 'Onaylandı'),
    (3, 4, '2024-03-21', 'Beklemede'),
    (4, 5, '2024-04-16', 'Onaylandı'),
    (5, 6, '2024-05-11', 'Onaylandı'),
    (6, 7, '2024-06-06', 'Beklemede'),
    (7, 8, '2024-07-02', 'Onaylandı'),
    (8, 9, '2024-08-19', 'Beklemede'),
    (9, 10, '2024-09-13', 'Beklemede'),
    (10, 1, '2024-10-09', 'Onaylandı');


-------------------------------------------------------------------------------------
-- OdaTemizlikTakip Ekleme
INSERT INTO OdaTemizlikTakip (OdaID, TemizlikTarihi, TemizlikPersoneliID)
VALUES
    (1, '2024-01-12', 1),
    (2, '2024-02-07', 2),
    (3, '2024-03-22', 3),
    (4, '2024-04-17', 4),
    (5, '2024-05-12', 5),
    (6, '2024-06-07', 6),
    (7, '2024-07-03', 7),
    (8, '2024-08-20', 8),
    (9, '2024-09-14', 9),
    (10, '2024-10-10', 10);

-------------------------------------------------------------------------------------


-- Rapor Ekleme
INSERT INTO Rapor (OtelID, Tur, TarihAraligi, IlgiliVeriler)
VALUES
    (1, 'Finansal', '2024-01-01 - 2024-01-31', 'Gelir: 50000.00, Gider: 30000.00, Kar: 20000.00'),
    (1, 'Personel', '2024-02-01 - 2024-02-29', 'Toplam Personel Sayısı: 20, Yıllık İzin Günleri: 120'),
    (1, 'Müşteri Memnuniyeti', '2024-03-01 - 2024-03-31', 'Memnuniyet Oranı: %90, Yapılan Anket Sayısı: 100'),
    (1, 'Oda Doluluk Oranı', '2024-04-01 - 2024-04-30', 'Ortalama Doluluk: %80, En Yüksek Doluluk: %90'),
    (1, 'Etkinlik Katılım', '2024-05-01 - 2024-05-31', 'Toplam Katılımcı Sayısı: 500, En Fazla Katılım: 150'),
    (1, 'Restoran Satış', '2024-06-01 - 2024-06-30', 'Toplam Satış: 25000.00, En Çok Satılan Yemek: Izgara Levrek'),
    (1, 'Sikayetler', '2024-07-01 - 2024-07-31', 'Toplam Şikayet Sayısı: 5, En Sık Karşılaşılan Konu: Temizlik'),
    (1, 'Oda Değişiklik Talepleri', '2024-08-01 - 2024-08-31', 'Toplam Talep Sayısı: 3, Onaylanan Talep Sayısı: 2'),
    (1, 'Oda Temizlik İstatistikleri', '2024-09-01 - 2024-09-30', 'Ortalama Temizlik Süresi: 45 dakika, En Hızlı Temizlik: 30 dakika'),
    (1, 'Genel Değerlendirme', '2024-10-01 - 2024-10-31', 'Genel Memnuniyet Oranı: %95, Öneri Sayısı: 10');


-------------------------------------------------------------------------------------
-- Restoran Ekleme
INSERT INTO Restoran (OtelID, RestoranAdi, MasaNumaralari, MenuID, CalisanID)
VALUES
    (1, 'Deniz Manzaralı Restoran', '101,102,103,104,105', 1, 3),
    (1, 'Akdeniz Lezzetleri', '201,202,203,204,205', 2, 6),
    (1, 'Gurme Köşesi', '301,302,303,304,305', 3, 9),
    (1, 'Tatlı Dünya', '401,402,403,404,405', 4, 3),
    (1, 'Fast Food Plaza', '501,502,503,504,505', 5, 6),
    (1, 'Vejetaryen Şölen', '601,602,603,604,605', 6, 9),
    (1, 'Şefin Önerileri', '701,702,703,704,705', 7, 3),
    (1, 'Uzak Doğu Mutfağı', '801,802,803,804,805', 8, 6),
    (1, 'Organik Lezzetler', '901,902,903,904,905', 9, 9),
    (1, 'Kahvaltı Bahçesi', '1001,1002,1003,1004,1005', 10, 3);

-------------------------------------------------------------------------------------
-- Sikayet Ekleme
INSERT INTO Sikayet (OtelID, MusteriID, Konu, Aciklama)
VALUES
    (1, 1, 'Oda Temizliği', 'Odamızın temizliği yeterli değil.'),
    (1, 2, 'Restoran Hizmeti', 'Yemek servisi çok yavaş.'),
    (1, 3, 'Personel İlgisi', 'Resepsiyon personeli ilgisiz.'),
    (1, 4, 'Oda Konforu', 'Oda mobilyaları eski ve konforlu değil.'),
    (1, 5, 'Etkinlik Organizasyonu', 'Etkinlik düzenlemesi zayıf.'),
    (1, 6, 'Restoran Menüsü', 'Menü çeşitliliği yetersiz.'),
    (1, 7, 'Personel Temizlik', 'Personel odamızı temizlemedi.');


