-- Get Playlist Duration 

DELIMITER $$

CREATE FUNCTION GetPlaylistDuration(p_PlaylistID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalDuration INT;

    SELECT SUM(S.Duration)
    INTO totalDuration
    FROM Playlist_Song PS
    JOIN Song S ON PS.Song_ID = S.Song_ID
    WHERE PS.Playlist_ID = p_PlaylistID;

    RETURN IFNULL(totalDuration, 0);
END$$

DELIMITER ;


-- Returns expiry date of the latest premium plan for a given user.

DELIMITER $$

CREATE FUNCTION GetPlanExpiry(p_UserID INT)
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE expiryDate DATE;

    SELECT DATE_ADD(PM.Payment_Date, INTERVAL PP.Duration MONTH)
    INTO expiryDate
    FROM Payment PM
    JOIN Premium_Plan PP ON PM.Plan_ID = PP.Plan_ID
    WHERE PM.User_ID = p_UserID
    ORDER BY PM.Payment_Date DESC
    LIMIT 1;

    RETURN expiryDate;
END$$

DELIMITER ;

-- check if user has any valid plan

DELIMITER $$

CREATE FUNCTION HasActivePlan(p_UserID INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE isActive BOOLEAN;

    SET isActive = GetPlanExpiry(p_UserID) >= CURDATE();

    RETURN isActive;
END$$

DELIMITER ;

