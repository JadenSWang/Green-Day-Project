-- USPs for GSF

-- Populate tblPRODUCTION GetIDs

CREATE PROC elpb_GetDataSourceID
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

CREATE PROC elpb_GetProductionTypeID
@PT_Name1 varchar (50)
, @ProductionTypeID int OUTPUT
AS
SET @ProductionTypeID = (
    SELECT ProductionTypeID
    FROM tblPRODUCTION_TYPE
    WHERE @PT_Name1 = ProductionTypeName
)
GO

CREATE PROC elpb_GetSourceID
@S_Name1 varchar (10)
, @SourceID int OUTPUT
AS
SET @SourceID = (
    SELECT SourceID
    FROM tblSOURCE
    WHERE @S_Name1 = SourceName
)
GO

CREATE PROC elpb_GetTimeZoneID
@TZ_Name1 varchar (35)
, @TimeZoneID int OUTPUT
AS
SET @TimeZoneID = (
    SELECT TimeZoneID
    FROM tblTIMEZONE
    WHERE @TZ_Name1 = TimeZoneName
)
GO

CREATE PROC elpb_GetUnitID
@U_ISO1 varchar (3)
, @UnitID int OUTPUT
AS
SET @UnitID = (
    SELECT UnitID
    FROM tblUNIT
    WHERE @U_ISO1 = UnitNameISO
)
GO

-- Populate tblPRODUCTION

CREATE PROC elpb_INSERT_Production

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
AS
DECLARE
    @DS_ID INT
    , @PT_ID INT
    , @S_ID INT
    , @TZ_ID INT
    , @U_ID INT

EXEC elpb_GetDataSourceID
@W_Nick1 = @W_Nick
, @W_InputDate1 = @W_InputDate
, @DataSourceID = @DS_ID OUTPUT
IF @DS_ID IS NULL
    BEGIN
        PRINT '@DS_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@DS_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetProductionTypeID
@PT_Name1 = @PT_Name
, @ProductionTypeID = @PT_ID OUTPUT
IF @PT_ID IS NULL
    BEGIN
        PRINT '@PT_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@PT_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetSourceID
@S_Name1 = @S_Name
, @SourceID = @S_ID OUTPUT
IF @S_ID IS NULL
    BEGIN
        PRINT '@S_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@S_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetTimeZoneID
@TZ_Name1 = @TZ_Name
, @TimeZoneID = @TZ_ID OUTPUT
IF @TZ_ID IS NULL
    BEGIN
        PRINT '@TZ_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@TZ_ID is NULL; process terminating', 1;
    END
EXEC elpb_GetUnitID
@U_ISO1 = @U_ISO
, @UnitID = @U_ID OUTPUT
IF @U_ID IS NULL
    BEGIN
        PRINT '@U_ID is coming back NULL, you probably misspelled something!';
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
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRANSACTION A1
    END
COMMIT TRANSACTION A1
GO

-- Populate tblDATA_SOURCE GetIDs

CREATE PROC elpb_GetInstitutionID
@I_Name1 varchar (100)
, @InstitutionID int OUTPUT
AS
SEt @InstitutionID = (
    SELECT InstitutionID
    FROM tblINSTITUTION
    WHERE @I_Name1 = InstitutionName
)
GO

CREATE PROC elpb_INSERT_DataSource

--  ===========================================
-- |    tblDATA_SOURCE Population Procedure    |
-- |               elpb (LP)                   |
-- |     Website (W); Access (A); Input(In)    |
-- |              Institution(I)               |
--  ===========================================

@W varchar (2000)
, @W_Nick varchar (20)
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
        PRINT '@I_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@I_ID is NULL; transaction terminating', 1;
    END
BEGIN TRANSACTION A1
INSERT INTO tblDATA_SOURCE (
    Website
    , WebsiteNick
    , WebsiteDesc
    , AccessDate
    , InputDate
    , InstitutionID
)
VALUES (
    @W
    , @W_Nick
    , @W_Desc
    , @A_Date
    , @In_Date
    , @I_ID
)
IF @@ERROR <> 0
    BEGIN
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRANSACTION A1
    END
COMMIT TRANSACTION A1
GO

-- Populate tblINSTITUTION

CREATE PROC elpb_GetInstitutionTypeID
@IT_Name1 varchar (150)
, @InstitutionTypeID int OUTPUT
AS
SET @InstitutionTypeID = (
    SELECT InstitutionTypeID
    FROM tblINSTITUTION_TYPE
    WHERE @IT_Name1 = InstitutionTypeName
)
GO

CREATE PROC elpb_INSERT_Institution

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
        PRINT '@I_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@I_ID is NULL; transaction terminating', 1;
    END

BEGIN TRANSACTION A1
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
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRANSACTION A1
    END
COMMIT TRANSACTION A1
GO

-- Populate tblPOWERPLANT GetIDs

CREATE PROC elpb_GetCountryID
@C_Name1 varchar (56)
, @C_ISO1 numeric (3)
,@CountryID int OUT
AS
SET @CountryID = (
    SELECT @CountryID
    FROM tblCOUNTRY
    WHERE @C_Name1 = CountryName
    AND @C_ISO1 = CountryISO
)
GO

