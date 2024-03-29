﻿CREATE TYPE [dbo].[dtCompanyDetails] AS TABLE (
    [BusinessLegalName]   VARCHAR (250) NULL,
    [BusinessNumber]      VARCHAR (100) NULL,
    [DUNSNumber]          VARCHAR (100) NULL,
    [BACode]              VARCHAR (100) NULL,
    [OperatorCode]        VARCHAR (100) NULL,
    [MailingAddressID]    BIGINT        NULL,
    [PhysicalAddressID]   BIGINT        NULL,
    [EffectiveDate]       DATE          NULL,
    [ExpiryDate]          DATE          NULL,
    [AddressTypeID_M]     SMALLINT      NULL,
    [DeliveryModeID_M]    BIGINT        NULL,
    [POBox_M]             VARCHAR (50)  NULL,
    [RuralRouteNumber_M]  VARCHAR (100) NULL,
    [Unit_M]              BIGINT        NULL,
    [StreetNumber_M]      VARCHAR (100) NULL,
    [StreetName_M]        VARCHAR (200) NULL,
    [StreetTypeID_M]      BIGINT        NULL,
    [StreetDirectionID_M] BIGINT        NULL,
    [City_M]              VARCHAR (100) NULL,
    [ProvinceID_M]        BIGINT        NULL,
    [PostalCode_M]        VARCHAR (50)  NULL,
    [CountryID_M]         BIGINT        NULL,
    [AddressTypeID_P]     SMALLINT      NULL,
    [DeliveryModeID_P]    BIGINT        NULL,
    [POBox_P]             VARCHAR (50)  NULL,
    [RuralRouteNumber_P]  VARCHAR (100) NULL,
    [Unit_P]              BIGINT        NULL,
    [StreetNumber_P]      VARCHAR (100) NULL,
    [StreetName_P]        VARCHAR (200) NULL,
    [StreetTypeID_P]      BIGINT        NULL,
    [StreetDirectionID_P] BIGINT        NULL,
    [City_P]              VARCHAR (100) NULL,
    [ProvinceID_P]        BIGINT        NULL,
    [PostalCode_P]        VARCHAR (50)  NULL,
    [CountryID_P]         BIGINT        NULL);

