
USE Netflix
GO
CREATE DATABASE Netflix
DROP DATABASE Netflix

CREATE TABLE Genre (
    GenreID CHAR(4) PRIMARY KEY CHECK (GenreID LIKE 'G[0-9][0-9][0-9]'),
    GenreName VARCHAR(255) UNIQUE
);

INSERT INTO Genre (GenreID, GenreName)
VALUES
    ('G001', 'Comedy'),
    ('G002', 'Horror'),
    ('G003', 'Documentary');

CREATE TABLE Content (
    ContentID CHAR(5) PRIMARY KEY CHECK (ContentID LIKE 'CO[0-9][0-9][0-9]'),
    ContentName VARCHAR(255),
    ContentType VARCHAR(50),
    MaturityRating VARCHAR(10) CHECK (MaturityRating LIKE '%+'),
    ProductionYear INT,
    ContentDirector VARCHAR(255),
    ContentCast VARCHAR(255)
);

INSERT INTO Content (ContentID, ContentName, ContentType, MaturityRating, ProductionYear, ContentDirector, ContentCast)
VALUES
    ('CO001', 'Pee Nak', 'Movie', '18+', 2019, 'Asep', 'Intan, Jessica, Mirna'),
    ('CO002', 'Superstore', 'Series', '18+', 2020, 'Indra', 'Joko, Jaka, Joki'),
    ('CO003', 'MH370', 'Series', '16+', 2023, 'Andreas', 'Ferdi, Gunawan'),
    ('CO004', 'Train To Busan', 'Movie', '18+', 2001, 'Jason', 'Budi, Santoso'),
    ('CO005', 'Start-Up', 'Series', '13+', 2020, 'Bagus', 'Jeff, Hadi'),
	('CO006', 'Chucky', 'Movies', '18+', 1988, 'George Donald Mancini', 'Jeniffer, Arthur');


CREATE TABLE Movie (
    MovieID CHAR(4) PRIMARY KEY CHECK (MovieID LIKE 'M[0-9][0-9][0-9]'),
    ContentID CHAR(5) UNIQUE REFERENCES Content(ContentID),
    MovieURL VARCHAR(255) UNIQUE,
    MovieLength INT,
    MovieSummary VARCHAR(500)
);

INSERT INTO Movie (MovieID, ContentID, MovieURL, MovieLength, MovieSummary)
VALUES
    ('M001', 'CO001', 'https://www.netflix.com/id-en/title/80808080808', 120, 'Sent to Africa at the close of World War II to tend to the needs of the local community, Father Lankester Merrin gets more than he ever bargained for when he has his first brush with a devilish force known simply as Pazuzu.'),
    ('M002', 'CO004', 'https://www.netflix.com/id-en/title/80808080801', 122, 'As a zombie outbreak sweeps the country, a dad and his daughter take a harrowing train journey in an attempt to reach the only city thats still safe.'),
	('M003', 'CO006', 'https://www.netflix.com/id-en/title/80808011333', 131, 'Gunned down by Detective Mike Norris (Chris Sarandon), dying murderer Charles Lee Ray (Brad Dourif) uses black magic to put his soul inside a doll named Chucky -- which Karen Barclay (Catherine Hicks) then buys for her young son, Andy (Alex Vincent). When Chucky kills Andys baby sitter, the boy realizes the doll is alive and tries to warn people, but hes institutionalized.');



CREATE TABLE Country (
    CountryID CHAR(4) PRIMARY KEY CHECK (CountryID LIKE 'C[0-9][0-9][0-9]'),
    CountryName VARCHAR(255) UNIQUE,
    CountryCoordinate VARCHAR(255)
);
SELECT * FROM Country
INSERT INTO Country (CountryID, CountryName, CountryCoordinate)
VALUES
    ('C001', 'Indonesia', '0° 47 21.39" S 113° 55 16.777" E'),
    ('C002', 'Afghanistan', '33°56 2.54" N 67°42 12.35" E'),
	('C003', 'Japan', '12°22 3.44" N 22°32 11.41" E');

CREATE TABLE Category (
    CategoryID CHAR(5) PRIMARY KEY CHECK (CategoryID LIKE 'CG[0-9][0-9][0-9]'),
    CategoryType VARCHAR(255) UNIQUE
);

INSERT INTO Category (CategoryID, CategoryType)
VALUES
    ('CG001', 'newRelease'),
    ('CG002', 'TrendingNow'),
    ('CG003', 'OnlyOnNetflix'),
    ('CG004', 'MyList PR1'),
    ('CG005', 'MyList PR2'),
	('CG006', 'MyList PR3'),
	('CG007', 'MyList PR4');


