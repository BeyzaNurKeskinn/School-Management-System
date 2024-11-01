USE [OkulYntmSystmDB]
GO
/****** Object:  Table [dbo].[Sinif]    Script Date: 2.01.2023 22:41:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sinif](
	[SinifId] [int] IDENTITY(1,1) NOT NULL,
	[SinifIsmi] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SinifId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ders]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ders](
	[DersId] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[DersIsmi] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ogretmen]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ogretmen](
	[OgretmenId] [int] IDENTITY(1,1) NOT NULL,
	[Isim] [varchar](50) NULL,
	[DOB] [date] NULL,
	[Cinsiyet] [varchar](50) NULL,
	[Telefon] [bigint] NULL,
	[Email] [varchar](50) NULL,
	[Adres] [varchar](max) NULL,
	[Sifre] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[OgretmenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DersOgretmeni]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DersOgretmeni](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[DersId] [int] NULL,
	[OgretmenId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_DERSOGRETMENI]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_DERSOGRETMENI]
AS
SELECT DO.Id,S.SinifIsmi, D.DersIsmi,O.Isim FROM DersOgretmeni DO
INNER JOIN Sinif S ON DO.SinifId=S.SinifId
INNER JOIN Ders D ON DO.DersId=D.DersId
INNER JOIN Ogretmen O ON DO.OgretmenId=O.OgretmenId
GO
/****** Object:  Table [dbo].[DersGideri]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DersGideri](
	[DersGideriId] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[DersId] [int] NULL,
	[UcretTutari] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DersGideriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_DERSGIDERI]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DERSGIDERI]
AS 
SELECT DG.DersGideriId,S.SinifIsmi,D.DersIsmi,DG.UcretTutari FROM DersGideri DG
INNER JOIN Sinif S ON DG.SinifId=S.SinifId
INNER JOIN Ders D ON DG.DersId=D.DersId
GO
/****** Object:  Table [dbo].[OgrenciKatilimi]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OgrenciKatilimi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[DersId] [int] NULL,
	[OkulNo] [varchar](20) NULL,
	[Durumu] [bit] NULL,
	[Tarih] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_OGRENCIKATILIMI]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_OGRENCIKATILIMI]
AS 
SELECT OK.Id,S.SinifIsmi,D.DersIsmi,OK.OkulNo,OK.Durumu,OK.Tarih FROM OgrenciKatilimi OK
INNER JOIN Sinif S ON OK.SinifId=S.SinifId
INNER JOIN Ders D ON OK.DersId=D.DersId
GO
/****** Object:  Table [dbo].[OgretmenKatilimi]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OgretmenKatilimi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OgretmenId] [int] NULL,
	[Durumu] [bit] NULL,
	[Tarih] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_OGRETMENKATILIMI]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_OGRETMENKATILIMI]
AS 
SELECT OK.Id,O.Isim,OK.Durumu,OK.Tarih FROM OgretmenKatilimi OK
INNER JOIN Ogretmen O ON OK.OgretmenId=O.OgretmenId
GO
/****** Object:  Table [dbo].[Sinav]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sinav](
	[SinavId] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[DersId] [int] NULL,
	[OkulNo] [varchar](20) NULL,
	[ToplamNotlar] [int] NULL,
	[DigerNotlar] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SinavId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_SINAV]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SINAV]
AS 
SELECT SV.SinavId,S.SinifIsmi,D.DersIsmi,SV.OkulNo,SV.ToplamNotlar,SV.DigerNotlar FROM Sinav SV
INNER JOIN Sinif S ON SV.SinifId=S.SinifId
INNER JOIN Ders D ON SV.DersId=D.DersId
GO
/****** Object:  Table [dbo].[Ogrenci]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ogrenci](
	[OgrenciId] [int] IDENTITY(1,1) NOT NULL,
	[Isim] [varchar](50) NULL,
	[DOB] [date] NULL,
	[Cinsiyet] [varchar](50) NULL,
	[Telefon] [bigint] NULL,
	[OkulNo] [varchar](50) NULL,
	[Adres] [varchar](max) NULL,
	[SinifId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OgrenciId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinifGideri]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinifGideri](
	[SinifGideriId] [int] IDENTITY(1,1) NOT NULL,
	[SinifId] [int] NULL,
	[SinifGideriTutari] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SinifGideriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Ders] ON 

INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (1, 1, N'İngilize')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (2, 2, N'Matematik')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (3, 3, N'Türkçe')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (4, 1, N'Fransızca')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (5, 1, N'Geometri')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (6, 2, N'Din Kültürü')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (7, 2, N'Beden Eğitimi')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (8, 3, N'Fen Bilimleri')
INSERT [dbo].[Ders] ([DersId], [SinifId], [DersIsmi]) VALUES (9, 2, N'Arapca')
SET IDENTITY_INSERT [dbo].[Ders] OFF
GO
SET IDENTITY_INSERT [dbo].[DersGideri] ON 

INSERT [dbo].[DersGideri] ([DersGideriId], [SinifId], [DersId], [UcretTutari]) VALUES (1, 1, 7, 54321)
INSERT [dbo].[DersGideri] ([DersGideriId], [SinifId], [DersId], [UcretTutari]) VALUES (2, 1, 4, 100)
INSERT [dbo].[DersGideri] ([DersGideriId], [SinifId], [DersId], [UcretTutari]) VALUES (3, 2, 5, 1001)
SET IDENTITY_INSERT [dbo].[DersGideri] OFF
GO
SET IDENTITY_INSERT [dbo].[DersOgretmeni] ON 

INSERT [dbo].[DersOgretmeni] ([Id], [SinifId], [DersId], [OgretmenId]) VALUES (1, 2, 5, 1)
INSERT [dbo].[DersOgretmeni] ([Id], [SinifId], [DersId], [OgretmenId]) VALUES (2, 1, 4, 3)
INSERT [dbo].[DersOgretmeni] ([Id], [SinifId], [DersId], [OgretmenId]) VALUES (3, 1, 7, 4)
INSERT [dbo].[DersOgretmeni] ([Id], [SinifId], [DersId], [OgretmenId]) VALUES (4, 1, 8, 5)
SET IDENTITY_INSERT [dbo].[DersOgretmeni] OFF
GO
SET IDENTITY_INSERT [dbo].[Ogrenci] ON 

INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (1, N'Beyzanur horasan', CAST(N'2022-10-05' AS Date), N'Male', 123456987, N'123', N'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 2)
INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (2, N'samet ipek', CAST(N'2022-10-20' AS Date), N'Male', 9876543210, N'124', N'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 3)
INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (3, N'Selma Gundogdu', CAST(N'2000-11-12' AS Date), N'Female', 123456789, N'125', N'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 1)
INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (4, N'Yusuf Sevinc', CAST(N'1999-11-03' AS Date), N'Male', 9876541230, N'126', N'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 1)
INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (5, N'Elif Oksuzali', CAST(N'1998-11-09' AS Date), N'Female', 7418529600, N'127', N'Bursa/OSMANGAZİ/ bağlarbaşı mahallesi şehit şenol şentürk sokak no 18 kat 1', 3)
INSERT [dbo].[Ogrenci] ([OgrenciId], [Isim], [DOB], [Cinsiyet], [Telefon], [OkulNo], [Adres], [SinifId]) VALUES (6, N'GÜl ENDAM', CAST(N'2000-02-02' AS Date), N'K', 5388889999, N'556', N'...', 2)
SET IDENTITY_INSERT [dbo].[Ogrenci] OFF
GO
SET IDENTITY_INSERT [dbo].[OgrenciKatilimi] ON 

INSERT [dbo].[OgrenciKatilimi] ([Id], [SinifId], [DersId], [OkulNo], [Durumu], [Tarih]) VALUES (1, 2, 4, N'123', 1, CAST(N'2022-11-11' AS Date))
INSERT [dbo].[OgrenciKatilimi] ([Id], [SinifId], [DersId], [OkulNo], [Durumu], [Tarih]) VALUES (2, 1, 4, N'125', 1, CAST(N'2022-11-11' AS Date))
SET IDENTITY_INSERT [dbo].[OgrenciKatilimi] OFF
GO
SET IDENTITY_INSERT [dbo].[Ogretmen] ON 

INSERT [dbo].[Ogretmen] ([OgretmenId], [Isim], [DOB], [Cinsiyet], [Telefon], [Email], [Adres], [Sifre]) VALUES (1, N'Seda Sayan', CAST(N'1983-01-01' AS Date), N'Female', 1234567890, N'sedasayan@gmail.com', N'Bursa', N'seda')
INSERT [dbo].[Ogretmen] ([OgretmenId], [Isim], [DOB], [Cinsiyet], [Telefon], [Email], [Adres], [Sifre]) VALUES (3, N'Melis Betkayan', CAST(N'2000-01-01' AS Date), N'Female', 1254789654, N'melisbetkayan@gmail.com', N'İstanbul', N'melis')
INSERT [dbo].[Ogretmen] ([OgretmenId], [Isim], [DOB], [Cinsiyet], [Telefon], [Email], [Adres], [Sifre]) VALUES (4, N'Didem Delen', CAST(N'2002-06-06' AS Date), N'Female', 1234567809, N'didem@gmail.com', N'Ankara', N'didem')
INSERT [dbo].[Ogretmen] ([OgretmenId], [Isim], [DOB], [Cinsiyet], [Telefon], [Email], [Adres], [Sifre]) VALUES (5, N'Erhan Saffar', CAST(N'2000-10-04' AS Date), N'Male', 514217890, N'erhansaffar@gmail.com', N'İzmit', N'erhan')
SET IDENTITY_INSERT [dbo].[Ogretmen] OFF
GO
SET IDENTITY_INSERT [dbo].[OgretmenKatilimi] ON 

INSERT [dbo].[OgretmenKatilimi] ([Id], [OgretmenId], [Durumu], [Tarih]) VALUES (1, 1, 1, CAST(N'2022-11-09' AS Date))
INSERT [dbo].[OgretmenKatilimi] ([Id], [OgretmenId], [Durumu], [Tarih]) VALUES (2, 3, 0, CAST(N'2022-11-09' AS Date))
INSERT [dbo].[OgretmenKatilimi] ([Id], [OgretmenId], [Durumu], [Tarih]) VALUES (3, 4, 1, CAST(N'2022-11-09' AS Date))
INSERT [dbo].[OgretmenKatilimi] ([Id], [OgretmenId], [Durumu], [Tarih]) VALUES (4, 5, 1, CAST(N'2022-11-09' AS Date))
SET IDENTITY_INSERT [dbo].[OgretmenKatilimi] OFF
GO
SET IDENTITY_INSERT [dbo].[Sinav] ON 

INSERT [dbo].[Sinav] ([SinavId], [SinifId], [DersId], [OkulNo], [ToplamNotlar], [DigerNotlar]) VALUES (1, 2, 5, N'123', 80, 100)
INSERT [dbo].[Sinav] ([SinavId], [SinifId], [DersId], [OkulNo], [ToplamNotlar], [DigerNotlar]) VALUES (2, 2, 9, N'124', 5, 562)
INSERT [dbo].[Sinav] ([SinavId], [SinifId], [DersId], [OkulNo], [ToplamNotlar], [DigerNotlar]) VALUES (3, 1, 4, N'125', 52, 20)
INSERT [dbo].[Sinav] ([SinavId], [SinifId], [DersId], [OkulNo], [ToplamNotlar], [DigerNotlar]) VALUES (4, 3, 6, N'126', 425, 23)
INSERT [dbo].[Sinav] ([SinavId], [SinifId], [DersId], [OkulNo], [ToplamNotlar], [DigerNotlar]) VALUES (5, 3, 6, N'127', 465, 73)
SET IDENTITY_INSERT [dbo].[Sinav] OFF
GO
SET IDENTITY_INSERT [dbo].[Sinif] ON 

INSERT [dbo].[Sinif] ([SinifId], [SinifIsmi]) VALUES (1, N'1. Sınıf')
INSERT [dbo].[Sinif] ([SinifId], [SinifIsmi]) VALUES (2, N'2. Sınıf')
INSERT [dbo].[Sinif] ([SinifId], [SinifIsmi]) VALUES (3, N'3. Sınıf')
INSERT [dbo].[Sinif] ([SinifId], [SinifIsmi]) VALUES (4, N'4. Sınıf')
INSERT [dbo].[Sinif] ([SinifId], [SinifIsmi]) VALUES (5, N'5.sınıf')
SET IDENTITY_INSERT [dbo].[Sinif] OFF
GO
SET IDENTITY_INSERT [dbo].[SinifGideri] ON 

INSERT [dbo].[SinifGideri] ([SinifGideriId], [SinifId], [SinifGideriTutari]) VALUES (16, 1, 85123)
INSERT [dbo].[SinifGideri] ([SinifGideriId], [SinifId], [SinifGideriTutari]) VALUES (17, 2, 546)
SET IDENTITY_INSERT [dbo].[SinifGideri] OFF
GO
ALTER TABLE [dbo].[Ders]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[DersGideri]  WITH CHECK ADD FOREIGN KEY([DersId])
REFERENCES [dbo].[Ders] ([DersId])
GO
ALTER TABLE [dbo].[DersGideri]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[DersOgretmeni]  WITH CHECK ADD FOREIGN KEY([DersId])
REFERENCES [dbo].[Ders] ([DersId])
GO
ALTER TABLE [dbo].[DersOgretmeni]  WITH CHECK ADD FOREIGN KEY([OgretmenId])
REFERENCES [dbo].[Ogretmen] ([OgretmenId])
GO
ALTER TABLE [dbo].[DersOgretmeni]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[Ogrenci]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[OgrenciKatilimi]  WITH CHECK ADD FOREIGN KEY([DersId])
REFERENCES [dbo].[Ders] ([DersId])
GO
ALTER TABLE [dbo].[OgrenciKatilimi]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[OgretmenKatilimi]  WITH CHECK ADD FOREIGN KEY([OgretmenId])
REFERENCES [dbo].[Ogretmen] ([OgretmenId])
GO
ALTER TABLE [dbo].[Sinav]  WITH CHECK ADD FOREIGN KEY([DersId])
REFERENCES [dbo].[Ders] ([DersId])
GO
ALTER TABLE [dbo].[Sinav]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
ALTER TABLE [dbo].[SinifGideri]  WITH CHECK ADD FOREIGN KEY([SinifId])
REFERENCES [dbo].[Sinif] ([SinifId])
GO
/****** Object:  StoredProcedure [dbo].[USP_OGRENCI_HEPSİ]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_OGRENCI_HEPSİ]
AS
BEGIN
  SELECT * FROM  Ogrenci
END
GO
/****** Object:  StoredProcedure [dbo].[USP_OGRENCI_OKU]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_OGRENCI_OKU]
@OgrenciId int
AS
BEGIN
SELECT * FROM Ogrenci WHERE OgrenciId=@OgrenciId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_OGRENCI_SIL]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_OGRENCI_SIL]
@OgrenciId int
 AS
DELETE FROM Ogrenci WHERE OgrenciId=@OgrenciId
GO
/****** Object:  StoredProcedure [dbo].[USP_OGRENCİ_EKLE]    Script Date: 2.01.2023 22:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_OGRENCİ_EKLE]
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
GO
