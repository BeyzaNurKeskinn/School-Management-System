
CREATE TABLE Ders(
	DersId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifId int FOREIGN KEY(SinifId) REFERENCES Sinif (SinifId) NULL,
    DersIsmi varchar(50) NULL)

CREATE TABLE DersGideri(
	DersGideriId int IDENTITY(1,1) PRIMARY KEY NOT NULL ,
	SinifId int FOREIGN KEY(SinifId) REFERENCES Sinif (SinifId) NULL,
	DersId int FOREIGN KEY(DersId) REFERENCES Ders (DersId) NULL,
	UcretTutari int NULL)

CREATE TABLE DersOgretmeni(
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifId int FOREIGN KEY(SinifId)REFERENCES Sinif (SinifId) NULL,
	DersId int FOREIGN KEY(DersId) REFERENCES Ders (DersId) NULL,
	OgretmenId int FOREIGN KEY(OgretmenId) REFERENCES Ogretmen (OgretmenId) NULL)

CREATE TABLE Ogrenci(
	OgrenciId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Isim varchar(50) NULL,
	DOB date NULL,
	Cinsiyet varchar(1) NULL,
	Telefon varchar(11) NULL,
	OkulNo varchar(50) NULL,
	Adres varchar(max) NULL,
	SinifId int FOREIGN KEY(SinifId) REFERENCES Sinif (SinifId) NULL)

CREATE TABLE OgrenciKatilimi (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifId int FOREIGN KEY(SinifId)REFERENCES Sinif (SinifId) NULL,
	DersId int FOREIGN KEY(DersId) REFERENCES Ders (DersId) NULL,
	OkulNo varchar(20) NULL,
	Durumu bit NULL,
	Tarih date NULL)

CREATE TABLE Ogretmen(
	OgretmenId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Isim varchar(50) NULL,
	DOB date NULL,
	Cinsiyet varchar(1) NULL,
	Telefon varchar(11) NULL,
	Email varchar(50) NULL,
	Adres varchar(max) NULL,
	Sifre varchar(20) NULL)

CREATE TABLE OgretmenKatilimi(
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	OgretmenId int FOREIGN KEY(OgretmenId) REFERENCES Ogretmen (OgretmenId) NULL,
	Durumu bit NULL,
	Tarih date NULL)
 
CREATE TABLE Sinav(
	SinavId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifId int FOREIGN KEY(SinifId)REFERENCES Sinif (SinifId) NULL,
	DersId int FOREIGN KEY(DersId) REFERENCES Ders (DersId) NULL,
	OkulNo varchar(20) NULL,
	ToplamNotlar int NULL,
	DigerNotlar int NULL)
 
