SELECT * FROM DIM_ACCIDENT1;
SELECT DISTINCT Investigation_Type, Injury_Severity, Aircraft_damage, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Broad_phase_of_flight FROM Aviation_Data2;
SELECT * FROM DIM_PLACE1;
SELECT DISTINCT Location, Country, Airport_Code, Airport_Name FROM Aviation_Data2;
SELECT * FROM DIM_PLANE1;
SELECT * FROM DIM_TIME1;

SELECT Air_carrier, COUNT(*) 
FROM Aviation_Data2
GROUP BY Air_carrier
ORDER BY 2 DESC;

--fixed-totally
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Aviation_Data2' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Aviation_Data2;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Aviation_Data1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Aviation_Data1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FACT_ACCIDENTS1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE FACT_ACCIDENTS1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_CONDITIONS1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_CONDITIONS1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLACE1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLACE1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLANE1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLANE1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_TIME1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_TIME1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_ACCIDENT1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_ACCIDENT1;

--CREATE TABLES
CREATE TABLE Aviation_Data1
(
Event_Id nvarchar(200) null, 
Investigation_Type nvarchar(200) null, 
Accident_Number nvarchar(200) null, 
Event_Date date null, 
Location nvarchar(200) null, 
Country nvarchar(200) null, 
Latitude nvarchar(200) null, 
Longitude nvarchar(200) null, 
Airport_Code nvarchar(200) null, 
Airport_Name nvarchar(200) null, 
Injury_Severity nvarchar(200) null, 
Aircraft_damage nvarchar(200) null, 
Aircraft_Category nvarchar(200) null, 
Registration_Number nvarchar(200) null, 
Make nvarchar(200) null, 
Model nvarchar(200) null, 
Amateur_Built nvarchar(200) null , 
Number_of_Engines nvarchar(200) null, 
Engine_Type nvarchar(200) null, 
FAR_Description nvarchar(200) null, 
Schedule nvarchar(200) null, 
Purpose_of_Flight nvarchar(200) null, 
Air_carrier nvarchar(200) null,
Total_Fatal_Injuries nvarchar(200) null, 
Total_Serious_Injuries nvarchar(200) null, 
Total_Minor_Injuries nvarchar(200) null, 
Total_Uninjured nvarchar(200) null,
Weather_Condition nvarchar(200) null,
Broad_phase_of_flight nvarchar(200) null,
Report_Status nvarchar(200) null,
Publication_Date nvarchar(200) null,
Accident_Id int null,
Place_Id int null,
Plane_Id int null
);

CREATE TABLE Aviation_Data2
(
Event_Id nvarchar(200) null, 
Investigation_Type nvarchar(200) null, 
Accident_Number nvarchar(200) null, 
Event_Date date null, 
Location nvarchar(200) null, 
Country nvarchar(200) null, 
Latitude nvarchar(200) null, 
Longitude nvarchar(200) null, 
Airport_Code nvarchar(200) null, 
Airport_Name nvarchar(200) null, 
Injury_Severity nvarchar(200) null, 
Aircraft_damage nvarchar(200) null, 
Aircraft_Category nvarchar(200) null, 
Registration_Number nvarchar(200) null, 
Make nvarchar(200) null, 
Model nvarchar(200) null, 
Amateur_Built nvarchar(200) null , 
Number_of_Engines nvarchar(200) null, 
Engine_Type nvarchar(200) null, 
FAR_Description nvarchar(200) null, 
Schedule nvarchar(200) null, 
Purpose_of_Flight nvarchar(200) null, 
Air_carrier nvarchar(200) null,
Total_Fatal_Injuries nvarchar(200) null, 
Total_Serious_Injuries nvarchar(200) null, 
Total_Minor_Injuries nvarchar(200) null, 
Total_Uninjured nvarchar(200) null,
Weather_Condition nvarchar(200) null,
Broad_phase_of_flight nvarchar(200) null,
Report_Status nvarchar(200) null,
Publication_Date nvarchar(200) null,
Accident_Id int not null,
Place_Id int not null,
Plane_Id int not null
);

CREATE TABLE [dbo].[DIM_ACCIDENT1](
	[Id] [int] NOT NULL,
	[Investigation_Type] [nvarchar](50) NOT NULL,
	[Injury_Severity] [nvarchar](15) NULL,
	[Aircraft_Damage] [nvarchar](15) NULL,
	[FAR_Description] [nvarchar](200) NULL,
	[Schedule] [nvarchar](10) NULL,
	[Purpose_Of_Flight] [nvarchar](50) NULL,
	[Air_Carrier] [nvarchar](100) NULL,
	[Broad_Phase_Of_Flight] [nvarchar](20) NULL
);

CREATE TABLE [dbo].[DIM_CONDITIONS1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Weather_Condition] [nvarchar](50) NOT NULL,
	[Weather_Condition_Code] [nvarchar](10) NOT NULL
);

CREATE TABLE [dbo].[DIM_PLACE1](
	[Id] [int] NOT NULL,
	[Location] [nvarchar](60) NOT NULL,
	[Country] [nvarchar](30) NOT NULL,
	[Region] [nvarchar](15) NULL,
	[Airport_Code] [nvarchar](10) NULL,
	[Airport_Name] [nvarchar](100) NULL,
	[Region_Code] [nvarchar](5) NULL
);

CREATE TABLE [dbo].[DIM_PLANE1](
	[Id] [int] NOT NULL,
	[Make] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Amateur_Built] [nvarchar](50) NULL,
	[Number_Of_Engines] [int] NULL,
	[Engine_Type] [nvarchar](50) NULL,
	[Aircraft_Category] [nvarchar](15) NULL
);

CREATE TABLE [dbo].[DIM_TIME1](
	[PK_TIME] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Month_In_Words] [nvarchar](15) NOT NULL,
	[Day] [int] NOT NULL,
	[Day_In_Words] [nvarchar](15) NOT NULL
)

CREATE TABLE [dbo].[FACT_ACCIDENTS1](
	[Accident_Id] [int] NOT NULL,
	[Event_Date] [int] NOT NULL,
	[Place_Id] [int] NOT NULL,
	[Plane_Id] [int] NOT NULL,
	[Weather_Conditions_Id] [int] NOT NULL,
	[Total_Fatal_Injuries] [int] NOT NULL,
	[Total_Serious_Injuries] [int] NOT NULL,
	[Total_Minor_Injuries] [int] NOT NULL,
	[Total_Uninjured] [int] NOT NULL,
	[Total_Injured] [int] NOT NULL,
	[Mortality] [decimal](18, 15) NOT NULL
);

--REFERENCES
ALTER TABLE DIM_CONDITIONS1
ADD CONSTRAINT CONDITIONS1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLACE1
ADD CONSTRAINT PLACE1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLANE1
ADD CONSTRAINT PLANE1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_TIME1
ADD CONSTRAINT TIME1_PRIMARY_KEY UNIQUE(PK_TIME), PRIMARY KEY(PK_TIME);

ALTER TABLE DIM_ACCIDENT1
ADD CONSTRAINT ACCIDENT1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE FACT_ACCIDENTS1
ADD CONSTRAINT CONDITIONS1_FOREIGN_KEY FOREIGN KEY (Weather_Conditions_Id) REFERENCES DIM_CONDITIONS1(Id),
	CONSTRAINT PLANE1_FOREIGN_KEY FOREIGN KEY (Plane_Id) REFERENCES DIM_PLANE1(Id),
	CONSTRAINT PLACE1_FOREIGN_KEY FOREIGN KEY (Place_Id) REFERENCES DIM_PLACE1(Id),
	CONSTRAINT ACCIDENT1_FOREIGN_KEY FOREIGN KEY (Accident_Id) REFERENCES DIM_ACCIDENT1(Id),
	CONSTRAINT EVENT_DATE1_FOREIGN_KEY FOREIGN KEY (Event_Date) REFERENCES DIM_TIME1(PK_TIME);


