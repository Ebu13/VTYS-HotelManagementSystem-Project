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
