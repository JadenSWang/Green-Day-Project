--  =========================================================
-- | Title: Working DDL for GSF Software Scraping Database   |
-- | Author: elpb for Group 3                                |                                    |
--  =========================================================

CREATE TABLE tblPRODUCTION_TYPE (
    ProductionTypeID int IDENTITY (1,1) PRIMARY KEY
    , ProductionTypeName varchar (50) NOT NULL
    , ProductionTypeDesc varchar (255) NULL
)
GO

CREATE TABLE tblTIMEZONE (
    TimeZoneID int IDENTITY (1,1) PRIMARY KEY
    , TimeZoneName varchar (35) NOT NULL
    , TimeZoneCode varchar (15) NOT NULL
)
GO

CREATE TABLE tblUNIT (
    UnitID int IDENTITY (1,1) PRIMARY KEY
    , UnitNameISO varchar (3) NOT NULL
    , UnitNameLocal varchar (5) NULL
    , UnitDesc varchar (255) NULL
)
GO

CREATE TABLE tblPRODUCTION (
    ProductionID int IDENTITY (1,1) PRIMARY KEY
    , VolumeAmount numeric (5,1) NOT NULL
    , ProductionBeginDate smalldatetime NOT NULL
    , ProductionEndDate smalldatetime NOT NULL
    , DataSourceID int NOT NULL
    , ProductionTypeID int NOT NULL
    , SourceID int NOT NULL
    , TimeZoneID int NOT NULL
    , UnitID int NOT NULL
)
GO

CREATE TABLE tblSOURCE (
    SourceID int IDENTITY (1,1) PRIMARY KEY
    , SourceName varchar (80) NOT NULL
    , SourceDesc varchar (255) NULL
)
GO

CREATE TABLE tblDATA_SOURCE (
    DataSourceID int IDENTITY (1,1) PRIMARY KEY
    , Website varchar (2000) NOT NULL
    , WebsiteNick varchar (20) NOT NULL
    , WebsiteDesc varchar (255) NULL
    , AccessDate date NOT NULL
    , InputDate date NOT NULL
    , InstitutionID int NOT NULL
)
GO

CREATE TABLE tblINSTITUTION (
    InstitutionID int IDENTITY (1,1) PRIMARY KEY
    , InstitutionName varchar (100) NOT NULL
    , InstitutionDesc varchar (255) NULL
    , InstitutionTypeID int NOT NULL
)
GO

CREATE TABLE tblINSTITUTION_TYPE (
    InstitutionTypeID int IDENTITY (1,1) PRIMARY KEY
    , InstitutionTypeName varchar (150) NOT NULL
    , InstitutionTypeDesc varchar (255) NOT NULL
)
GO

CREATE TABLE tblSOURCE (
    SourceID int IDENTITY (1,1) PRIMARY KEY
    , SourceName varchar (10) NOT NULL
    , SourceDesc varchar (255) NULL
)
GO

CREATE TABLE tblPOWERPLANT (
    PowerPlantID int IDENTITY (1,1) PRIMARY KEY
    , PowerPlantName varchar (35) NOT NULL
    , CapacityPossible numeric (7,2) NOT NULL
    , CountryID int NOT NULL
    , GridID int NOT NULL
    , OwnerID int NOT NULL
)
GO

CREATE TABLE tblPOWERPLANT_SOURCE (
    SourceID int NOT NULL
    , PowerPlantID int NOT NULL
)
GO

CREATE TABLE tblOWNER (
    OwnerID int IDENTITY (1,1) PRIMARY KEY
    , OwnerName varchar (80) NOT NULL
    , OwnerDesc varchar (255) NULL
    , OwnerTypeID int NOT NULL
)
GO

CREATE TABLE tblOWNER_TYPE (
    OwnerTypeID int IDENTITY (1,1) PRIMARY KEY
    , OwnerTypeName varchar (80) NOT NULL
    , OwnerTypeDesc varchar (255) NOT NULL
)
GO

CREATE TABLE tblGRID (
    GridID int IDENTITY (1,1) PRIMARY KEY
    , GridName varchar (80) NOT NULL
    , GridDesc varchar (255) NULL
)
GO

