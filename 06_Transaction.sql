-- Subscribe to a Premium Plan (Atomic + Consistent)

DELIMITER $$

CREATE PROCEDURE SubscribeWithTransaction (
    IN p_UserID INT,
    IN p_PlanID INT
)
BEGIN
    DECLARE v_Amount DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- On error, roll back
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Get Plan Price
    SELECT Price INTO v_Amount
    FROM Premium_Plan
    WHERE Plan_ID = p_PlanID;

    -- Insert payment
    INSERT INTO Payment (User_ID, Plan_ID, Payment_Date, Amount)
    VALUES (p_UserID, p_PlanID, NOW(), v_Amount);

    COMMIT;
END$$

DELIMITER ;

--  Create Playlist and Add Initial Song (Multi-step Transaction

DELIMITER $$

CREATE PROCEDURE CreatePlaylistWithSong (
    IN p_UserID INT,
    IN p_Title VARCHAR(100),
    IN p_SongID INT
)
BEGIN
    DECLARE v_PlaylistID INT;
    DECLARE v_SongDuration INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Step 1: Create Playlist
    INSERT INTO Playlist (Title, User_ID, Total_Length)
    VALUES (p_Title, p_UserID, 0);

    SET v_PlaylistID = LAST_INSERT_ID();

    -- Step 2: Get song duration
    SELECT Duration INTO v_SongDuration
    FROM Song
    WHERE Song_ID = p_SongID;

    -- Step 3: Add song to playlist
    INSERT INTO Playlist_Song (Playlist_ID, Song_ID)
    VALUES (v_PlaylistID, p_SongID);

    -- Step 4: Update playlist total length
    UPDATE Playlist
    SET Total_Length = v_SongDuration
    WHERE Playlist_ID = v_PlaylistID;

    COMMIT;
END$$

DELIMITER ;


--  Safely Delete Playlist (Cascade-Like Manual Transaction)

DELIMITER $$

CREATE PROCEDURE DeletePlaylistSafe (
    IN p_PlaylistID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Step 1: Delete songs from junction table
    DELETE FROM Playlist_Song
    WHERE Playlist_ID = p_PlaylistID;

    -- Step 2: Delete actual playlist
    DELETE FROM Playlist
    WHERE Playlist_ID = p_PlaylistID;

    COMMIT;
END$$

DELIMITER ;