CREATE TABLE Sinif(
	SinifId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifIsmi varchar(50) NULL,

CREATE TABLE SinifGideri(
	SinifGideriId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SinifId int FOREIGN KEY(SinifId) REFERENCES Sinif(SinifId) NULL,
	SinifGideriTutari int NULL)





INSERT INTO Ders(DersId, SinifId, DersIsmi) VALUES (1, 1, N'İngilize')
INSERT INTO Ders VALUES (2, 2, N'Matematik')
INSERT INTO DersGideri (DersGideriId, SinifId, DersId, UcretTutari) VALUES (1, 1, 7, 54321)
INSERT INTO DersGideri VALUES (2, 1, 4, 100)
INSERT INTO DersOgretmeni (Id, SinifId, DersId, OgretmenId) VALUES (4, 1, 8, 5)
INSERT Ogrenci (OgrenciId, Isim, DOB, Cinsiyet, Telefon, OkulNo, Adres, SinifId) VALUES (1, 'Beyzanur horasan', CAST(N'2022-10-05' AS Date), 'K', 123456987, '123', 'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 2)
INSERT INTO Ogretmen VALUES('SUDE ÖNGÖREN','05.02.1995','K','052233366699','sude@gmail.com','Ankara','SifreSude')
UPDATE Ogretmen SET Adres='İstanbul Merkez' WHERE Isim='SUDE ÖNGÖREN'
UPDATE Ogretmen SET Isim='Şükrü İnanır' where OgretmenId=1
UPDATE Ogretmen SET Cinsiyet='E' where OgretmenId=1
DELETE Ogretmen WHERE OgretmenId=6;


--TETİKLEYİCİ(T-SQL)
 CREATE TRIGGER OGRENCI_EKLE
 ON Ogrenci
 AFTER INSERT 
 AS 
BEGIN 
SELECT 'Yeni bir öğrenci eklendi.'
END 




--SAKLI PROSEDÜR(STORED PROCEDURE)
CREATE PROCEDURE USP_OGRENCİ_EKLE
@OgrenciId INT,
@Isim VARCHAR(50),
@DOB DATE,
@Cinsiyet VARCHAR(1),
@Telefon VARCHAR(11),
@OkulNo VARCHAR(50),
@Adres VARCHAR(MAX),
@SinifId INT
AS
BEGIN
   IF(@OgrenciId=-1)
      INSERT INTO Ogrenci(Isim,DOB,Cinsiyet,Telefon,OkulNo,Adres,SinifId)
	  SELECT @Isim,@DOB,@Cinsiyet,@Telefon,@OkulNo,@Adres,@SinifId
	ELSE
	   UPDATE Ogrenci SET Isim=@Isim,DOB=@DOB,Cinsiyet=@Cinsiyet,OkulNo=@OkulNo,Adres=@Adres,SinifId=@SinifId WHERE OgrenciId=@OgrenciId
END

EXEC USP_OGRENCİ_EKLE 6,'GÜl ENDAM','02-02-2000','K','05388889999','556','...',2
SELECT * FROM Ogrenci


CREATE PROCEDURE USP_OGRENCI_HEPSİ
AS
BEGIN
  SELECT * FROM  Ogrenci
END

EXEC USP_OGRENCI_HEPSİ


CREATE PROCEDURE USP_OGRENCI_OKU
@OgrenciId int
AS
BEGIN
SELECT * FROM Ogrenci WHERE OgrenciId=@OgrenciId
END

EXEC USP_OGRENCI_OKU 5



CREATE PROCEDURE USP_OGRENCI_SIL
@OgrenciId int
 AS
DELETE FROM Ogrenci WHERE OgrenciId=@OgrenciId

EXEC USP_OGRENCI_SIL 7





--KISITLAYICI CONSTRAINT

ALTER TABLE Ogrenci 
ADD CONSTRAINT CK_OGRENCI CHECK (Cinsiyet IN ('E' , 'K'))

ALTER TABLE SinifGideri  
WITH CHECK ADD FOREIGN KEY(SinifId) REFERENCES Sinif(SinifId)

ALTER TABLE Ogretmen
ADD CONSTRAINT DF_OGRETMEN DEFAULT 'Adres yazılmalıdır!!!' FOR Adres


--GÖRÜNÜM (VİEW)

CREATE VIEW VW_DERSOGRETMENI
AS
SELECT DO.Id,S.SinifIsmi, D.DersIsmi,O.Isim FROM DersOgretmeni DO
INNER JOIN Sinif S ON DO.SinifId=S.SinifId
INNER JOIN Ders D ON DO.DersId=D.DersId
INNER JOIN Ogretmen O ON DO.OgretmenId=O.OgretmenId


SELECT * FROM VW_DERSOGRETMENI

CREATE VIEW VW_DERSGIDERI
AS 
SELECT DG.DersGideriId,S.SinifIsmi,D.DersIsmi,DG.UcretTutari FROM DersGideri DG
INNER JOIN Sinif S ON DG.SinifId=S.SinifId
INNER JOIN Ders D ON DG.DersId=D.DersId

SELECT * FROM VW_DERSGIDERI

CREATE VIEW VW_OGRENCIKATILIMI
AS 
SELECT OK.Id,S.SinifIsmi,D.DersIsmi,OK.OkulNo,OK.Durumu,OK.Tarih FROM OgrenciKatilimi OK
INNER JOIN Sinif S ON OK.SinifId=S.SinifId
INNER JOIN Ders D ON OK.DersId=D.DersId

SELECT * FROM VW_OGRENCIKATILIMI

CREATE VIEW VW_OGRETMENKATILIMI
AS 
SELECT OK.Id,O.Isim,OK.Durumu,OK.Tarih FROM OgretmenKatilimi OK
INNER JOIN Ogretmen O ON OK.OgretmenId=O.OgretmenId

SELECT * FROM VW_OGRETMENKATILIMI

CREATE VIEW VW_SINAV
AS 
SELECT SV.SinavId,S.SinifIsmi,D.DersIsmi,SV.OkulNo,SV.ToplamNotlar,SV.DigerNotlar FROM Sinav SV
INNER JOIN Sinif S ON SV.SinifId=S.SinifId
INNER JOIN Ders D ON SV.DersId=D.DersId

SELECT * FROM VW_SINAV



--CURSOR


DECLARE @Isim VARCHAR(50), @Telefon VARCHAR(11), @Email VARCHAR(50)
DECLARE OGRETMENCURSOR CURSOR
FOR             
SELECT Isim, Telefon, Email FROM Ogretmen
OPEN OGRETMENCURSOR
FETCH NEXT FROM OGRETMENCURSOR INTO @Isim, @Telefon, @Email
WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT 'AD SOYAD:'+@Isim + '----- ' +'Telefon:'+ @Telefon + '--- '+'Mail Adresi:' + @Email
    FETCH NEXT FROM OGRETMENCURSOR INTO @Isim, @Telefon, @Email
  END
CLOSE OGRETMENCURSOR