CREATE TABLE tblCOUNTRY (
    CountryID int IDENTITY (1,1) PRIMARY KEY
    , CountryName varchar (56) NOT NULL
    , CountryISO char (3) NOT NULL
    , CountryRoleID int NOT NULL
)
GO

CREATE TABLE tblCOUNTRY_ROLE (
    CountryRoleID int IDENTITY (1,1) PRIMARY KEY
    , CountryRoleName varchar (80) NOT NULL
    , CountryRoleDesc varchar (255) NOT NULL
)
GO

CREATE TABlE tblFORECAST (
    ForecastID int IDENTITY (1,1) PRIMARY KEY
    , CapacityAdjusted numeric (7,2) NOT NULL
    , EveningPeakProjected numeric (7,2) NOT NULL
    , DayPeakProjected numeric (7,2) NOT NULL
    , DateProjected datetime2 NOT NULL
    , Remark varchar (255) NULL
)
GO

CREATE TABLE tblPOWERPLANT_FORECAST (
    ForecastID int NOT NULL
    , PowerPlantID int NOT NULL
)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_DataSourceID_Production FOREIGN KEY (DataSourceID)
    REFERENCES tblDATA_SOURCE (DataSourceID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_ProductionTypeID_Production FOREIGN KEY (ProductionTypeID)
    REFERENCES tblPRODUCTION_TYPE (ProductionTypeID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_SourceID_Production FOREIGN KEY (SourceID)
    REFERENCES tblSOURCE (SourceID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_UnitID_Production FOREIGN KEY (UnitID)
    REFERENCES tblUNIT (UnitID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_TimeZoneID_Production FOREIGN KEY (TimeZoneID)
    REFERENCES tblTIMEZONE (TimeZoneID)

ALTER TABLE tblDATA_SOURCE
    ADD CONSTRAINT FK_InstitutionID_DataSource FOREIGN KEY (InstitutionID)
    REFERENCES tblINSTITUTION (InstitutionID)
GO

ALTER TABLE tblINSTITUTION
    ADD CONSTRAINT FK_InstitutionTypeID_Institution FOREIGN KEY (InstitutionTypeID)
    REFERENCES tblINSTITUTION_TYPE (InstitutionTypeID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_GridID_PowerPlant FOREIGN KEY (GridID)
    REFERENCES tblGRID (GridID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_CountryID_PowerPlant FOREIGN KEY (CountryID)
    REFERENCES tblCOUNTRY (CountryID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_OwnerID_PowerPlant FOREIGN KEY (OwnerID)
    REFERENCES tblOWNER (OwnerID)

ALTER TABLE tblPOWERPLANT_SOURCE
    ADD CONSTRAINT FK_PowerPlantID_PowerPlantSource FOREIGN KEY (PowerPlantID)
    REFERENCES tblPOWERPLANT (PowerPlantID)
GO

ALTER TABLE tblPOWERPLANT_SOURCE
    ADD CONSTRAINT FK_SourceID_PowerPlantSource FOREIGN KEY (SourceID)
    REFERENCES tblSOURCE (SourceID)
GO

ALTER TABlE tblOWNER
    ADD CONSTRAINT FK_OwnerTypeID_Owner FOREIGN KEY (OwnerTypeID)
    REFERENCES tblOWNER_TYPE (OwnerTypeID)

ALTER TABLE tblCOUNTRY
    ADD CONSTRAINT FK_CountryRoleID_Country FOREIGN KEY (CountryRoleID)
    REFERENCES tblCOUNTRY_ROLE (CountryRoleID)
GO

ALTER TABLE tblPOWERPLANT_FORECAST
    ADD CONSTRAINT FK_PowerPlantID_PowerPlantForecast FOREIGN KEY (PowerPlantID)
    REFERENCES tblPOWERPLANT (PowerPlantID)
GO

ALTER TABLE tblPOWERPLANT_FORECAST
    ADD CONSTRAINT FK_ForecastID_PowerPlantForecast FOREIGN KEY (ForecastID)
    REFERENCES tblFORECAST (ForecastID)
GO
CREATE TABLE tblPRODUCTION_TYPE (
    ProductionTypeID int IDENTITY (1,1) PRIMARY KEY
    , ProductionTypeName varchar (50) NOT NULL
    , ProductionTypeDesc varchar (255) NULL
)
GO

CREATE TABLE tblTIMEZONE (
    TimeZoneID int IDENTITY (1,1) PRIMARY KEY
    , TimeZoneName varchar (35) NOT NULL
    , TimeZoneCode varchar (15) NOT NULL
)
GO

CREATE TABLE tblUNIT (
    UnitID int IDENTITY (1,1) PRIMARY KEY
    , UnitNameISO varchar (3) NOT NULL
    , UnitNameLocal varchar (5) NULL
    , UnitDesc varchar (255) NULL
)
GO

CREATE TABLE tblPRODUCTION (
    ProductionID int IDENTITY (1,1) PRIMARY KEY
    , VolumeAmount numeric (5,1) NOT NULL
    , ProductionBeginDate smalldatetime NOT NULL
    , ProductionEndDate smalldatetime NOT NULL
    , DataSourceID int NOT NULL
    , ProductionTypeID int NOT NULL
    , SourceID int NOT NULL
    , TimeZoneID int NOT NULL
    , UnitID int NOT NULL
)
GO

CREATE TABLE tblSOURCE (
    SourceID int IDENTITY (1,1) PRIMARY KEY
    , SourceName varchar (80) NOT NULL
    , SourceDesc varchar (255) NULL
)
GO

CREATE TABLE tblDATA_SOURCE (
    DataSourceID int IDENTITY (1,1) PRIMARY KEY
    , Website varchar (2000) NOT NULL
    , WebsiteNick varchar (20) NOT NULL
    , WebsiteDesc varchar (255) NULL
    , AccessDate date NOT NULL
    , InputDate date NOT NULL
    , InstitutionID int NOT NULL
)
GO

CREATE TABLE tblINSTITUTION (
    InstitutionID int IDENTITY (1,1) PRIMARY KEY
    , InstitutionName varchar (100) NOT NULL
    , InstitutionDesc varchar (255) NULL
    , InstitutionTypeID int NOT NULL
)
GO

CREATE TABLE tblINSTITUTION_TYPE (
    InstitutionTypeID int IDENTITY (1,1) PRIMARY KEY
    , InstitutionTypeName varchar (150) NOT NULL
    , InstitutionTypeDesc varchar (255) NOT NULL
)
GO

CREATE TABLE tblSOURCE (
    SourceID int IDENTITY (1,1) PRIMARY KEY
    , SourceName varchar (10) NOT NULL
    , SourceDesc varchar (255) NULL
)
GO

CREATE TABLE tblPOWERPLANT (
    PowerPlantID int IDENTITY (1,1) PRIMARY KEY
    , PowerPlantName varchar (35) NOT NULL
    , CapacityPossible numeric (7,2) NOT NULL
    , CountryID int NOT NULL
    , RegionID int NOT NULL
    , OwnerID int NOT NULL
)
GO

CREATE TABLE tblPOWERPLANT_SOURCE (
    SourceID int NOT NULL
    , PowerPlantID int NOT NULL
)
GO

CREATE TABLE tblOWNER (
    OwnerID int IDENTITY (1,1) PRIMARY KEY
    , OwnerName varchar (80) NOT NULL
    , OwnerDesc varchar (255) NULL
    , OwnerTypeID int NOT NULL
)
GO

CREATE TABLE tblOWNER_TYPE (
    OwnerTypeID int IDENTITY (1,1) PRIMARY KEY
    , OwnerTypeName varchar (80) NOT NULL
    , OwnerTypeDesc varchar (255) NOT NULL
)
GO

CREATE TABLE tblGRID (
    GridID int IDENTITY (1,1) PRIMARY KEY
    , GridName varchar (80) NOT NULL
    , GridDesc varchar (255) NULL
)
GO

CREATE TABLE tblCOUNTRY (
    CountryID int IDENTITY (1,1) PRIMARY KEY
    , CountryName varchar (56) NOT NULL
    , CountryISO char (3) NOT NULL
    , CountryRoleID int NOT NULL
)
GO

CREATE TABLE tblCOUNTRY_ROLE (
    CountryRoleID int IDENTITY (1,1) PRIMARY KEY
    , CountryRoleName varchar (80) NOT NULL
    , CountryRoleDesc varchar (255) NOT NULL
)
GO

CREATE TABlE tblFORECAST (
    ForecastID int IDENTITY (1,1) PRIMARY KEY
    , CapacityAdjusted numeric (7,2) NOT NULL
    , EveningPeakProjected numeric (7,2) NOT NULL
    , DayPeakProjected numeric (7,2) NOT NULL
    , DateProjected datetime2 NOT NULL
    , Remark varchar (255) NULL
)
GO

CREATE TABLE tblPOWERPLANT_FORECAST (
    PowerPlantForecastID int IDENTITY (1,1) PRIMARY KEY
    , ForecastID int NOT NULL
    , PowerPlantID int NOT NULL
)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_DataSourceID_Production FOREIGN KEY (DataSourceID)
    REFERENCES tblDATA_SOURCE (DataSourceID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_ProductionTypeID_Production FOREIGN KEY (ProductionTypeID)
    REFERENCES tblPRODUCTION_TYPE (ProductionTypeID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_SourceID_Production FOREIGN KEY (SourceID)
    REFERENCES tblSOURCE (SourceID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_UnitID_Production FOREIGN KEY (UnitID)
    REFERENCES tblUNIT (UnitID)
GO

ALTER TABLE tblPRODUCTION
    ADD CONSTRAINT FK_TimeZoneID_Production FOREIGN KEY (TimeZoneID)
    REFERENCES tblTIMEZONE (TimeZoneID)

ALTER TABLE tblDATA_SOURCE
    ADD CONSTRAINT FK_InstitutionID_DataSource FOREIGN KEY (InstitutionID)
    REFERENCES tblINSTITUTION (InstitutionID)
GO

ALTER TABLE tblINSTITUTION
    ADD CONSTRAINT FK_InstitutionTypeID_Institution FOREIGN KEY (InstitutionTypeID)
    REFERENCES tblINSTITUTION_TYPE (InstitutionTypeID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_GridID_PowerPlant FOREIGN KEY (GridID)
    REFERENCES tblGRID (GridID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_CountryID_PowerPlant FOREIGN KEY (CountryID)
    REFERENCES tblCOUNTRY (CountryID)
GO

ALTER TABLE tblPOWERPLANT
    ADD CONSTRAINT FK_OwnerID_PowerPlant FOREIGN KEY (OwnerID)
    REFERENCES tblOWNER (OwnerID)

ALTER TABLE tblPOWERPLANT_SOURCE
    ADD CONSTRAINT FK_PowerPlantID_PowerPlantSource FOREIGN KEY (PowerPlantID)
    REFERENCES tblPOWERPLANT (PowerPlantID)
GO

ALTER TABLE tblPOWERPLANT_SOURCE
    ADD CONSTRAINT FK_SourceID_PowerPlantSource FOREIGN KEY (SourceID)
    REFERENCES tblSOURCE (SourceID)
GO

ALTER TABlE tblOWNER
    ADD CONSTRAINT FK_OwnerTypeID_Owner FOREIGN KEY (OwnerTypeID)
    REFERENCES tblOWNER_TYPE (OwnerTypeID)

ALTER TABLE tblCOUNTRY
    ADD CONSTRAINT FK_CountryRoleID_Country FOREIGN KEY (CountryRoleID)
    REFERENCES tblCOUNTRY_ROLE (CountryRoleID)
GO

ALTER TABLE tblPOWERPLANT_FORECAST
    ADD CONSTRAINT FK_PowerPlantID_PowerPlantForecast FOREIGN KEY (PowerPlantID)
    REFERENCES tblPOWERPLANT (PowerPlantID)
GO

ALTER TABLE tblPOWERPLANT_FORECAST
    ADD CONSTRAINT FK_ForecastID_PowerPlantForecast FOREIGN KEY (ForecastID)
    REFERENCES tblFORECAST (ForecastID)
GO

CREATE TABLE tblREGION (
    RegionID int IDENTITY (1,1) PRIMARY KEY
    , RegionName varchar (50)
    , GridID int NOT NULL
)
GO

ALTER TABLE tblREGION
    ADD CONSTRAINT FK_GridID_Region FOREIGN KEY (GridID)
    REFERENCES tblGRID (GridID)
GO
