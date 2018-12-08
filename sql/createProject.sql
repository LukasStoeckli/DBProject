CREATE TABLE MetalBand (
  bandName VARCHAR(100) PRIMARY KEY,
  fans INTEGER,
  formed INTEGER(4) NOT NULL,
  origin VARCHAR(50) NOT NULL REFERENCES Country (country),
  split INTEGER(4)
);

CREATE TABLE MetalStyle (
  SID INTEGER AUTO_INCREMENT PRIMARY KEY,
  bandName VARCHAR(30) NOT NULL REFERENCES MetalBand (bandName),
  style VARCHAR(30) NOT NULL
);

CREATE TABLE Country (
  country VARCHAR(50) PRIMARY KEY,
  area FLOAT NOT NULL
);

CREATE TABLE Population (
  PID INTEGER AUTO_INCREMENT PRIMARY KEY,
  country VARCHAR(50) NOT NULL REFERENCES Country (country),
  year INTEGER(4) NOT NULL,
  population INTEGER NOT NULL
);


CREATE TABLE Weather (
  -- WID INTEGER AUTO_INCREMENT PRIMARY KEY,
  weatherDate DATE NOT NULL,
  LID INTEGER NOT NULL REFERENCES TerrorLocation (LID),
  -- temperature FLOAT NOT NULL,
  rain VARCHAR(30) NOT NULL,
  PRIMARY KEY (weatherDate, LID)
  -- wind -- format?
);


CREATE TABLE TerrorEvent (
  EID BIGINT PRIMARY KEY,
  eventDate DATE NOT NULL, -- some days are '0'
  approxDate VARCHAR(50),
  extended BOOLEAN NOT NULL,
  resolution DATE,
  LID INTEGER NOT NULL REFERENCES TerrorLocation (LID),
  summary TEXT,
  crit1 BOOLEAN,
  crit2 BOOLEAN,
  crit3 BOOLEAN,
  doubtterr INTEGER,
  alternativeID INTEGER,
  alternative VARCHAR(100),
  multiple BOOLEAN,
  success BOOLEAN,
  suicide BOOLEAN,
  nkill INTEGER,
  nkillus INTEGER,
  nkillter INTEGER,
  nwound INTEGER,
  nwoundus INTEGER,
  nwoundte INTEGER,
  property INTEGER,
  propextentID INTEGER,
  propextent VARCHAR(100),
  propvalue INTEGER,
  propcomment TEXT,
  addnotes TEXT,
  weapdetail TEXT,
  gname VARCHAR(100),
  gsubname VARCHAR(100),
  gname2 VARCHAR(100),
  gsubname2 VARCHAR(100),
  gname3 VARCHAR(100),
  gsubname3 VARCHAR(100),
  motive TEXT,
  guncertain1 BOOLEAN,
  guncertain2 BOOLEAN,
  guncertain3 BOOLEAN,
  individual BOOLEAN,
  nperps INTEGER,
  nperpcap INTEGER,
  claimed INTEGER, -- probably bool, but also has '-9'
  claimmodeID INTEGER,
  claimmode VARCHAR(100),
  claim2 BOOLEAN,
  claimmode2ID INTEGER,
  claimmode2 VARCHAR(100),
  claim3 BOOLEAN,
  claimmode3ID INTEGER,
  claimmode3 VARCHAR(100),
  compclaim BOOLEAN,
  ishostkid BOOLEAN, -- idk, sometimes null, sometimes entries even if 0
  nhostkid INTEGER, -- probably number hostages
  nhostkidus INTEGER, -- prbably number us citizens
  nhours INTEGER, -- same garbage values too
  ndays INTEGER,
  divert VARCHAR(50), -- also some kind of country
  country VARCHAR(50), -- some are unknown...
  ransom BOOLEAN,
  ransomamt INTEGER,
  ransomamtus INTEGER,
  ransompaid INTEGER,
  ransompaidus INTEGER,
  ransomnote TEXT,
  hostkidoutcomeID INTEGER,
  hostkidoutcome VARCHAR(100),
  nreleased INTEGER,
  scite1 TEXT,
  scite2 TEXT,
  scite3 TEXT,
  dbsource VARCHAR(100),
  INT_LOG INTEGER,
  INT_IDEO INTEGER,
  INT_MISC INTEGER,
  INT_ANY INTEGER
);

CREATE TABLE TerrorRelation (
  RID INTEGER PRIMARY KEY,
  EID BIGINT NOT NULL REFERENCES TerrorEvent (EID),
  related BIGINT NOT NULL REFERENCES TerrorEvent (EID)
);

CREATE TABLE TerrorLocation (
  LID INTEGER PRIMARY KEY,
  countryID INTEGER,
  country VARCHAR(50) NOT NULL REFERENCES Country (countryName),
  regionID INTEGER,
  region VARCHAR(100),
  provstate VARCHAR(30),
  city VARCHAR(30),
  latitude FLOAT,
  longitude FLOAT,
  specificity INTEGER, -- INTEGER(1) ? DIGIT ?
  vicinity INTEGER, -- bool?
  location TEXT
);

CREATE TABLE TerrorAttack (
  AID INTEGER AUTO_INCREMENT PRIMARY KEY,
  EID BIGINT NOT NULL REFERENCES TerrorEvent (EID),
  attackTypeID INTEGER,
  attackType VARCHAR(50)
);

CREATE TABLE TerrorTarget (
  TID INTEGER AUTO_INCREMENT PRIMARY KEY,
  EID BIGINT NOT NULL REFERENCES TerrorEvent (EID),
  targTypeID INTEGER,
  targType VARCHAR(100),
  targSubtypeID INTEGER,
  targSubtype VARCHAR(100),
  corp VARCHAR(100),
  target TEXT,
  nationalityID INTEGER,
  nationality VARCHAR(50)
);

CREATE TABLE TerrorWeapon (
  WID INTEGER AUTO_INCREMENT PRIMARY KEY,
  EID BIGINT NOT NULL REFERENCES TerrorEvent (EID),
  weapTypeID INTEGER,
  weapType VARCHAR(100),
  weapSubtypeID INTEGER,
  weapSubtype VARCHAR(100)
);
