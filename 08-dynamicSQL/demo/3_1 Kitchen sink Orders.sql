USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [dbo].[OrdersSearch_KitchenSink]    Script Date: 3/21/2019 11:44:25 PM ******/
USE [WideWorldImporters]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersSearch_KitchenSink]
  @OrderId		         int            = NULL,
  @CustomerID            int            = NULL,
  @OrderDateFrom         DATE           = NULL,
  @OrderDateTo			 DATE            = NULL,
  @SalespersonPersonID		 INT            = NULL
AS
BEGIN
  SET NOCOUNT ON;
 
 --Требуются множественные проверки - это сложно и для сопровождения и для планировщика
  SELECT OrderId, OrderDate, CustomerID, SalespersonPersonID 
  FROM Sales.Orders
  WHERE (@CustomerID IS NULL 
         OR CustomerID = @CustomerID)
    AND (@OrderId IS NULL 
         OR OrderId = @OrderId)
    AND (OrderDate >= COALESCE(@OrderDateFrom,OrderDate))
    AND (@OrderDateTo IS NULL 
         OR OrderDate <= @OrderDateTo)
    AND (@SalespersonPersonID IS NULL 
         OR SalespersonPersonID = @SalespersonPersonID);
END