WITH Av2 (Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date, Accident_Id, Place_Id, Plane_Id)
AS (
SELECT Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, 
Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date, 
RANK() OVER (ORDER BY Investigation_Type, Injury_Severity, Aircraft_damage, 
	FAR_Description, Schedule, Purpose_of_flight, 
	Air_carrier, 
	Broad_phase_of_flight) Accident_Id,
RANK() OVER (ORDER BY Location, Country, Airport_Code, Airport_Name) Place_Id,
RANK() OVER (ORDER BY Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category) Plane_Id
FROM Aviation_Data1
)
INSERT INTO Aviation_Data2(Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date, Accident_Id, Place_Id, Plane_Id)
SELECT * FROM Av2;

WITH Av3 (Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date, Accident_Id, Place_Id, Plane_Id)
AS (
SELECT *
FROM Aviation_Data1
)
INSERT INTO Aviation_Data2(Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date, Accident_Id, Place_Id, Plane_Id)
SELECT * FROM Av3;

ALTER TABLE Aviation_Data2
ALTER COLUMN Event_Date DATE;

ALTER TABLE Aviation_Data2
ALTER COLUMN Number_of_Engines int;

ALTER TABLE Aviation_Data2
ALTER COLUMN Total_Fatal_Injuries int;

ALTER TABLE Aviation_Data2
ALTER COLUMN Total_Serious_Injuries int;

ALTER TABLE Aviation_Data2
ALTER COLUMN Total_Minor_Injuries int;

ALTER TABLE Aviation_Data2
ALTER COLUMN Total_Uninjured int;

