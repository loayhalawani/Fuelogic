SELECT SUM(S.Capacity - S.CurrentCapacity) AS Capacity
FROM Storage S, Company C, Branch B
WHERE S.FuelType = 'Diesel' AND B.Status = 'M' AND C.ID LIKE '%02%'
AND C.ID IN (SELECT C.ID 
			 FROM HQ H 
			 WHERE B.HeadquarterID = H.ID AND C.HeadquarterID = H.ID);

SELECT FirstName, MiddleName, LastName
FROM Employee
WHERE Amount IN (SELECT E.Amount 
				 FROM Employee E, Company C
				 WHERE E.Amount > 700 AND E.CompanyID = C.ID AND C.ID LIKE '%01%');

SELECT S.ID AS StorageID, S.CurrentCapacity, C.ID AS CompanyID
FROM Storage S, Branch B, Company C
WHERE S.BranchID = B.ID AND S.CurrentCapacity < 60
AND C.ID IN (SELECT C.ID
			 FROM HQ H
			 WHERE B.HeadquarterID = H.ID AND C.HeadquarterID = H.ID);

SELECT C.Name, 1.15 * B.Amount AS Fine, B.Currency
FROM Consumer C, Bill B, DeliversTo D
WHERE DATEDIFF(day, B.PaymentDate , D.Date) > 30;

SELECT SupplierID, (COUNT(*) * 100 / ((SELECT COUNT(*) 
						  FROM Makes) + (SELECT COUNT(*)
										 FROM Bill))) AS PERCENTAGE
FROM Makes
GROUP BY SupplierID;

SELECT PlateNb, FuelType
FROM Truck
WHERE Capacity > 40
GROUP BY PlateNb, FuelType;

SELECT COUNT(M.ContractID) AS COUNT
FROM Makes M, Contract C
WHERE M.ContractID = C.ID AND SignatureDate LIKE '_____01___';

SELECT DISTINCT(R.PhoneNb), R.Name, R.Relationship, C.ID
FROM Employee E, Relative R, Company C
WHERE R.EmployeeID = 'emp-0001'
AND C.ID IN (SELECT C.ID
			 FROM Company C, Employee E
			 WHERE C.ID = E.CompanyID AND E.ID = 'emp-0001');

SELECT ID, FirstName, LastName
FROM Employee
WHERE NOT EXISTS (SELECT *
				  FROM Relative
				  WHERE ID = EmployeeID)
ORDER BY ID;

SELECT E.ID, E.FirstName, E.LastName, C.ID
FROM Employee E, Company C
WHERE C.Nb_of_trucks < 32000 and C.ID = CompanyID;
