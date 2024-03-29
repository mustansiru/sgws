﻿CREATE TYPE [dbo].[dtFacilityDetails] AS TABLE (
    [NodeID]                   NVARCHAR (50)  NULL,
    [SiteName]                 NVARCHAR (200) NULL,
    [SurfaceLocation]          NVARCHAR (200) NULL,
    [LicenceNo]                NVARCHAR (50)  NULL,
    [CompanyID]                BIGINT         NULL,
    [Field]                    NVARCHAR (200) NULL,
    [FacilitySubTypeCodeID]    BIGINT         NULL,
    [ActivityTypeID]           BIGINT         NULL,
    [SiteTypeID]               BIGINT         NULL,
    [OwnershipTypeID]          BIGINT         NULL,
    [PrimaryPAReference]       NVARCHAR (50)  NULL,
    [NAICSCodeID]              BIGINT         NULL,
    [SwimSiteName]             NVARCHAR (200) NULL,
    [NPRIID]                   VARCHAR (50)   NULL,
    [GHGID]                    VARCHAR (50)   NULL,
    [BCFacilityTypeID]         BIGINT         NULL,
    [SurfaceLocationLatitude]  VARCHAR (50)   NULL,
    [SurfaceLocationLongitude] VARCHAR (50)   NULL,
    [Zone]                     VARCHAR (50)   NULL,
    [East]                     VARCHAR (50)   NULL,
    [North]                    VARCHAR (50)   NULL,
    [ContactID]                BIGINT         NULL,
    [BOE]                      VARCHAR (50)   NULL,
    [EffectiveDate]            DATE           NULL,
    [ExpiryDate]               DATE           NULL,
    [MailingAddressID]         BIGINT         NULL,
    [PhysicalAddressID]        BIGINT         NULL,
    [AddressTypeID_M]          SMALLINT       NULL,
    [DeliveryModeID_M]         BIGINT         NULL,
    [POBox_M]                  VARCHAR (50)   NULL,
    [RuralRouteNumber_M]       VARCHAR (100)  NULL,
    [Unit_M]                   VARCHAR (50)   NULL,
    [StreetNumber_M]           VARCHAR (100)  NULL,
    [StreetName_M]             VARCHAR (200)  NULL,
    [StreetTypeID_M]           BIGINT         NULL,
    [StreetDirectionID_M]      BIGINT         NULL,
    [City_M]                   VARCHAR (100)  NULL,
    [ProvinceID_M]             BIGINT         NULL,
    [PostalCode_M]             VARCHAR (50)   NULL,
    [CountryID_M]              BIGINT         NULL,
    [AddressTypeID_P]          SMALLINT       NULL,
    [DeliveryModeID_P]         BIGINT         NULL,
    [POBox_P]                  VARCHAR (50)   NULL,
    [RuralRouteNumber_P]       VARCHAR (100)  NULL,
    [Unit_P]                   VARCHAR (50)   NULL,
    [StreetNumber_P]           VARCHAR (100)  NULL,
    [StreetName_P]             VARCHAR (200)  NULL,
    [StreetTypeID_P]           BIGINT         NULL,
    [StreetDirectionID_P]      BIGINT         NULL,
    [City_P]                   VARCHAR (100)  NULL,
    [ProvinceID_P]             BIGINT         NULL,
    [PostalCode_P]             VARCHAR (50)   NULL,
    [CountryID_P]              BIGINT         NULL,
    [CostCentre]               VARCHAR (500)  NULL,
    [NumberOfEmployees]        VARCHAR (50)   NULL,
    [AnnualHours]              VARCHAR (50)   NULL,
    [FacilityExternalID]       VARCHAR (100)  NULL);

