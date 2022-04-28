-- USPs for GSF

-- Production Population USP + Descendant USPs

CREATE PROCEDURE elpb_GetDataSourceID
@W_Nick1 varchar (20)
, @W_InputDate1 date
, @DataSourceID int OUTPUT
AS
SET @DataSourceID = (
    SELECT DataSourceID
    FROM tblDATA_SOURCE
    WHERE @W_Nick1 = WebsiteNick
    AND @W_InputDate1 = InputDate
)
GO

CREATE PROCEDURE elpb_GetProductionTypeID
@PT_Name1 varchar (50)
, @ProductionTypeID int OUTPUT
AS
SET @ProductionTypeID = (
    SELECT ProductionTypeID
    FROM tblPRODUCTION_TYPE
    WHERE @PT_Name1 = ProductionTypeName
)
GO

CREATE PROCEDURE elpb_GetSourceID
@W_Nick1 varchar (20)
, @W_InputDate1 date
, @SourceID int OUTPUT
AS
SET @SourceID = (
    SELECT SourceID
    FROM tblSOURCE
    WHERE @W_Nick1 = WebsiteNick
    AND @W_InputDate1 = InputDate
)
GO

CREATE PROCEDURE elpb_GetTimeZoneID
@TZ_Name1 varchar (35)
, @TimeZoneID int OUTPUT
AS
SET @TimeZoneID = (
    SELECT TimeZoneID
    FROM tblTIMEZONE
    WHERE @TZ_Name1 = TimeZoneName
)
GO

CREATE PROCEDURE elpb_GetUnitID
@U_ISO1 varchar (3)
, @UnitID int OUTPUT
AS
SET @UnitID = (
    SELECT UnitID
    FROM tblUNIT
    WHERE @U_ISO1 = UnitNameISO
)
GO



CREATE PROCEDURE elpb_INSERT_Production

--  ===========================================
-- |    tblPOPULATION Population Procedure     |
-- |               elpb (LP)                   |
-- |     Value (V); Production(P); Begin (B)   |
-- |      End (E); P_Type (PT); Source (S)     |
-- |   Time Zone (TZ); Unit (U); Website (W)   |
--  ===========================================

@V_Amt numeric (5,1)
, @P_BDate smalldatetime
, @P_EDate smalldatetime
, @PT_Name varchar (50)
, @W_Nick varchar (20)
, @W_InputDate date
, @S_Name varchar (10)
, @TZ_Name varchar (35)
, @U_ISO varchar (3)

DECLARE
    @DS_ID INT
    , @PT_ID INT
    , @S_ID INT
    , @TZ_ID INT
    , @U_ID INT
AS

EXEC elpb_GetDataSourceID
@W_Nick1 = @W_Nick
, @W_InputDate1 = @W_InputDate
, @DataSourceID = @DS_ID OUTPUT
IF @DS_ID IS NULL
    BEGIN
        PRINT '@DS_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@DS_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetProductionTypeID
@PT_Name1 = @PT_Name
, @ProductionTypeID = @PT_ID OUTPUT
IF @PT_ID IS NULL
    BEGIN
        PRINT '@PT_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@PT_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetSourceID
, @W_Nick1 = @W_Nick
, @W_InputDate1 = @W_InputDate
, @SourceID = @S_ID OUTPUT
IF @S_ID IS NULL
    BEGIN
        PRINT '@S_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@S_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetTimeZoneID
@TZ_Name1 = @TZ_Name
, @TimeZoneID = @TZ_ID OUTPUT
IF @TZ_ID IS NULL
    BEGIN
        PRINT '@TZ_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@TZ_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetUnitID
@U_ISO1 = @U_ISO
, @UnitID = @U_ID OUTPUT
IF @U_ID IS NULL
    BEGIN
        PRINT '@U_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@U_ID is NULL; process terminating', 1;
    END

BEGIN TRANSACTION A1
INSERT INTO tblPRODUCTION (
    VolumeAmount
    , ProductionBeginDate
    , ProductionEndDate
    , DataSourceID
    , ProductionTypeID
    , SourceID
    , TimeZoneID
    , UnitID
)
VALUES (
    @V_Amt
    , @P_BDate
    , @P_EDate
    , @DS_ID
    , @PT_ID
    , @S_ID
    , @TZ_ID
    , @U_ID
)
IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION A1
    END
COMMIT TRANSACTION A1
GO

-- Populate tblDATA_SOURCE

CREATE PROCEDURE elpb_GetInstitutionID
@I_Name1 varchar (100)
, @InstitutionID int OUTPUT
AS
SEt @InstitutionID = (
    SELECT InstitutionID
    FROM tblINSTITUTION
    WHERE @I_Name1 = InstitutionName
)
GO


CREATE PROCEDURE elpb_INSERT_DataSource

--  ===========================================
-- |    tblDATA_SOURCE Population Procedure    |
-- |               elpb (LP)                   |
-- |     Website (W); Access (A); Input(In)    |
-- |              Institution(I)               |
--  ===========================================

@W varchar (2000)
, @W_Desc varchar (255)
, @A_Date date
, @In_Date date
, @I_Name varchar (100)
AS

DECLARE 
    @I_ID INT

EXEC elpb_GetInstitutionID
@I_Name1 = @I_Name
, @InstitutionID = @I_ID OUTPUT
IF @I_ID IS NULL
    BEGIN
        PRINT '@I_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@I_ID is NULL; transaction terminating', 1;
    END
BEGIN TRANSACTION A1
INSERT INTO tblDATA_SOURCE (
    Website
    , WebsiteDesc
    , AccessDate
    , InputDate
    , InstitutionID
)
VALUES (
    @W
    , @W_Desc
    , @A_Date
    , @In_Date
    , @I_ID
)
IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION A1
    END
COMMIT TRANSACTION A1
END

-- Populate tblINSTITUTION

CREATE PROCEDURE elpb_GetInstitutionTypeID
@IT_Name1 varchar (150)
, @InstitutionTypeID int OUTPUT
AS
SET @InstitutionTypeID = (
    SELECT InstitutionTypeID
    FROM tblINSTITUTION_TYPE
    WHERE InstitutionName = @IT_Name1
)
GO

CREATE PROCEDURE elpb_INSERT_Institution

--  ===========================================
-- |    tblINSTITUTION Population Procedure    |
-- |               elpb (LP)                   |
-- |     Institution (I); I_Type (IT)          |
--  ===========================================

@I_Name varchar (100)
, @I_Desc varchar (255)
, @IT_Name varchar (150)
AS

DECLARE
    @IT_ID INT

EXEC elpb_GetInstitutionTypeID
@IT_Name1 = @IT_Name
, @InstitutionTypeID = @IT_ID OUTPUT
IF @IT_ID IS NULL
    BEGIN 
        PRINT '@I_ID is coming back NULL, you probably mispelled something!';
        THROW 56554, '@I_ID is NULL; transaction terminating', 1;
    END

BEGIN TRANSACTION A3
INSERT INTO tblINSTITUTION (
    InstitutionName
    , InstitutionDesc
    , InstitutionTypeID
)
VALUES (
    @I_Name
    , @I_Desc
    , @IT_ID
)
IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION A3
    END
COMMIT TRANSACTION A3
GO