WITH Accident1 (Id, Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
AS (
	SELECT DISTINCT Accident_Id,
	Investigation_Type, Injury_Severity, Aircraft_damage, 
	FAR_Description, Schedule, Purpose_of_flight, 
	Air_carrier, 
	Broad_phase_of_flight
	FROM Aviation_Data2
) INSERT INTO DIM_ACCIDENT1 (Id, Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
SELECT * FROM Accident1;

WITH Place1 (Id, [Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
AS (
	SELECT DISTINCT Place_Id,
	 Location, Country, US_State, Airport_Code, Airport_Name, 
CASE 
	WHEN SUBSTRING([Location], LEN([Location]) - 2, 1)='-' THEN SUBSTRING([Location], LEN([Location]) - 1, 2)
	END
	FROM Aviation_Data2
	LEFT JOIN USState_Codes ON USState_Codes.Abbreviation = SUBSTRING([Location], LEN([Location]) - 1, 2)
) INSERT INTO DIM_PLACE1 (Id, [Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
SELECT * FROM Place1;

WITH Plane1 (Id, Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
AS (
	SELECT DISTINCT Plane_Id,
	Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category
	FROM Aviation_Data2
) INSERT INTO DIM_PLANE1 (Id, Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
SELECT * FROM Plane1;

WITH Conditions1 (Weather_Condition, Weather_Condition_Code)
AS (
	 SELECT CASE
		WHEN Weather_Conditions = 'VMC' THEN 'Good conditions'
		WHEN Weather_Conditions = 'UNK' OR Weather_Conditions='' THEN 'Unknown conditions'
		WHEN Weather_Conditions = 'IMC' THEN 'Bad conditions'
	END,
	Weather_Conditions
	FROM
	(
		SELECT DISTINCT
		CASE
			WHEN Weather_Condition = 'VMC' THEN 'VMC'
			WHEN Weather_Condition = 'UNK' OR Weather_Condition='' THEN 'UNK'
			WHEN Weather_Condition = 'IMC' THEN 'IMC'
		END Weather_Conditions
		FROM Aviation_Data2
	) A
) INSERT INTO DIM_CONDITIONS1 (Weather_Condition, Weather_Condition_Code)
SELECT * FROM Conditions1;

DECLARE @D INT;
SET @D = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data2 ORDER BY 1);
DECLARE @COUNTER DATE;
SET @COUNTER = CONVERT(date, CAST(@D AS nvarchar));
DECLARE @END INT;
SET @END = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data2 ORDER BY 1 DESC);
WHILE (@D <= @END)
BEGIN
	INSERT INTO DIM_TIME1 VALUES
(
	@D,
	YEAR(@COUNTER),
	DATEPART(QQ, @COUNTER),
	MONTH(@COUNTER),
	(SELECT Nazwa FROM Miesiace WHERE Numer = MONTH(@COUNTER)),
	DAY(@COUNTER),
	(SELECT Nazwa FROM Dni WHERE Numer = DATEPART(DW, @COUNTER))
);
	SET @COUNTER = DATEADD(DAY, 1, @COUNTER);
	SET @D = CAST(CONVERT(varchar(8), @COUNTER, 112) AS INT);
END;

WITH FactAccidents1 (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
AS (
	SELECT DIM_ACCIDENT1.Id Accident_Id, DIM_TIME1.PK_TIME, DIM_PLACE1.Id Place_Id, DIM_PLANE1.Id Plane_Id, DIM_CONDITIONS1.Id Weather_Conditions_Id,
	CASE
		WHEN Aviation_Data2.Total_Fatal_Injuries IS NULL THEN 0
		ELSE Aviation_Data2.Total_Fatal_Injuries
	END Fatal, 
	CASE
		WHEN Aviation_Data2.Total_Serious_Injuries IS NULL THEN 0
		ELSE Aviation_Data2.Total_Serious_Injuries
	END Serious, 
	CASE
		WHEN Aviation_Data2.Total_Minor_Injuries IS NULL THEN 0
		ELSE Aviation_Data2.Total_Minor_Injuries
	END Minor,
	CASE
		WHEN Aviation_Data2.Total_Uninjured IS NULL THEN 0
		ELSE Aviation_Data2.Total_Uninjured
	END Uninjured, 
	CASE WHEN Aviation_Data2.Total_Fatal_Injuries IS NULL THEN 0
	ELSE Aviation_Data2.Total_Fatal_Injuries END + 
	CASE WHEN Aviation_Data2.Total_Serious_Injuries IS NULL THEN 0
	ELSE Aviation_Data2.Total_Serious_Injuries END +
	CASE WHEN Aviation_Data2.Total_Minor_Injuries IS NULL THEN 0 
	ELSE Aviation_Data2.Total_Minor_Injuries END Injured, 
	CASE 
		WHEN Aviation_Data2.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data2.Total_Uninjured + Aviation_Data2.Total_Fatal_Injuries + Aviation_Data2.Total_Serious_Injuries + Aviation_Data2.Total_Minor_Injuries) IS NULL THEN 1
		WHEN (Aviation_Data2.Total_Uninjured + Aviation_Data2.Total_Fatal_Injuries + Aviation_Data2.Total_Serious_Injuries + Aviation_Data2.Total_Minor_Injuries) IS NULL 
		AND Aviation_Data2.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data2.Total_Uninjured + Aviation_Data2.Total_Fatal_Injuries + Aviation_Data2.Total_Serious_Injuries + Aviation_Data2.Total_Minor_Injuries)=0 THEN 1
		ELSE Aviation_Data2.Total_Fatal_Injuries * 1.0 /((Aviation_Data2.Total_Uninjured + Aviation_Data2.Total_Serious_Injuries + Aviation_Data2.Total_Minor_Injuries + Aviation_Data2.Total_Fatal_Injuries))
	END
	FROM Aviation_Data2
	JOIN DIM_ACCIDENT1 ON DIM_ACCIDENT1.Id = Aviation_Data2.Accident_Id
	JOIN DIM_TIME1 ON DIM_TIME1.PK_TIME = DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date)
	JOIN DIM_PLACE1 ON DIM_PLACE1.Id = Aviation_Data2.Place_Id
	JOIN DIM_PLANE1 ON DIM_PLANE1.Id = Aviation_Data2.Plane_Id
	JOIN DIM_CONDITIONS1 ON DIM_CONDITIONS1.Weather_Condition_Code = Aviation_Data2.Weather_Condition
) INSERT INTO FACT_ACCIDENTS1 (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
SELECT * FROM FactAccidents1;


--UPDATE
--DIM_ACCIDENT
UPDATE DIM_ACCIDENT1
SET Aircraft_Damage='Unknown'
WHERE Aircraft_Damage='';

UPDATE DIM_ACCIDENT1
SET FAR_Description='Unknown'
WHERE FAR_Description='';

UPDATE DIM_ACCIDENT1
SET Purpose_Of_Flight='Unknown'
WHERE Purpose_Of_Flight='';

UPDATE DIM_ACCIDENT1
SET Air_Carrier='Unknown'
WHERE Air_Carrier='';

UPDATE DIM_ACCIDENT1
SET Broad_Phase_Of_Flight='Unknown'
WHERE Broad_Phase_Of_Flight='';

--DIM_PLACE
UPDATE DIM_PLACE1
SET Country='Unknown'
WHERE Country='';

UPDATE DIM_PLACE1
SET Airport_Code='UNK'
WHERE Airport_Code='';

UPDATE DIM_PLACE1
SET Airport_Name='Unknown'
WHERE Airport_Name='';

UPDATE DIM_PLACE1
SET Region_Code='UNK'
WHERE Region_Code IS NULL;

UPDATE DIM_PLACE1
SET Region='Unknown'
WHERE Region IS NULL;

--DIM_PLANE
UPDATE DIM_PLANE1
SET Make='Unknown'
WHERE Make='';

UPDATE DIM_PLANE1
SET Model='Unknown'
WHERE Model='';

UPDATE DIM_PLANE1
SET Amateur_Built='Unk'
WHERE Amateur_Built='';

UPDATE DIM_PLANE1
SET Engine_Type='Unknown'
WHERE Engine_Type='';

UPDATE DIM_PLANE1
SET Number_Of_Engines = -1
WHERE Number_Of_Engines IS NULL;

UPDATE DIM_PLANE1
SET Aircraft_Category='Unknown'
WHERE Aircraft_Category='';

UPDATE DIM_PLACE1
SET Location=Country
WHERE Location='';

SELECT DISTINCT *
FROM DIM_PLANE1
WHERE Aircraft_Category LIKE '%Unknown%'
AND Make LIKE '%Unknown%';

SELECT COUNT(*) FROM Aviation_Data2 WHERE Plane_Id=2;

SELECT * FROM Aviation_Data;

SELECT DISTINCT Air_Carrier FROM Aviation_Data ORDER BY 1;
SELECT DISTINCT Air_Carrier FROM DIM_ACCIDENT1 ORDER BY 1;

SELECT DISTINCT Report_Status FROM Aviation_Data;

DELETE FROM Aviation_Data2
WHERE Make = '' AND Model='' AND Amateur_Built='' AND Number_of_Engines IS NULL AND Engine_Type='' AND Aircraft_Category='';

--new
SELECT DISTINCT Air_Carrier FROM DIM_ACCIDENT ORDER BY Air_Carrier;
SELECT DISTINCT Air_Carrier FROM DIM_ACCIDENT1 ORDER BY Air_Carrier;

SELECT DISTINCT Make FROM DIM_PLANE ORDER BY Make;
SELECT DISTINCT Make FROM DIM_PLANE1 ORDER BY Make;

SELECT DISTINCT Model FROM DIM_PLANE1;
SELECT DISTINCT Number_Of_Engines FROM DIM_PLANE1;
SELECT DISTINCT Engine_Type FROM DIM_PLANE1;
SELECT DISTINCT Aircraft_Category FROM DIM_PLANE1;
SELECT * FROM DIM_PLANE1;

SELECT COUNT(*) FROM DIM_PLANE1;
SELECT * FROM DIM_PLANE1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Aviation_Data1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Aviation_Data1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FACT_ACCIDENTS1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE FACT_ACCIDENTS1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_CONDITIONS1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_CONDITIONS1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLACE1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLACE1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLANE1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLANE1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_TIME1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_TIME1;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_ACCIDENT1' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_ACCIDENT1;

--CREATE TABLES
CREATE TABLE Aviation_Data1
(
Event_Id nvarchar(200) null, 
Investigation_Type nvarchar(200) null, 
Accident_Number nvarchar(200) null, 
Event_Date date null, 
Location nvarchar(200) null, 
Country nvarchar(200) null, 
Latitude nvarchar(200) null, 
Longitude nvarchar(200) null, 
Airport_Code nvarchar(200) null, 
Airport_Name nvarchar(200) null, 
Injury_Severity nvarchar(200) null, 
Aircraft_damage nvarchar(200) null, 
Aircraft_Category nvarchar(200) null, 
Registration_Number nvarchar(200) null, 
Make nvarchar(200) null, 
Model nvarchar(200) null, 
Amateur_Built nvarchar(200) null , 
Number_of_Engines nvarchar(200) null, 
Engine_Type nvarchar(200) null, 
FAR_Description nvarchar(200) null, 
Schedule nvarchar(200) null, 
Purpose_of_Flight nvarchar(200) null, 
Air_carrier nvarchar(200) null,
Total_Fatal_Injuries nvarchar(200) null, 
Total_Serious_Injuries nvarchar(200) null, 
Total_Minor_Injuries nvarchar(200) null, 
Total_Uninjured nvarchar(200) null,
Weather_Condition nvarchar(200) null,
Broad_phase_of_flight nvarchar(200) null,
Report_Status nvarchar(200) null,
Publication_Date nvarchar(200) null
);


CREATE TABLE [dbo].[DIM_ACCIDENT1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Investigation_Type] [nvarchar](50) NOT NULL,
	[Injury_Severity] [nvarchar](15) NULL,
	[Aircraft_Damage] [nvarchar](15) NULL,
	[FAR_Description] [nvarchar](200) NULL,
	[Schedule] [nvarchar](10) NULL,
	[Purpose_Of_Flight] [nvarchar](50) NULL,
	[Air_Carrier] [nvarchar](100) NULL,
	[Broad_Phase_Of_Flight] [nvarchar](20) NULL
);

CREATE TABLE [dbo].[DIM_CONDITIONS1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Weather_Condition] [nvarchar](50) NOT NULL,
	[Weather_Condition_Code] [nvarchar](10) NOT NULL
);

CREATE TABLE [dbo].[DIM_PLACE1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](60) NOT NULL,
	[Country] [nvarchar](30) NOT NULL,
	[Region] [nvarchar](15) NULL,
	[Airport_Code] [nvarchar](10) NULL,
	[Airport_Name] [nvarchar](100) NULL,
	[Region_Code] [nvarchar](5) NULL
);

CREATE TABLE [dbo].[DIM_PLANE1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Make] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Amateur_Built] [nvarchar](50) NULL,
	[Number_Of_Engines] [int] NULL,
	[Engine_Type] [nvarchar](50) NULL,
	[Aircraft_Category] [nvarchar](15) NULL
);

