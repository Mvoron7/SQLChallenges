CREATE DEFINER=`root`@`localhost` PROCEDURE `сolorsCombinations`(
    prm_count INT
)
BEGIN
     SET @Code := 1;
	  WITH TempColors(Name, Code) AS (
           SELECT name
                , @Code := @Code * 10 AS Code 
             FROM Colors
            LIMIT prm_count)
	SELECT C1.name AS Name1
		 , C2.name AS Name2
		 , C3.name AS Name3
		 , C4.name AS Name4
	  FROM TempColors AS C1
	  LEFT JOIN TempColors AS C2
		ON C1.Name != C2.Name
	  LEFT JOIN TempColors AS C3
		ON C3.Name != C1.Name
	   AND C3.Name != C2.Name
	  LEFT JOIN TempColors AS C4
		ON C4.Name != C1.Name
	   AND C4.Name != C2.Name
	   AND C4.Name != C3.Name
	 GROUP BY C1.Code + C2.Code + C3.Code + C4.Code;
END