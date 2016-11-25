CREATE DOMAIN posint AS smallint CHECK ( VALUE > 0 );

CREATE TABLE Artists (
    aname    varchar(20) PRIMARY KEY,
    atype    varchar(10) CHECK ( atype IN ('BAND','PERSON') ),
    country  char(3)
);

CREATE TABLE Albums (
    title   varchar(30),
    artist  varchar(20) REFERENCES Artists(aname),
    ryear   posint,
    rtype   varchar(20) CHECK ( rtype IN ('LIVE','STUDIO','COMPILATION') ),
    tracks  posint,
    rating  smallint    CHECK ( rating > 0 AND rating <= 5),
    PRIMARY KEY (title, artist)
);

CREATE TABLE Tracks (
    album_title   varchar(30),
    album_artist  varchar(20),
    track_number  posint,
    track_title   varchar(30),
    track_length  posint,
    PRIMARY KEY (album_title, album_artist, track_number),
    FOREIGN KEY (album_title, album_artist)
        REFERENCES Albums(title, artist)
);