CREATE TABLE [dbo].[DIM_TIME1](
	[PK_TIME] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Month_In_Words] [nvarchar](15) NOT NULL,
	[Day] [int] NOT NULL,
	[Day_In_Words] [nvarchar](15) NOT NULL
)

CREATE TABLE [dbo].[FACT_ACCIDENTS1](
	[Accident_Id] [int] NOT NULL,
	[Event_Date] [int] NOT NULL,
	[Place_Id] [int] NOT NULL,
	[Plane_Id] [int] NOT NULL,
	[Weather_Conditions_Id] [int] NOT NULL,
	[Total_Fatal_Injuries] [int] NOT NULL,
	[Total_Serious_Injuries] [int] NOT NULL,
	[Total_Minor_Injuries] [int] NOT NULL,
	[Total_Uninjured] [int] NOT NULL,
	[Total_Injured] [int] NOT NULL,
	[Mortality] [decimal](18, 15) NOT NULL
);

--REFERENCES
ALTER TABLE DIM_CONDITIONS1
ADD CONSTRAINT CONDITIONS1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLACE1
ADD CONSTRAINT PLACE1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLANE1
ADD CONSTRAINT PLANE1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_TIME1
ADD CONSTRAINT TIME1_PRIMARY_KEY UNIQUE(PK_TIME), PRIMARY KEY(PK_TIME);

ALTER TABLE DIM_ACCIDENT1
ADD CONSTRAINT ACCIDENT1_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE FACT_ACCIDENTS1
ADD CONSTRAINT CONDITIONS1_FOREIGN_KEY FOREIGN KEY (Weather_Conditions_Id) REFERENCES DIM_CONDITIONS1(Id),
	CONSTRAINT PLANE1_FOREIGN_KEY FOREIGN KEY (Plane_Id) REFERENCES DIM_PLANE1(Id),
	CONSTRAINT PLACE1_FOREIGN_KEY FOREIGN KEY (Place_Id) REFERENCES DIM_Place1(Id),
	CONSTRAINT ACCIDENT1_FOREIGN_KEY FOREIGN KEY (Accident_Id) REFERENCES DIM_ACCIDENT1(Id),
	CONSTRAINT EVENT_DATE1_FOREIGN_KEY FOREIGN KEY (Event_Date) REFERENCES DIM_TIME1(PK_TIME);



SELECT * FROM Aviation_Data;
WITH Av2 (Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date)
AS (
SELECT * FROM Aviation_Data1
)
INSERT INTO Aviation_Data1 (Event_Id, Investigation_Type, Accident_Number, Event_Date, Location, Country, Latitude, Longitude, Airport_Code, Airport_Name, Injury_Severity, Aircraft_damage, 
Aircraft_Category, Registration_Number, Make, Model, Amateur_Built, Number_of_Engines, Engine_Type, FAR_Description, Schedule, Purpose_of_Flight, Air_carrier, Total_Fatal_Injuries, 
Total_Serious_Injuries, Total_Minor_Injuries, Total_Uninjured, Weather_Condition, Broad_phase_of_flight, Report_Status, Publication_Date)
SELECT * FROM Av2;

ALTER TABLE Aviation_Data1
ALTER COLUMN Event_Date DATE;

ALTER TABLE Aviation_Data1
ALTER COLUMN Number_of_Engines int;

ALTER TABLE Aviation_Data1
ALTER COLUMN Total_Fatal_Injuries int;

ALTER TABLE Aviation_Data1
ALTER COLUMN Total_Serious_Injuries int;

ALTER TABLE Aviation_Data1
ALTER COLUMN Total_Minor_Injuries int;

ALTER TABLE Aviation_Data1
ALTER COLUMN Total_Uninjured int;

