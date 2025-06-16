
-- User Table

CREATE TABLE User (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Date_of_Birth DATE NOT NULL
);

-- Premium_Plan Table

CREATE TABLE Premium_Plan (
    Plan_ID INT PRIMARY KEY AUTO_INCREMENT,
    Plan_Name VARCHAR(50) NOT NULL,
    Duration INT NOT NULL,           -- Duration in months
    Description TEXT,
    Price DECIMAL(8, 2) NOT NULL
);

-- Payment Table

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Plan_ID INT NOT NULL,
    Amount DECIMAL(8, 2) NOT NULL,
    Payment_Date DATETIME NOT NULL,
    Payment_Method VARCHAR(30),

    FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Plan_ID) REFERENCES Premium_Plan(Plan_ID)
);

-- Artist Table

CREATE TABLE Artist (
    Artist_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Biography TEXT,
    Genre VARCHAR(50)
);

-- Song Table 

CREATE TABLE Song (
    Song_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Duration TIME NOT NULL,                -- Like '00:04:32'
    Release_Date DATE,
    Genre VARCHAR(50),
    Album_ID INT NOT NULL,

    FOREIGN KEY (Album_ID) REFERENCES Album(Album_ID)
);

-- Playlist table

CREATE TABLE Playlist (
    Playlist_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Creation_Date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Total_Duration TIME,                          -- Derived : cached total time
    User_ID INT NOT NULL,

    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);


-- PlayList_Song Table 

CREATE TABLE Playlist_Song (
    Playlist_ID INT NOT NULL,
    Song_ID INT NOT NULL,

    PRIMARY KEY (Playlist_ID, Song_ID),
    FOREIGN KEY (Playlist_ID) REFERENCES Playlist(Playlist_ID) ON DELETE CASCADE,
    FOREIGN KEY (Song_ID) REFERENCES Song(Song_ID) ON DELETE CASCADE
);




