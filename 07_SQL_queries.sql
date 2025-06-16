-- insert Users
INSERT INTO User (Username, Email, Password, Date_of_Birth) VALUES
('krishpatel', 'krish@gmail.com', 'pass123', '2003-05-01'),
('jenny123', 'jenny@mail.com', 'abc456', '2000-08-15'),
('rockstar7', 'rockstar@gmail.com', 'music999', '1995-02-20'),
('djspin', 'spin@gmail.com', 'beats789', '1998-11-30'),
('melomaniac', 'melo@mail.com', 'tune321', '2001-06-25'),
('guitar_hero', 'guitar@music.com', 'strumstrum', '1999-12-12'),
('classicalfan', 'classical@melody.com', 'piano456', '1989-10-18'),
('beatlover', 'beatlover@mail.com', 'beatmeup', '1996-07-03'),
('soundjunkie', 'sound@mail.com', 'soundpass', '1997-03-09'),
('audiophile', 'audio@ear.com', 'listen123', '2004-01-01');


-- Insert Premium Plans
INSERT INTO Premium_Plan (Plan_Name, Duration, Description, Price) VALUES
('Basic Monthly', 1, 'Ad-free music streaming for a month', 99.00),
('Family Plan', 1, 'Up to 6 accounts in one family subscription', 149.00),
('Student Plan', 1, 'Discounted plan for students', 49.00),
('Quarterly Plan', 3, 'Ad-free access for 3 months', 249.00),
('Yearly Plan', 12, 'Full access for a year', 899.00),
('Hi-Fi Plan', 1, 'High-quality audio streaming', 129.00),
('Premium Duo', 1, 'Plan for two people living together', 119.00),
('Podcast Plus', 1, 'Includes exclusive podcasts', 109.00),
('Music + Video', 1, 'Access to music and videos', 159.00),
('Ultimate Family', 12, 'Best family plan with extras', 1399.00);


-- Insert Songs

INSERT INTO Song (Title, Duration, Genre, Album_ID) VALUES
('Shape of You', 233, 'Pop', NULL),
('Blinding Lights', 200, 'Synth-Pop', NULL),
('Bohemian Rhapsody', 355, 'Rock', NULL),
('Fur Elise', 180, 'Classical', NULL),
('Senorita', 190, 'Latin Pop', NULL),
('Lose Yourself', 326, 'Rap', NULL),
('Levitating', 203, 'Disco', NULL),
('Vande Mataram', 240, 'Patriotic', NULL),
('A Sky Full of Stars', 268, 'Alternative', NULL),
('Ocean Eyes', 218, 'Indie', NULL);


-- Insert Playlists

INSERT INTO Playlist (Title, User_ID, Total_Length) VALUES
('Workout Vibes', 1, 0),
('Classical Chill', 7, 0),
('Party Hits', 3, 0),
('Morning Motivation', 5, 0),
('Late Night Drive', 4, 0),
('Study Focus', 2, 0),
('Feel Good Tunes', 6, 0),
('Rock Legends', 8, 0),
('Romantic Songs', 9, 0),
('Top 10 English', 10, 0);

-- Insert Payments

INSERT INTO Payment (User_ID, Plan_ID, Payment_Date, Amount) VALUES
(1, 1, '2025-06-01', 99.00),
(2, 3, '2025-05-15', 49.00),
(3, 4, '2025-06-05', 249.00),
(4, 2, '2025-05-28', 149.00),
(5, 1, '2025-06-10', 99.00),
(6, 6, '2025-06-12', 129.00),
(7, 5, '2025-04-30', 899.00),
(8, 7, '2025-05-25', 119.00),
(9, 8, '2025-06-11', 109.00),
(10, 9, '2025-06-02', 159.00);


--Insert Playlist-Song Mappings

INSERT INTO Playlist_Song (Playlist_ID, Song_ID) VALUES
(1, 1), (1, 2),
(2, 4), (2, 10),
(3, 2), (3, 3), (3, 5),
(4, 6),
(5, 7), (5, 9),
(6, 4),
(7, 1), (7, 8),
(8, 3), (8, 6),
(9, 5), (9, 10),
(10, 1), (10, 2), (10, 3), (10, 4), (10, 5);

--SQL queries for key app features


-- 1. User Views Available Premium Plans
SELECT * FROM Premium_Plan;


-- 2. User Subscribes to a Plan

CALL SubscribeWithTransaction(1, 4); –user with id 1 subscribe to id 4 plan


-- 3. User Checks Plan Expiry Date

SELECT GetPlanExpiry(1) AS Expiry_Date;   - - here user id is 1


-- 4. User Checks If They Have an Active Plan

SELECT HasActivePlan(1) AS Is_Active;


-- 5. User Creates Playlist and Adds Song

CALL CreatePlaylistWithSong(1, 'Chill EDM', 2);  -- Adds "Blinding Lights"


-- 6. Show All Playlists by a User

SELECT Playlist_ID, Title, Total_Length
FROM Playlist
WHERE User_ID = 1;


-- 7. Add More Songs to Existing Playlist

INSERT INTO Playlist_Song (Playlist_ID, Song_ID) VALUES
(1, 3),  -- Add Bohemian Rhapsody to Krish's "Workout Vibes"
(1, 7);  -- Add Levitating

--Then update total length:
UPDATE Playlist
SET Total_Length = (
    SELECT SUM(S.Duration)
    FROM Playlist_Song PS
    JOIN Song S ON S.Song_ID = PS.Song_ID
    WHERE PS.Playlist_ID = 1
)
WHERE Playlist_ID = 1;


-- 8. Get Total Duration of a Playlist
Uses UDF: GetPlaylistDuration(playlist_id)
SELECT GetPlaylistDuration(1) AS Total_Seconds;


-- 9. User Deletes Their Playlist Safely
CALL DeletePlaylistSafe(5);  -- Deletes "Late Night Drive"


-- 10. Analytics: Top 3 Most Used Plans

SELECT PP.Plan_Name, COUNT(*) AS Subscription_Count
FROM Payment PM
JOIN Premium_Plan PP ON PM.Plan_ID = PP.Plan_ID
GROUP BY PP.Plan_Name
ORDER BY Subscription_Count DESC
LIMIT 3;


-- 11. User Profile with Plan Info

SELECT U.User_ID, U.Username, U.Email,
       PP.Plan_Name, PM.Payment_Date, GetPlanExpiry(U.User_ID) AS Expiry
FROM User U
LEFT JOIN Payment PM ON PM.User_ID = U.User_ID
LEFT JOIN Premium_Plan PP ON PP.Plan_ID = PM.Plan_ID
WHERE U.User_ID = 1
ORDER BY PM.Payment_Date DESC
LIMIT 1;


-- 12. Users With Active Plans

SELECT U.User_ID, U.Username
FROM User U
WHERE HasActivePlan(U.User_ID) = 1;


-- 13. Show Songs in a Playlist

SELECT S.Title, S.Genre, S.Duration
FROM Playlist_Song PS
JOIN Song S ON S.Song_ID = PS.Song_ID
WHERE PS.Playlist_ID = 1;


-- 14. Total Payments Made by a User

SELECT U.Username, SUM(PM.Amount) AS Total_Spent
FROM Payment PM
JOIN User U ON U.User_ID = PM.User_ID
GROUP BY U.User_ID
ORDER BY Total_Spent DESC;