WITH Accident1 (Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
AS (
	SELECT Investigation_Type, Injury_Severity, Aircraft_damage, FAR_Description, Schedule, Purpose_of_flight, Air_carrier, Broad_phase_of_flight
FROM
(
	SELECT DISTINCT Investigation_Type, Injury_Severity, Aircraft_damage, 
	FAR_Description, Schedule, Purpose_of_flight, 
	Air_carrier, 
	Broad_phase_of_flight
	FROM Aviation_Data1
) P
) INSERT INTO DIM_ACCIDENT1 (Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
SELECT * FROM Accident1;

WITH Place1 ([Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
AS (
	SELECT DISTINCT 
	 Location, Country, US_State, Airport_Code, Airport_Name, 
CASE 
	WHEN SUBSTRING([Location], LEN([Location]) - 2, 1)='-' THEN SUBSTRING([Location], LEN([Location]) - 1, 2)
	END
	FROM Aviation_Data1
	LEFT JOIN USState_Codes ON USState_Codes.Abbreviation = SUBSTRING([Location], LEN([Location]) - 1, 2)
) INSERT INTO DIM_PLACE1 ([Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
SELECT * FROM Place1;

WITH Plane1 (Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
AS (
	SELECT DISTINCT Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category
	FROM Aviation_Data1
) INSERT INTO DIM_PLANE1 (Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
SELECT * FROM Plane1;

WITH Conditions1 (Weather_Condition, Weather_Condition_Code)
AS (
	 SELECT CASE
		WHEN Weather_Conditions = 'VMC' THEN 'Good conditions'
		WHEN Weather_Conditions = 'UNK' OR Weather_Conditions='' THEN 'Unknown conditions'
		WHEN Weather_Conditions = 'IMC' THEN 'Bad conditions'
	END,
	Weather_Conditions
	FROM
	(
		SELECT DISTINCT
		CASE
			WHEN Weather_Condition = 'VMC' THEN 'VMC'
			WHEN Weather_Condition = 'UNK' OR Weather_Condition='' THEN 'UNK'
			WHEN Weather_Condition = 'IMC' THEN 'IMC'
		END Weather_Conditions
		FROM Aviation_Data1
	) A
) INSERT INTO DIM_CONDITIONS1 (Weather_Condition, Weather_Condition_Code)
SELECT * FROM Conditions1;

DECLARE @D INT;
SET @D = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data1 ORDER BY 1);
DECLARE @COUNTER DATE;
SET @COUNTER = CONVERT(date, CAST(@D AS nvarchar));
DECLARE @END INT;
SET @END = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data1 ORDER BY 1 DESC);
WHILE (@D <= @END)
BEGIN
	INSERT INTO DIM_TIME1 VALUES
(
	@D,
	YEAR(@COUNTER),
	DATEPART(QQ, @COUNTER),
	MONTH(@COUNTER),
	(SELECT Nazwa FROM Miesiace WHERE Numer = MONTH(@COUNTER)),
	DAY(@COUNTER),
	(SELECT Nazwa FROM Dni WHERE Numer = DATEPART(DW, @COUNTER))
);
	SET @COUNTER = DATEADD(DAY, 1, @COUNTER);
	SET @D = CAST(CONVERT(varchar(8), @COUNTER, 112) AS INT);
END;

WITH FactAccidents1 (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
AS (
	SELECT DISTINCT DIM_ACCIDENT1.Id, DIM_TIME1.PK_TIME, DIM_PLACE1.Id, DIM_PLANE1.Id, DIM_CONDITIONS1.Id, 
	CASE
		WHEN Aviation_Data1.Total_Fatal_Injuries IS NULL THEN 0
		ELSE Aviation_Data1.Total_Fatal_Injuries
	END Fatal, 
	CASE
		WHEN Aviation_Data1.Total_Serious_Injuries IS NULL THEN 0
		ELSE Aviation_Data1.Total_Serious_Injuries
	END Serious, 
	CASE
		WHEN Aviation_Data1.Total_Minor_Injuries IS NULL THEN 0
		ELSE Aviation_Data1.Total_Minor_Injuries
	END Minor,
	CASE
		WHEN Aviation_Data1.Total_Uninjured IS NULL THEN 0
		ELSE Aviation_Data1.Total_Uninjured
	END Uninjured, 
	CASE WHEN Aviation_Data1.Total_Fatal_Injuries IS NULL THEN 0
	ELSE Aviation_Data1.Total_Fatal_Injuries END + 
	CASE WHEN Aviation_Data1.Total_Serious_Injuries IS NULL THEN 0
	ELSE Aviation_Data1.Total_Serious_Injuries END +
	CASE WHEN Aviation_Data1.Total_Minor_Injuries IS NULL THEN 0 
	ELSE Aviation_Data1.Total_Minor_Injuries END Injured, 
	CASE 
		WHEN Aviation_Data1.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data1.Total_Uninjured + Aviation_Data1.Total_Fatal_Injuries + Aviation_Data1.Total_Serious_Injuries + Aviation_Data1.Total_Minor_Injuries) IS NULL THEN 1
		WHEN (Aviation_Data1.Total_Uninjured + Aviation_Data1.Total_Fatal_Injuries + Aviation_Data1.Total_Serious_Injuries + Aviation_Data1.Total_Minor_Injuries) IS NULL 
		AND Aviation_Data1.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data1.Total_Uninjured + Aviation_Data1.Total_Fatal_Injuries + Aviation_Data1.Total_Serious_Injuries + Aviation_Data1.Total_Minor_Injuries)=0 THEN 1
		ELSE Aviation_Data1.Total_Fatal_Injuries * 1.0 /((Aviation_Data1.Total_Uninjured + Aviation_Data1.Total_Serious_Injuries + Aviation_Data1.Total_Minor_Injuries + Aviation_Data1.Total_Fatal_Injuries))
	END
	FROM Aviation_Data1
	JOIN DIM_ACCIDENT1 ON CONCAT(Aviation_Data1.Investigation_Type, Aviation_Data1.Injury_Severity, Aviation_Data1.Aircraft_Damage, Aviation_Data1.FAR_Description, Aviation_Data1.Schedule, Aviation_Data1.Purpose_Of_Flight, Aviation_Data1.Air_Carrier, Aviation_Data1.Broad_Phase_Of_Flight) = CONCAT(DIM_ACCIDENT1.Investigation_Type, DIM_ACCIDENT1.Injury_Severity, DIM_ACCIDENT1.Aircraft_Damage, DIM_ACCIDENT1.FAR_Description, DIM_ACCIDENT1.Schedule, DIM_ACCIDENT1.Purpose_Of_Flight, DIM_ACCIDENT1.Air_Carrier, DIM_ACCIDENT1.Broad_Phase_Of_Flight)
	JOIN DIM_TIME1 ON DIM_TIME1.PK_TIME = DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date)
	JOIN DIM_PLACE1 ON CONCAT(DIM_PLACE1.Location, DIM_PLACE1.Country, DIM_PLACE1.Airport_Code, DIM_PLACE1.Airport_Name) = CONCAT(Aviation_Data1.Location, Aviation_Data1.Country, Aviation_Data1.Airport_Code, Aviation_Data1.Airport_Name)
	JOIN DIM_PLANE1 ON CONCAT(DIM_PLANE1.Make, DIM_PLANE1.Model, DIM_PLANE1.Amateur_Built, CAST(DIM_PLANE1.Number_Of_Engines AS nvarchar(2)), DIM_PLANE1.Engine_Type, DIM_PLANE1.Aircraft_Category) = CONCAT(Aviation_Data1.Make, Aviation_Data1.Model, Aviation_Data1.Amateur_Built, CAST(Aviation_Data1.Number_Of_Engines AS nvarchar(2)), Aviation_Data1.Engine_Type, Aviation_Data1.Aircraft_Category)
	JOIN DIM_CONDITIONS1 ON DIM_CONDITIONS1.Weather_Condition_Code = Aviation_Data1.Weather_Condition
) INSERT INTO FACT_ACCIDENTS1 (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
SELECT * FROM FactAccidents1;

SELECT * FROM FACT_ACCIDENTS1;
SELECT * FROM Aviation_Data1;
SELECT * FROM DIM_ACCIDENT1;
SELECT DISTINCT CONCAT(Aviation_Data1.Investigation_Type, Aviation_Data1.Injury_Severity, Aviation_Data1.Aircraft_Damage, Aviation_Data1.FAR_Description, Aviation_Data1.Schedule, Aviation_Data1.Purpose_Of_Flight, Aviation_Data1.Air_Carrier, Aviation_Data1.Broad_Phase_Of_Flight) FROM Aviation_Data1;


--UPDATE
--DIM_ACCIDENT
UPDATE DIM_ACCIDENT1
SET Aircraft_Damage='Unknown'
WHERE Aircraft_Damage='';

UPDATE DIM_ACCIDENT1
SET FAR_Description='Unknown'
WHERE FAR_Description='';

UPDATE DIM_ACCIDENT1
SET Purpose_Of_Flight='Unknown'
WHERE Purpose_Of_Flight='';

UPDATE DIM_ACCIDENT1
SET Air_Carrier='Unknown'
WHERE Air_Carrier='';

UPDATE DIM_ACCIDENT1
SET Broad_Phase_Of_Flight='Unknown'
WHERE Broad_Phase_Of_Flight='';

--DIM_PLACE
UPDATE DIM_PLACE1
SET Country='Unknown'
WHERE Country='';

UPDATE DIM_PLACE1
SET Airport_Code='UNK'
WHERE Airport_Code='';

UPDATE DIM_PLACE1
SET Airport_Name='Unknown'
WHERE Airport_Name='';

UPDATE DIM_PLACE1
SET Region_Code='UNK'
WHERE Region_Code IS NULL;

UPDATE DIM_PLACE1
SET Region='Unknown'
WHERE Region IS NULL;

--DIM_PLANE
UPDATE DIM_PLANE1
SET Make='Unknown'
WHERE Make='';

UPDATE DIM_PLANE1
SET Model='Unknown'
WHERE Model='';

UPDATE DIM_PLANE1
SET Amateur_Built='Unk'
WHERE Amateur_Built='';

UPDATE DIM_PLANE1
SET Engine_Type='Unknown'
WHERE Engine_Type='';

UPDATE DIM_PLANE1
SET Aircraft_Category='Unknown'
WHERE Aircraft_Category='';

UPDATE DIM_PLACE1
SET Location=Country
WHERE Location='';

SELECT * FROM Aviation_Data1;
SELECT * FROM DIM_PLANE1;
SELECT * FROM DIM_ACCIDENT1 WHERE Air_Carrier='' ORDER BY Air_Carrier;
SELECT * FROM DIM_ACCIDENT WHERE Air_Carrier='' ORDER BY Air_Carrier;
SELECT COUNT(*) FROM Aviation_Data1;
SELECT COUNT(*) FROM Aviation_Data2;
SELECT COUNT(*) FROM DIM_ACCIDENT1;
SELECT COUNT(*) FROM DIM_CONDITIONS1;
SELECT COUNT(*) FROM DIM_PLACE1;
SELECT COUNT(*) FROM DIM_PLANE1;
SELECT COUNT(*) FROM DIM_TIME1;
SELECT COUNT(*) FROM FACT_ACCIDENTS1;

SELECT DISTINCT Id FROM DIM_ACCIDENT1;
SELECT Id FROM DIM_CONDITIONS1;
SELECT DISTINCT Id FROM DIM_PLACE1;
SELECT Id FROM DIM_PLANE1;
SELECT * FROM DIM_TIME1;
SELECT * FROM FACT_ACCIDENTS1;


--delete wrong
DELETE FROM Aviation_Data
WHERE ISNUMERIC(Latitude) != 1 AND Latitude IS NOT NULL;

DELETE FROM Aviation_Data
WHERE ISNUMERIC(Number_of_Engines) != 1 AND Number_of_Engines IS NOT NULL;

DELETE FROM Aviation_Data
WHERE ISNUMERIC(Total_Fatal_Injuries)!=1 AND Total_Fatal_Injuries IS NOT NULL;

DELETE FROM Aviation_Data
WHERE ISNUMERIC(Weather_Condition) = 1;

SELECT DISTINCT(Weather_Condition) FROM Aviation_Data
WHERE Weather_Condition = '';

--repair
UPDATE Aviation_Data
SET Weather_Condition='UNK'
WHERE Weather_Condition='';

UPDATE Aviation_Data
SET FAR_Description = SUBSTRING(Aviation_Data.FAR_Description, 2, LEN(Aviation_Data.FAR_Description) - 3)
WHERE Aviation_Data.FAR_Description LIKE '"%"';

UPDATE Aviation_Data
SET Air_carrier = SUBSTRING(Aviation_Data.Air_carrier, 3, LEN(Aviation_Data.Air_carrier) - 4)
WHERE Aviation_Data.Air_carrier LIKE '"(%)"';

UPDATE Aviation_Data
SET Air_carrier = SUBSTRING(Aviation_Data.Air_carrier, 7, LEN(Aviation_Data.Air_carrier) - 7)
WHERE Aviation_Data.Air_carrier LIKE '(dba: %)';

UPDATE Aviation_Data
SET Air_carrier = SUBSTRING(Aviation_Data.Air_carrier, 2, LEN(Aviation_Data.Air_carrier) - 2)
WHERE Aviation_Data.Air_carrier LIKE '"%)"';

UPDATE Aviation_Data
SET Air_carrier = SUBSTRING(Aviation_Data.Air_carrier, 2, LEN(Aviation_Data.Air_carrier) - 3)
WHERE Aviation_Data.Air_carrier LIKE '"%"' OR Aviation_Data.Air_carrier LIKE '(%)';

UPDATE Aviation_Data
SET Aviation_Data.Location = SUBSTRING(Aviation_Data.Location, 2, LEN(Aviation_Data.Location) - 2)
WHERE Aviation_Data.Location LIKE '"%"';

UPDATE Aviation_Data
SET Latitude = NULL
WHERE Latitude = '';

UPDATE Aviation_Data
SET Longitude = NULL
WHERE Longitude = '';

UPDATE Aviation_Data
SET Number_of_Engines = NULL
WHERE Number_of_Engines = '';

UPDATE Aviation_Data
SET Total_Fatal_Injuries = NULL
WHERE Total_Fatal_Injuries = '';

UPDATE Aviation_Data
SET Total_Serious_Injuries = NULL
WHERE Total_Serious_Injuries = '';

UPDATE Aviation_Data
SET Total_Minor_Injuries = NULL
WHERE Total_Minor_Injuries = '';

UPDATE Aviation_Data
SET Total_Uninjured = NULL
WHERE Total_Uninjured = '';

UPDATE Aviation_Data
SET Publication_Date = NULL
WHERE Publication_Date = '';

SELECT * FROM Aviation_Data
WHERE Publication_Date NOT LIKE '__-__-____';
--WHERE ISNUMERIC(Number_of_Engines) = 1 OR Number_of_Engines='';
SELECT SUBSTRING('ARIZONA CITY-AZ', LEN('ARIZONA CITY-AZ') - 2, 1)
SELECT SUBSTRING('ARIZONA CITY-AZ', LEN('ARIZONA CITY-AZ') - 1, 2)

SET DATEFORMAT dmy;

SELECT * FROM Aviation_Data
WHERE ISDATE(Publication_Date)=1;

SELECT * FROM Aviation_Data
WHERE Publication_Date is null;

--WHERE ISNUMERIC(Total_Uninjured) != 1
--WHERE ISNUMERIC(Total_Uninjured) != 1 AND Total_Uninjured!='';

DELETE FROM Aviation_Data
WHERE Publication_Date not LIKE '__-__-____' and Publication_Date IS NOT NULL;

--DROP TABLES
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FACT_ACCIDENTS' AND TABLE_SCHEMA = 'dbo')
DROP TABLE FACT_ACCIDENTS;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_CONDITIONS' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_CONDITIONS;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLACE' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLACE;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PLANE' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_PLANE;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_TIME' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_TIME;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_ACCIDENT' AND TABLE_SCHEMA = 'dbo')
DROP TABLE DIM_ACCIDENT;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Dni' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Dni;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Miesiace' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Miesiace;

--CREATE TABLES
CREATE TABLE [dbo].[DIM_ACCIDENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Investigation_Type] [nvarchar](50) NOT NULL,
	[Injury_Severity] [nvarchar](15) NULL,
	[Aircraft_Damage] [nvarchar](15) NULL,
	[FAR_Description] [nvarchar](200) NULL,
	[Schedule] [nvarchar](10) NULL,
	[Purpose_Of_Flight] [nvarchar](50) NULL,
	[Air_Carrier] [nvarchar](100) NULL,
	[Broad_Phase_Of_Flight] [nvarchar](20) NULL
);

CREATE TABLE [dbo].[DIM_CONDITIONS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Weather_Condition] [nvarchar](50) NOT NULL,
	[Weather_Condition_Code] [nvarchar](10) NOT NULL
);

CREATE TABLE [dbo].[DIM_PLACE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](60) NOT NULL,
	[Country] [nvarchar](30) NOT NULL,
	[Region] [nvarchar](15) NULL,
	[Airport_Code] [nvarchar](10) NULL,
	[Airport_Name] [nvarchar](100) NULL,
	[Region_Code] [nvarchar](5) NULL
);

CREATE TABLE [dbo].[DIM_PLANE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Make] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Amateur_Built] [nvarchar](50) NULL,
	[Number_Of_Engines] [int] NULL,
	[Engine_Type] [nvarchar](50) NULL,
	[Aircraft_Category] [nvarchar](15) NULL
);

