-- 1. User Table Indexes
CREATE UNIQUE INDEX idx_user_email ON User (Email);

-- 2. Payment Table Indexes
CREATE INDEX idx_payment_user_id ON Payment (User_ID);

-- 3. Artist Table Indexes
CREATE INDEX idx_artist_name ON Artist (Name);

-- 4. Album Table Indexes
CREATE INDEX idx_album_artist_id ON Album (Artist_ID);
CREATE INDEX idx_album_title ON Album (Title);

-- 5. Song Table Indexes
CREATE INDEX idx_song_album_id ON Song (Album_ID);
CREATE INDEX idx_song_title ON Song (Title);

-- 6. Playlist Table Indexes
CREATE INDEX idx_playlist_user_id ON Playlist (User_ID);
CREATE INDEX idx_playlist_title ON Playlist (Title);

-- 7. Playlist_Song Join Table Indexes
CREATE INDEX idx_playlist_song_playlist_id ON Playlist_Song (Playlist_ID);
CREATE INDEX idx_playlist_song_song_id ON Playlist_Song (Song_ID);
