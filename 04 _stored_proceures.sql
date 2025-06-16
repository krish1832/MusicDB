-- Add User

DELIMITER $$

CREATE PROCEDURE AddUser (
    IN p_Username VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_Password VARCHAR(100),
    IN p_DOB DATE
)
BEGIN
    INSERT INTO User (Username, Email, Password, Date_of_Birth)
    VALUES (p_Username, p_Email, p_Password, p_DOB);
END$$

DELIMITER ;

-- User subscribe to Premium Plan

DELIMITER $$

CREATE PROCEDURE SubscribeToPremium (
    IN p_UserID INT,
    IN p_PlanID INT,
    IN p_Amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Payment (User_ID, Plan_ID, Payment_Date, Amount)
    VALUES (p_UserID, p_PlanID, NOW(), p_Amount);
END$$

DELIMITER ;

-- Create a Playlist

DELIMITER $$

CREATE PROCEDURE CreatePlaylist (
    IN p_UserID INT,
    IN p_Title VARCHAR(100)
)
BEGIN
    INSERT INTO Playlist (Title, User_ID, Total_Length)
    VALUES (p_Title, p_UserID, 0);
END$$

DELIMITER ;

-- Add a song to playlist

DELIMITER $$

CREATE PROCEDURE AddSongToPlaylist (
    IN p_PlaylistID INT,
    IN p_SongID INT
)
BEGIN
    INSERT INTO Playlist_Song (Playlist_ID, Song_ID)
    VALUES (p_PlaylistID, p_SongID);

END$$

DELIMITER ;

-- Get all Premium Plans for a User

DELIMITER $$

CREATE PROCEDURE GetUserPlans (
    IN p_UserID INT
)
BEGIN
    SELECT PP.*
    FROM Payment PM
    JOIN Premium_Plan PP ON PP.Plan_ID = PM.Plan_ID
    WHERE PM.User_ID = p_UserID;
END$$

DELIMITER ;