CREATE TABLE [dbo].[DIM_TIME](
	[PK_TIME] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Month_In_Words] [nvarchar](15) NOT NULL,
	[Day] [int] NOT NULL,
	[Day_In_Words] [nvarchar](15) NOT NULL
)

CREATE TABLE [dbo].[FACT_ACCIDENTS](
	[Accident_Id] [int] NOT NULL,
	[Event_Date] [int] NOT NULL,
	[Place_Id] [int] NOT NULL,
	[Plane_Id] [int] NOT NULL,
	[Weather_Conditions_Id] [int] NOT NULL,
	[Total_Fatal_Injuries] [int] NOT NULL,
	[Total_Serious_Injuries] [int] NOT NULL,
	[Total_Minor_Injuries] [int] NOT NULL,
	[Total_Uninjured] [int] NOT NULL,
	[Total_Injured] [int] NOT NULL,
	[Mortality] [decimal](18, 15) NOT NULL
);

SET DATEFIRST 1;
SELECT DISTINCT DATEPART(dw, Event_Date) Numer,
	CASE 
		WHEN DATEPART(dw, Event_Date) = 1 THEN 'Poniedzialek'
		WHEN DATEPART(dw, Event_Date) = 2 THEN 'Wtorek'
		WHEN DATEPART(dw, Event_Date) = 3 THEN 'Sroda'
		WHEN DATEPART(dw, Event_Date) = 4 THEN 'Czwartek'
		WHEN DATEPART(dw, Event_Date) = 5 THEN 'Piatek'
		WHEN DATEPART(dw, Event_Date) = 6 THEN 'Sobota'
		WHEN DATEPART(dw, Event_Date) = 7 THEN 'Niedziela'
	END Nazwa