CREATE TABLE CategoryDetail (
    CategoryID CHAR(5),
    ContentID CHAR(5),
    ContentAddedDate DATE,
    PRIMARY KEY (CategoryID, ContentID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

INSERT INTO CategoryDetail (CategoryID, ContentID, ContentAddedDate)
VALUES
    ('CG001', 'CO001', '2023-10-22'),
    ('CG002', 'CO001', '2023-09-12'),
    ('CG003', 'CO001', '2023-01-08'),
    ('CG004', 'CO001', '2023-03-01'),
    ('CG001', 'CO002', '2023-06-24'),
    ('CG003', 'CO002', '2023-09-30'),
	('CG001', 'CO004', '2023-10-22')



CREATE TABLE Users (
    UserID CHAR(4) PRIMARY KEY CHECK (UserID LIKE 'U[0-9][0-9][0-9]'),
    UserName VARCHAR(255),
    UserEmail VARCHAR(255) UNIQUE,
    UserPassword VARCHAR(255) UNIQUE,
    UserAge INT,
    UserPhone VARCHAR(255) UNIQUE,
    CountryID CHAR(4),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

INSERT INTO Users (UserID, UserName, UserEmail, UserPassword, UserAge, UserPhone, CountryID)
VALUES
    ('U001', 'AsepBatagor86', 'AsepBtgr@gmail.com', 'Asep144', 19, '85714561666', 'C001'),
    ('U002', 'IndraCD', 'Indraez@gmail.com', 'IndraCetta', 19, '85711224366', 'C002'),
	-- belum diinsert
	('U003', 'Joni', 'Joni677@gmail.com', 'Jonnn111', 21, '8191445555', 'C003');



CREATE TABLE Profiles (
    ProfileID CHAR(5) PRIMARY KEY CHECK (ProfileID LIKE 'PR[0-9][0-9][0-9]'),
    UserID CHAR(4) REFERENCES Users(UserID),
    ProfileName VARCHAR(255),
    ProfileAvatar VARCHAR(255)
);

INSERT INTO Profiles (ProfileID, UserID, ProfileName, ProfileAvatar)
VALUES
    ('PR001', 'U001', 'Indra mau meletup', 'https://example.com/avatar1.jpg'),
    ('PR002', 'U001', 'Jack', 'https://example.com/avatar2.jpg'),
    ('PR003', 'U001', 'Bob', 'https://example.com/avatar3.jpg'),
    ('PR004', 'U002', 'Lando', 'https://example.com/avatar4.jpg'),
    ('PR005', 'U002', 'Budi', 'https://example.com/avatar5.jpg'),
    ('PR006', 'U002', 'Agus', 'https://example.com/avatar1.jpg'),
    ('PR007', 'U002', 'Susan', 'https://example.com/avatar2.jpg'),
    ('PR008', 'U002', 'Jason', 'https://example.com/avatar3.jpg');

CREATE TABLE UserProfileCategory (
    ProfileID CHAR(5),
    CategoryID CHAR(5),
    LastAccessDate DATE,
    PRIMARY KEY (ProfileID, CategoryID),
    FOREIGN KEY (ProfileID) REFERENCES Profiles(ProfileID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

INSERT INTO UserProfileCategory (ProfileID, CategoryID, LastAccessDate)
VALUES
    ('PR001', 'CG001', '2023-10-30'),
    ('PR001', 'CG002', '2023-10-28'),
    ('PR001', 'CG003', '2023-10-26'),
    ('PR001', 'CG004', '2023-10-08'),
    ('PR002', 'CG001', '2023-09-07'),
    ('PR002', 'CG002', '2023-08-22'),
    ('PR002', 'CG003', '2023-03-11'),
    ('PR002', 'CG005', '2023-11-12'),
	('PR004', 'CG001', '2023-10-30'),
    ('PR004', 'CG002', '2023-10-30'),
    ('PR004', 'CG003', '2023-10-30');


CREATE TABLE Series (
    SeriesID CHAR(4) PRIMARY KEY CHECK (SeriesID LIKE 'S[0-9][0-9][0-9]'),
    ContentID CHAR(5) UNIQUE REFERENCES Content(ContentID),
    SeriesSynopsis VARCHAR(255),
    TotalEpisode INT,
);

INSERT INTO Series (SeriesID, ContentID, SeriesSynopsis, TotalEpisode)
VALUES
    ('S001', 'CO002', 'Desa Kembang memenangkan balapan motor hanya menggunakan aestra', 20),
    ('S002', 'CO003', 'James menaklukan wanita yang ia temui', 13),
    ('S003', 'CO005', 'Indra berperang dengan Zeus', 15);


CREATE TABLE Episode (
    EpisodeID CHAR(4) PRIMARY KEY CHECK (EpisodeID LIKE 'E[0-9][0-9][0-9]'),
    SeriesID CHAR(4),
    EpisodeNum INT,
    EpisodeURL VARCHAR(255),
    EpisodeLength INT,
    EpisodeSummary TEXT,
    FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID)
);

INSERT INTO Episode (EpisodeID, SeriesID, EpisodeNum, EpisodeURL, EpisodeLength, EpisodeSummary)
VALUES
	('E001', 'S001', 1, 'https://www.netflix.com/id-en/title/808080',24, 'Jonahs first day on the job at Cloud 9 gets off to a rocky start when he irks floor supervisor Amy and attracts assistant manager Dinas attention.'),
	('E002', 'S001', 1, 'https://www.netflix.com/id-en/title/8080808081', 21, 'Ikan terbang dengan bahagia'),
    ('E003', 'S002', 1, 'https://www.netflix.com/id-en/title/80808080808', 24, 'Perburuan Indra mengejar serigala'),
    ('E004', 'S002', 2, 'https://www.netflix.com/id-en/title/808080801', 26, 'Indra berteman dengan Serigala'),
    ('E005', 'S003', 1, 'https://www.netflix.com/id-en/title/808080802', 30, 'Indra bergabung dengan Gerindra');


CREATE TABLE PaymentMethod (
    PaymentMethodID CHAR(5) PRIMARY KEY CHECK (PaymentMethodID LIKE 'PM[0-9][0-9][0-9]'),
    PaymentMethodName VARCHAR(255) UNIQUE
);


INSERT INTO PaymentMethod (PaymentMethodID, PaymentMethodName)
VALUES
    ('PM001', 'Credit'),
    ('PM002', 'Gift card'),
    ('PM003', 'Paypal');

CREATE TABLE Plans (
    PlanID CHAR(4) PRIMARY KEY CHECK (PlanID LIKE 'P[0-9][0-9][0-9]'),
    PlanName VARCHAR(255) UNIQUE,
    PlanCharge INT,
	VideoQuality VARCHAR(50),
	Resolution VARCHAR(50)
);

INSERT INTO Plans (PlanID, PlanName, PlanCharge, VideoQuality, Resolution)
VALUES
    ('P001', 'Basic', 65000, 'Good', '720p'),
    ('P002', 'Standard', 120000, 'Better', '1080p'),
    ('P003', 'Premium', 186000, 'Best', '4k+HDR');
	
CREATE TABLE Subscription (
    SubscriptionID char(4) PRIMARY KEY CHECK (SubscriptionID LIKE 'S[0-9][0-9][0-9]') ,
    UserID CHAR(4),
	PlanID CHAR(4),
    PaymentMethodID CHAR(5),
    SubscriptionDate DATE,
    EndSubscriptionDate DATE,
    CancelDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID),
	FOREIGN KEY (PlanID) REFERENCES Plans(PlanID)
);

INSERT INTO Subscription (SubscriptionID, UserID, PlanID, PaymentMethodID, SubscriptionDate, EndSubscriptionDate, CancelDate)
VALUES
    ('S013', 'U001', 'P001', 'PM001', '2023-01-12', '2024-01-12', '2024-02-01'),
    ('S015', 'U002', 'P002', 'PM003', '2022-01-01', '2023-01-01', '2022-02-01'),
	('S016', 'U001', 'P001', 'PM002', '2023-01-18', '2024-01-22', '2024-02-01');



CREATE TABLE Partnership (
    PartnershipID CHAR(5) PRIMARY KEY CHECK (PartnershipID LIKE 'PS[0-9][0-9][0-9]'),
    PartnerName VARCHAR(255),
    PartnerDescription TEXT,
    PartnerContact VARCHAR(255),
    PartnershipType VARCHAR(50)
);

INSERT INTO Partnership (PartnershipID, PartnerName, PartnerDescription, PartnerContact, PartnershipType)
VALUES
    ('PS001', 'ABC Studios', 'Content partnership for new TV series', 'partnership@abcstudios.com', 'Content'),
    ('PS002', 'XYZ Music Label', 'Music licensing for exclusive soundtracks', 'licensing@xyzmusic.com', 'Music'),
	('PS003', 'Music Fusion', 'Music licensing for soundtracks', 'licensing@musicfusion.com', 'Music'),
    ('PS004', 'Media Creations', 'Content creation partnership', 'partner@mediacreations.com', 'Content');


CREATE TABLE ContentPartnership (
    ContentID CHAR(5),
    PartnershipID CHAR(5),
    PRIMARY KEY (ContentID, PartnershipID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID),
    FOREIGN KEY (PartnershipID) REFERENCES Partnership(PartnershipID)
);

INSERT INTO ContentPartnership (ContentID, PartnershipID)
VALUES
	('CO003', 'PS003'),
	('CO003', 'PS001'),
    ('CO001', 'PS001'),
	('CO001', 'PS004'),
    ('CO002', 'PS002');

-- update
CREATE TABLE ContentGenre (
    ContentID CHAR(5),
    GenreID CHAR(4),
    PRIMARY KEY (ContentID, GenreID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);

INSERT INTO ContentGenre (ContentID, GenreID)
VALUES
	('CO001', 'G001'),
	('CO001', 'G002'),
    ('CO002', 'G001'),
    ('CO003', 'G003');



