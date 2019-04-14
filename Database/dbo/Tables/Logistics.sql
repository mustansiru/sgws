CREATE TABLE [dbo].[Logistics] (
    [Id]                          BIGINT       IDENTITY (1, 1) NOT NULL,
    [GID]                         VARCHAR (50) NOT NULL,
    [Cases_Per_Pallet]            INT          NULL,
    [Layers_Per_Pallet]           INT          NULL,
    [Cases_Per_Layer]             INT          NULL,
    [Cases_20ft_Container]        INT          NULL,
    [Cases_40ft_Container]        INT          NULL,
    [Cases_40ft_Heated_Container] INT          NULL,
    CONSTRAINT [PK_Logistics] PRIMARY KEY CLUSTERED ([Id] ASC)
);