INTO Dni
FROM Aviation_Data;

SELECT DISTINCT MONTH(Event_Date) Numer,
	CASE 
		WHEN MONTH(Event_Date) = 1 THEN 'Styczen'
		WHEN MONTH(Event_Date) = 2 THEN 'Luty'
		WHEN MONTH(Event_Date) = 3 THEN 'Marzec'
		WHEN MONTH(Event_Date) = 4 THEN 'Kwiecien'
		WHEN MONTH(Event_Date) = 5 THEN 'Maj'
		WHEN MONTH(Event_Date) = 6 THEN 'Czerwiec'
		WHEN MONTH(Event_Date) = 7 THEN 'Lipiec'
		WHEN MONTH(Event_Date) = 8 THEN 'Sierpien'
		WHEN MONTH(Event_Date) = 9 THEN 'Wrzesien'
		WHEN MONTH(Event_Date) = 10 THEN 'Pazdziernik'
		WHEN MONTH(Event_Date) = 11 THEN 'Listopad'
		WHEN MONTH(Event_Date) = 12 THEN 'Grudzien'
	END Nazwa
INTO Miesiace
FROM Aviation_Data;

--REFERENCES
ALTER TABLE DIM_CONDITIONS
ADD CONSTRAINT CONDITIONS_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLACE
ADD CONSTRAINT PLACE_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_PLANE
ADD CONSTRAINT PLANE_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE DIM_TIME
ADD CONSTRAINT TIME_PRIMARY_KEY UNIQUE(PK_TIME), PRIMARY KEY(PK_TIME);

ALTER TABLE DIM_ACCIDENT
ADD CONSTRAINT ACCIDENT_PRIMARY_KEY UNIQUE(Id), PRIMARY KEY(Id);

ALTER TABLE FACT_ACCIDENTS
ADD CONSTRAINT CONDITIONS_FOREIGN_KEY FOREIGN KEY (Weather_Conditions_Id) REFERENCES DIM_CONDITIONS(Id),
	CONSTRAINT PLANE_FOREIGN_KEY FOREIGN KEY (Plane_Id) REFERENCES DIM_PLANE(Id),
	CONSTRAINT PLACE_FOREIGN_KEY FOREIGN KEY (Place_Id) REFERENCES DIM_Place(Id),
	CONSTRAINT ACCIDENT_FOREIGN_KEY FOREIGN KEY (Accident_Id) REFERENCES DIM_ACCIDENT(Id),
	CONSTRAINT EVENT_DATE_FOREIGN_KEY FOREIGN KEY (Event_Date) REFERENCES DIM_TIME(PK_TIME);

