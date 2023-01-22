--SELECT functions will draw all tables properly
SELECT *
FROM dbo.scoring
WHERE F1 IS NOT NULL; --will return dataset without NULLS in it

SELECT *
FROM dbo.foulsminutes
WHERE F1 IS NOT NULL


SELECT *
FROM dbo.steals
WHERE F1 IS NOT NULL

SELECT *
FROM dbo.rebounds
WHERE F1 IS NOT NULL

SELECT *
FROM dbo.blocks
WHERE F1 IS NOT NULL

SELECT *
FROM dbo.assistturnovers
WHERE F1 IS NOT NULL


SELECT player,team,fgm,fga
FROM dbo.scoring
WHERE F1 IS NOT NULL
--GROUP BY team,player,fgm,FGA
ORDER BY 1,2 --orders player alphabetically


--Will return top 25 SF shot attempts
SELECT TOP (25) player, Position,SUM(CAST(FGA AS INT)) AS FieldGoalsAttempted, SUM(CAST(FGM AS INT)) AS FieldGoalsMade,
SUM(CAST(ThreeFGA AS INT)) AS ThreeFieldGoalsAttempted, SUM(CAST(ThreeFGM AS INT)) AS ThreeFieldGoalsMade
FROM dbo.Scoring as S
WHERE F1 IS NOT NULL
AND position = 'SF'
GROUP BY Player,Position
ORDER BY 1,2


--Will return all SG shot attempts
SELECT player, Position,SUM(CAST(FGA AS INT)) AS FieldGoalsAttempted, SUM(CAST(FGM AS INT)) AS FieldGoalsMade,
SUM(CAST(ThreeFGA AS INT)) AS ThreeFieldGoalsAttempted, SUM(CAST(ThreeFGM AS INT)) AS ThreeFieldGoalsMade
FROM dbo.Scoring as S
WHERE F1 IS NOT NULL
AND position = 'SG'
GROUP BY Player,Position
ORDER BY 1,2


-- Code that will return the most field goals made by 10 SG
--Visualization #1
SELECT TOP (10) player, position, MAX(CAST(FGM AS INT)) AS MostFieldGoalsMade
FROM dbo.scoring
WHERE F1 IS NOT NULL
AND position = 'SG'
--OR position = 'PG'
GROUP BY player, position
ORDER BY MostFieldGoalsMade DESC


-- Code that will return the most field goals made top 10 PG 
-- Visualization #2
SELECT TOP (10) player, position, MAX(CAST(FGM AS INT)) AS MostFieldGoalsMade
FROM dbo.scoring
WHERE F1 IS NOT NULL
AND position = 'PG'
--OR position = 'PG'
GROUP BY player, position
ORDER BY MostFieldGoalsMade DESC


--Will return all shot attempts by top 25 players
--Visualization #3
SELECT TOP(25) S.player, S.position, MAX(CAST(S.FGM AS INT)) AS MostFieldGoalsMade
FROM dbo.scoring AS S
INNER JOIN dbo.scoring AS SC
ON S.player = SC.Player
--WHERE F1 IS NOT NULL
WHERE S.position = 'SG'
OR S.position = 'PG'
OR S.position = 'sf'
OR S.position = 'pf'
OR S.position = 'c'
GROUP BY S.player, S.position
ORDER BY MostFieldGoalsMade DESC


--Will show all players points from threes and Twos
--Visualization #4
SELECT player,position,ThreeFGM * 3 AS PointsFromThrees, (FGM - Threefgm) * 2 AS PointsFromTwo
FROM dbo.Scoring
GROUP BY player,position,ThreeFGM,FGM
ORDER BY ThreeFGM DESC


--Will show pg total assist, turnover, and assist to turnover ratio
--Visualization #5
SELECT player,position,totalassists,turnovers, TotalAssists/Turnovers AS AssistTurnoverRatio
FROM dbo.AssistTurnovers
WHERE position = 'pg'
GROUP BY player,position, totalassists,turnovers, assistsperturnover
ORDER BY totalassists DESC



--Will show sg total assist, turnover, and assist to turnover ratio
--Visualization #5
SELECT player,position,totalassists,turnovers, TotalAssists/Turnovers AS AssistTurnoverRatio
FROM dbo.AssistTurnovers
WHERE position = 'sg'
GROUP BY player,position, totalassists,turnovers, assistsperturnover
ORDER BY totalassists DESC