CREATE PROC elpb_GetGridID
@G_Name1 varchar (8)
, @GridID int OUT
AS
SET @GridID = (
    SELECT GridID
    FROM tblGRID
    WHERE @G_Name1 = GridName
)
GO

CREATE PROC elpb_GetOwnerID
@O_Name1 varchar (80)
, @OwnerID int OUT
AS
SET @OwnerID = (
    SELECT OwnerID
    FROM tblOWNER
    WHERE @O_Name1 = OwnerName
)
GO

-- Populate tblPOWERPLANT

CREATE PROC elpb_INSERT_PowerPlant

--  ===========================================
-- |    tblPOWERPLANT Population Procedure     |
-- |               elpb (LP)                   |
-- |       PowerPlant (PP); Country (C)        |
-- |              Grid (G); Owner (O)          |
--  ===========================================

@PP_Name varchar (35)
, @C_Poss numeric (7,2)
, @C_Name varchar (56)
, @C_ISO numeric (3)
, @G_Name char (4)
, @O_Name varchar (80)
AS
DECLARE
    @C_ID int
    , @G_ID int
    , @O_ID int

EXEC elpb_GetCountryID
@C_Name1 = @C_Name
, @C_ISO1 = @C_ISO
,@CountryID = @C_ID OUT

IF @C_ID IS NULL
    BEGIN
        PRINT '@C_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@C_ID is NULL; transaction terminating', 1;
    END

EXEC elpb_GetGridID
@G_Name1 = @G_Name
, @GridID = @G_ID OUT

IF @G_ID IS NULL
    BEGIN
        PRINT '@G_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@G_ID is NULL; transaction terminating', 1;
    END

EXEC elpb_GetOwnerID
@O_Name1 = @O_Name
, @OwnerID = @O_ID OUT

IF @O_ID IS NULL
    BEGIN
        PRINT '@O_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@O_ID is NULL; transaction terminating', 1;
    END

BEGIN TRAN A1
INSERT INTO tblPOWERPLANT (
    PowerPlantName
    , CapacityPossible
    , CountryID
    , GridID
    , OwnerID
)
VALUES (
    @PP_Name
    , @C_Poss
    , @C_ID
    , @G_ID
    , @O_ID
)
IF @@ERROR <> 0
    BEGIN
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRAN A1
    END
COMMIT TRAN A1
GO

-- Populate tblCOUNTRY GetIDs

CREATE PROC elpb_GetCountryRoleID
@CR_Name1 varchar (80)
, @CountryRoleID int OUT
AS
SET @CountryRoleID = (
    SELECT CountryRoleID
    FROM tblCOUNTRY_ROLE
    WHERE @CR_Name1 = CountryRoleName
)
GO

-- Populate tblCOUNTRY

CREATE PROC elpb_INSERT_Country

--  ===========================================
-- |    tblCOUNTRY Population Procedure        |
-- |               elpb (LP)                   |
-- |         Country (C); C_Role (CR);         |
--  ===========================================

@C_Name varchar (56)
, @C_ISO numeric (3)
, @CR_Name varchar (80)
AS
DECLARE
    @CR_ID int

EXEC elpb_GetCountryRoleID
@CR_Name1 = @CR_Name
, @CountryRoleID = @CR_ID OUT

IF @CR_ID IS NULL
    BEGIN
        PRINT '@CR_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@CR_ID is NULL; transaction terminating', 1;
    END

BEGIN TRAN A1
INSERT INTO tblCOUNTRY (
    CountryName
    , CountryISO
    , CountryRoleID
)
VALUES (
    @C_Name
    , @C_ISO
    , @CR_ID
)
IF @@ERROR <> 0
    BEGIN
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRAN A1
    END
COMMIT TRAN A1
GO

-- Populate tblOWNER GetIDs

CREATE PROC elpb_GetOwnerTypeID
@OT_Name1 varchar (80)
, @OwnerTypeID int OUT
AS
SET @OwnerTypeID = (
    SELECT OwnerTypeID
    FROM tblOWNER_TYPE
    WHERE @OT_Name1 = OwnerTypeName
)
GO

-- Populate tblOWNER

CREATE PROC elpb_INSERT_Owner

--  ===========================================
-- |        tblOWNER Population Procedure      |
-- |               elpb (LP)                   |
-- |            Owner (O); O_Type (OT_         |
--  ===========================================

@O_Name varchar (80)
, @O_Desc varchar (255)
, @OT_Name varchar (80)
AS
DECLARE
    @OT_ID INT

EXEC elpb_GetOwnerTypeID
@OT_Name1 = @OT_Name
, @OwnerTypeID = @OT_ID OUT

IF @OT_ID IS NULL
    BEGIN
        PRINT '@OT_ID is coming back NULL, you probably misspelled something!';
        THROW 56554, '@OT_ID is NULL; transaction terminating', 1;
    END

BEGIN TRAN A1
INSERT INTO tblOWNER (
    OwnerName
    , OwnerDesc
    , OwnerTypeID
)
VALUES (
    @O_Name
    , @O_Desc
    , @OT_ID
)
IF @@ERROR <> 0
    BEGIN
        PRINT 'There is a global error failing the transaction! Rolling it back...'
        ROLLBACK TRAN A1
    END
COMMIT TRAN A1
GO