--INSERT
WITH Accident (Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
AS (
	SELECT Investigation_Type, Injury_Severity, Aircraft_damage, FAR_Description, Schedule, Purpose_of_flight, Air_carrier, Broad_phase_of_flight
FROM
(
	SELECT DISTINCT Investigation_Type, Injury_Severity, Aircraft_damage, 
	FAR_Description, Schedule, Purpose_of_flight, 
	Air_carrier, 
	Broad_phase_of_flight
	FROM Aviation_Data
) P
) INSERT INTO DIM_ACCIDENT (Investigation_Type, Injury_Severity, Aircraft_Damage, FAR_Description, Schedule, Purpose_Of_Flight, Air_Carrier, Broad_Phase_Of_Flight)
SELECT * FROM Accident;


WITH Place ([Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
AS (
	SELECT DISTINCT 
	 Location, Country, US_State, Airport_Code, Airport_Name, 
CASE 
	WHEN SUBSTRING([Location], LEN([Location]) - 2, 1)='-' THEN SUBSTRING([Location], LEN([Location]) - 1, 2)
	END
	FROM Aviation_Data
	LEFT JOIN USState_Codes ON USState_Codes.Abbreviation = SUBSTRING([Location], LEN([Location]) - 1, 2)
) INSERT INTO DIM_PLACE ([Location], Country, Region, Airport_Code, Airport_Name, Region_Code)
SELECT * FROM Place;

WITH Plane (Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
AS (
	SELECT Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category
	FROM (
		SELECT DISTINCT Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category
		FROM Aviation_Data
	) A
) INSERT INTO DIM_PLANE (Make, Model, Amateur_Built, Number_Of_Engines, Engine_Type, Aircraft_Category)
SELECT * FROM Plane;

WITH Conditions (Weather_Condition, Weather_Condition_Code)
AS (
	 SELECT CASE
		WHEN Weather_Conditions = 'VMC' THEN 'Good conditions'
		WHEN Weather_Conditions = 'UNK' OR Weather_Conditions='' THEN 'Unknown conditions'
		WHEN Weather_Conditions = 'IMC' THEN 'Bad conditions'
	END,
	Weather_Conditions
	FROM
	(
		SELECT DISTINCT
		CASE
			WHEN Weather_Condition = 'VMC' THEN 'VMC'
			WHEN Weather_Condition = 'UNK' OR Weather_Condition='' THEN 'UNK'
			WHEN Weather_Condition = 'IMC' THEN 'IMC'
		END Weather_Conditions
		FROM Aviation_Data
	) A
) INSERT INTO DIM_CONDITIONS (Weather_Condition, Weather_Condition_Code)
SELECT * FROM Conditions;

DECLARE @D INT;
SET @D = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data ORDER BY 1);
DECLARE @COUNTER DATE;
SET @COUNTER = CONVERT(date, CAST(@D AS nvarchar));
DECLARE @END INT;
SET @END = (SELECT TOP 1 DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date) FROM Aviation_Data ORDER BY 1 DESC);
WHILE (@D <= @END)
BEGIN
	INSERT INTO DIM_TIME VALUES
(
	@D,
	YEAR(@COUNTER),
	DATEPART(QQ, @COUNTER),
	MONTH(@COUNTER),
	(SELECT Nazwa FROM Miesiace WHERE Numer = MONTH(@COUNTER)),
	DAY(@COUNTER),
	(SELECT Nazwa FROM Dni WHERE Numer = DATEPART(DW, @COUNTER))
);
	SET @COUNTER = DATEADD(DAY, 1, @COUNTER);
	SET @D = CAST(CONVERT(varchar(8), @COUNTER, 112) AS INT);
END;

WITH FactAccidents (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
AS (
	SELECT DISTINCT DIM_ACCIDENT.Id, DIM_TIME.PK_TIME, DIM_PLACE.Id, DIM_PLANE.Id, DIM_CONDITIONS.Id, 
	CASE
		WHEN Aviation_Data.Total_Fatal_Injuries IS NULL THEN 0
		ELSE Aviation_Data.Total_Fatal_Injuries
	END Fatal, 
	CASE
		WHEN Aviation_Data.Total_Serious_Injuries IS NULL THEN 0
		ELSE Aviation_Data.Total_Serious_Injuries
	END Serious, 
	CASE
		WHEN Aviation_Data.Total_Minor_Injuries IS NULL THEN 0
		ELSE Aviation_Data.Total_Minor_Injuries
	END Minor,
	CASE
		WHEN Aviation_Data.Total_Uninjured IS NULL THEN 0
		ELSE Aviation_Data.Total_Uninjured
	END Uninjured, 
	CASE WHEN Aviation_Data.Total_Fatal_Injuries IS NULL THEN 0
	ELSE Aviation_Data.Total_Fatal_Injuries END + 
	CASE WHEN Aviation_Data.Total_Serious_Injuries IS NULL THEN 0
	ELSE Aviation_Data.Total_Serious_Injuries END +
	CASE WHEN Aviation_Data.Total_Minor_Injuries IS NULL THEN 0 
	ELSE Aviation_Data.Total_Minor_Injuries END Injured, 
	CASE 
		WHEN Aviation_Data.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data.Total_Uninjured + Aviation_Data.Total_Fatal_Injuries + Aviation_Data.Total_Serious_Injuries + Aviation_Data.Total_Minor_Injuries) IS NULL THEN 1
		WHEN (Aviation_Data.Total_Uninjured + Aviation_Data.Total_Fatal_Injuries + Aviation_Data.Total_Serious_Injuries + Aviation_Data.Total_Minor_Injuries) IS NULL 
		AND Aviation_Data.Total_Fatal_Injuries IS NULL THEN 0
		WHEN (Aviation_Data.Total_Uninjured + Aviation_Data.Total_Fatal_Injuries + Aviation_Data.Total_Serious_Injuries + Aviation_Data.Total_Minor_Injuries)=0 THEN 1
		ELSE Aviation_Data.Total_Fatal_Injuries * 1.0 /((Aviation_Data.Total_Uninjured + Aviation_Data.Total_Serious_Injuries + Aviation_Data.Total_Minor_Injuries + Aviation_Data.Total_Fatal_Injuries))
	END
	FROM Aviation_Data
	JOIN DIM_ACCIDENT ON CONCAT(Aviation_Data.Investigation_Type, Aviation_Data.Injury_Severity, Aviation_Data.Aircraft_Damage, Aviation_Data.FAR_Description, Aviation_Data.Schedule, Aviation_Data.Purpose_Of_Flight, Aviation_Data.Air_Carrier, Aviation_Data.Broad_Phase_Of_Flight) = CONCAT(DIM_ACCIDENT.Investigation_Type, DIM_ACCIDENT.Injury_Severity, DIM_ACCIDENT.Aircraft_Damage, DIM_ACCIDENT.FAR_Description, DIM_ACCIDENT.Schedule, DIM_ACCIDENT.Purpose_Of_Flight, DIM_ACCIDENT.Air_Carrier, DIM_ACCIDENT.Broad_Phase_Of_Flight)
	JOIN DIM_TIME ON DIM_TIME.PK_TIME = DATEPART(YYYY, Event_Date) * 10000 + DATEPART(MM, Event_Date) * 100 + DATEPART(DD, Event_Date)
	JOIN DIM_PLACE ON CONCAT(DIM_PLACE.Location, DIM_PLACE.Country, DIM_PLACE.Airport_Code, DIM_PLACE.Airport_Name) = CONCAT(Aviation_Data.Location, Aviation_Data.Country, Aviation_Data.Airport_Code, Aviation_Data.Airport_Name)
	JOIN DIM_PLANE ON CONCAT(DIM_PLANE.Make, DIM_PLANE.Model, DIM_PLANE.Amateur_Built, CAST(DIM_PLANE.Number_Of_Engines AS nvarchar(2)), DIM_PLANE.Engine_Type, DIM_PLANE.Aircraft_Category) = CONCAT(Aviation_Data.Make, Aviation_Data.Model, Aviation_Data.Amateur_Built, CAST(Aviation_Data.Number_Of_Engines AS nvarchar(2)), Aviation_Data.Engine_Type, Aviation_Data.Aircraft_Category)
	JOIN DIM_CONDITIONS ON DIM_CONDITIONS.Weather_Condition_Code = Aviation_Data.Weather_Condition
) INSERT INTO FACT_ACCIDENTS (Accident_Id, Event_Date, Place_Id, Plane_Id, Weather_Conditions_Id, Total_Fatal_Injuries, Total_Serious_Injuries, Total_Minor_Injuries, 
Total_Uninjured, Total_Injured, Mortality)
SELECT * FROM FactAccidents;

--UPDATE
--DIM_ACCIDENT
UPDATE DIM_ACCIDENT
SET Aircraft_Damage='Unknown'
WHERE Aircraft_Damage='';

UPDATE DIM_ACCIDENT
SET FAR_Description='Unknown'
WHERE FAR_Description='';

UPDATE DIM_ACCIDENT
SET Purpose_Of_Flight='Unknown'
WHERE Purpose_Of_Flight='';

UPDATE DIM_ACCIDENT
SET Air_Carrier='Unknown'
WHERE Air_Carrier='';

UPDATE DIM_ACCIDENT
SET Broad_Phase_Of_Flight='Unknown'
WHERE Broad_Phase_Of_Flight='';

--DIM_PLACE
UPDATE DIM_PLACE
SET Country='Unknown'
WHERE Country='';

UPDATE DIM_PLACE
SET Airport_Code='UNK'
WHERE Airport_Code='';

UPDATE DIM_PLACE
SET Airport_Name='Unknown'
WHERE Airport_Name='';

UPDATE DIM_PLACE
SET Region_Code='UNK'
WHERE Region_Code IS NULL;

UPDATE DIM_PLACE
SET Region='Unknown'
WHERE Region IS NULL;

--DIM_PLANE
UPDATE DIM_PLANE
SET Make='Unknown'
WHERE Make='';

UPDATE DIM_PLANE
SET Model='Unknown'
WHERE Model='';

UPDATE DIM_PLANE
SET Amateur_Built='Unk'
WHERE Amateur_Built='';

UPDATE DIM_PLANE
SET Engine_Type='Unknown'
WHERE Engine_Type='';

UPDATE DIM_PLANE
SET Aircraft_Category='Unknown'
WHERE Aircraft_Category='';

UPDATE DIM_PLACE
SET Location=Country
WHERE Location='';

SELECT * FROM FACT_ACCIDENTS;
SELECT * FROM DIM_ACCIDENT;
SELECT * FROM DIM_PLACE;
SELECT * FROM DIM_PLANE;
SELECT * FROM DIM_CONDITIONS;
SELECT * FROM DIM_TIME;

SELECT COUNT(*) FROM FACT_ACCIDENTS;
SELECT COUNT(*) FROM DIM_ACCIDENT;
SELECT COUNT(*) FROM DIM_PLACE;
SELECT COUNT(*) FROM DIM_PLANE;
SELECT COUNT(*) FROM DIM_CONDITIONS;
SELECT COUNT(*) FROM DIM_TIME;

SELECT COUNT(*) FROM Aviation_Data1;
SELECT * FROM Aviation_Data WHERE Schedule='';
SELECT * FROM FACT_ACCIDENTS;

SELECT * FROM DIM_ACCIDENT where FAR_Description LIKE '%.';

SELECT * FROM DIM_ACCIDENT;
SELECT Air_Carrier, COUNT(*) FROM DIM_ACCIDENT GROUP BY Air_Carrier;
SELECT FAR_Description, COUNT(*) FROM DIM_ACCIDENT GROUP BY FAR_Description;

SELECT * FROM DIM_PLACE;
SELECT Location, COUNT(*) FROM DIM_PLACE GROUP BY Location ORDER BY 1;

SELECT * FROM DIM_PLANE;
SELECT SUM(Number_Of_Engines) FROM DIM_PLANE;
SELECT * FROM DIM_CONDITIONS;

SELECT * FROM USState_Codes;

SELECT * FROM DIM_PLACE;
select * from Dni
SELECT * FROM DIM_TIME;
SELECT COUNT(*) FROM Aviation_Data;
SELECT * FROM FACT_ACCIDENTS WHERE Total_Fatal_Injuries != 0 AND Total_Uninjured  + Total_Injured!= 0;
SELECT DISTINCT Weather_Condition FROM Aviation_Data;
