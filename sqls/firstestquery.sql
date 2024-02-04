--create database otelmanage;

--use otelmanage;
-- Otel Tablosu
CREATE TABLE Otel (
    OtelID INT PRIMARY KEY,
    Ad NVARCHAR(255),
    Adres NVARCHAR(255),
    Telefon NVARCHAR(15),
    Email NVARCHAR(255),
    WebSitesi NVARCHAR(255)
);

-- Oda Tablosu
CREATE TABLE Oda (
    OdaID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    Numara INT,
    Tip NVARCHAR(50),
    Durum NVARCHAR(50),
    Fiyat DECIMAL(10, 2),
    Kapasite INT,
    Ozellikler NVARCHAR(MAX)
);

-- Müþteri Tablosu
CREATE TABLE Musteri (
    MusteriID INT PRIMARY KEY,
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    TCKimlik NVARCHAR(11),
    Telefon NVARCHAR(15),
    Email NVARCHAR(255)
);

-- Rezervasyon Tablosu
CREATE TABLE Rezervasyon (
    RezervasyonID INT PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteri(MusteriID),
    OdaID INT FOREIGN KEY REFERENCES Oda(OdaID),
    GirisTarihi DATE,
    CikisTarihi DATE,
    Durum NVARCHAR(50),
    OdemeBilgileri NVARCHAR(MAX)
);

-- Fatura Tablosu
CREATE TABLE Fatura (
    FaturaID INT PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteri(MusteriID),
    OdaID INT FOREIGN KEY REFERENCES Oda(OdaID),
    ToplamFiyat DECIMAL(10, 2),
    OdemeDurumu NVARCHAR(50),
    FaturaTarihi DATE
);

-- Personel Tablosu
CREATE TABLE Personel (
    PersonelID INT PRIMARY KEY,
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    Departman NVARCHAR(50),
    Pozisyon NVARCHAR(50),
    IseBaslamaTarihi DATE,
    IzinBilgileri NVARCHAR(MAX)
);

-- Menu Tablosu
CREATE TABLE Menu (
    MenuID INT PRIMARY KEY,
    YemekAdi NVARCHAR(255),
    Fiyat DECIMAL(10, 2),
    Aciklama NVARCHAR(MAX)
);

-- Restoran Tablosu
CREATE TABLE Restoran (
    RestoranID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    RestoranAdi NVARCHAR(255),
    MasaNumaralari NVARCHAR(MAX),
    MenuID INT FOREIGN KEY REFERENCES Menu(MenuID),
    CalisanID INT FOREIGN KEY REFERENCES Personel(PersonelID)
);

-- KonferansSalonu Tablosu
CREATE TABLE KonferansSalonu (
    SalonID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    SalonAdi NVARCHAR(255),
    Kapasite INT,
    Ucret DECIMAL(10, 2),
    Ozellikler NVARCHAR(MAX)
);

-- Etkinlik Tablosu
CREATE TABLE Etkinlik (
    EtkinlikID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    EtkinlikAdi NVARCHAR(255),
    TarihSaati DATETIME,
    KonferansSalonuID INT FOREIGN KEY REFERENCES KonferansSalonu(SalonID),
    Katilimcilar NVARCHAR(MAX)
);

-- Güvenlik Tablosu
CREATE TABLE Guvenlik (
    KameraID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    Konum NVARCHAR(255),
    KayitTarihiSaati DATETIME,
    AcilDurumPlanlari NVARCHAR(MAX)
);

-- Raporlar Tablosu
CREATE TABLE Raporlar (
    RaporID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    Tur NVARCHAR(50),
    TarihAraligi NVARCHAR(50),
    IlgiliVeriler NVARCHAR(MAX)
);


-- MenuPersonel Tablosu
CREATE TABLE MenuPersonel (
    MenuPersonelID INT PRIMARY KEY,
    MenuID INT FOREIGN KEY REFERENCES Menu(MenuID),
    PersonelID INT FOREIGN KEY REFERENCES Personel(PersonelID)
);

-- MusteriSikayet Tablosu
CREATE TABLE MusteriSikayet (
    SikayetID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    MusteriID INT FOREIGN KEY REFERENCES Musteri(MusteriID),
    Konu NVARCHAR(255),
    Aciklama NVARCHAR(MAX)
);

-- IndirimKampanya Tablosu
CREATE TABLE IndirimKampanya (
    IndirimID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    IndirimAdi NVARCHAR(255),
    IndirimOrani DECIMAL(5, 2),
    BaslangicTarihi DATE,
    BitisTarihi DATE
);

-- MusteriOylama Tablosu
CREATE TABLE MusteriOylama (
    OylamaID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    MusteriID INT FOREIGN KEY REFERENCES Musteri(MusteriID),
    Puan INT,
    Yorum NVARCHAR(MAX)
);

-- OtelEgitim Tablosu
CREATE TABLE OtelEgitim (
    EgitimID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    PersonelID INT FOREIGN KEY REFERENCES Personel(PersonelID),
    EgitimAdi NVARCHAR(255),
    BaslangicTarihi DATE,
    BitisTarihi DATE
);

-- OtelImkanlari Tablosu
CREATE TABLE OtelImkanlari (
    ImkanID INT PRIMARY KEY,
    OtelID INT FOREIGN KEY REFERENCES Otel(OtelID),
    ImkanAdi NVARCHAR(255),
    Aciklama NVARCHAR(MAX)
);

-- OdaTemizlikTakip Tablosu
CREATE TABLE OdaTemizlikTakip (
    TemizlikID INT PRIMARY KEY,
    OdaID INT FOREIGN KEY REFERENCES Oda(OdaID),
    TemizlikTarihi DATE,
    TemizlikPersoneliID INT FOREIGN KEY REFERENCES Personel(PersonelID)
);

-- YemekSiparisi Tablosu
CREATE TABLE YemekSiparisi (
    SiparisID INT PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteri(MusteriID),
    MenuID INT FOREIGN KEY REFERENCES Menu(MenuID),
    TarihSaati DATETIME,
    Durum NVARCHAR(50)
);

-- OdaDegisiklik Tablosu

CREATE TABLE OdaDegisiklik (
    DegisiklikID INT PRIMARY KEY,
    RezervasyonID INT FOREIGN KEY REFERENCES Rezervasyon(RezervasyonID),
    YeniOdaID INT FOREIGN KEY REFERENCES Oda(OdaID),
    TalepTarihi DATE,
    Durum NVARCHAR(50)
);
