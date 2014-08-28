/****** Object:  Database Cultural    Script Date: 01/01/2014 19:53:59 ******/
CREATE DATABASE  `Cultural` DEFAULT CHARACTER SET utf8;
/****** Object:  Table Member    Script Date: 01/01/2014 19:54:01 ******/
USE `cultural`;
 /****** Object:  Table Board    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `Board`  ( 
  `BoardID`   INT(10) NOT NULL AUTO_INCREMENT,
   `BoardName`   VARCHAR(50) NULL,
   `ParentID`  INT(10)  DEFAULT 0,
   `STATUS`   CHAR(1) NULL,
  PRIMARY KEY ( `BoardID`  ASC)) ;
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '中心概况', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '新闻动态', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '业界动态', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '闲情偶寄', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '合作单位', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '服务社会', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '下载中心', 0, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '中心动态', 2, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ( '公告', 2, '1');
INSERT INTO `Board` ( `BoardName`, `ParentID`, `Status`) VALUES ('业界资讯', 3, '1');
CREATE TABLE   `Member`  ( `MemberID`   INT(10)   NOT NULL AUTO_INCREMENT,
 `LoginID`   VARCHAR  (20) NULL,
 `Password`   VARCHAR  (20) NULL,
 `MembName`   VARCHAR  (10) NULL,
 `Gender`   NCHAR  (1) NULL,
 `JobName`   VARCHAR  (30) NULL,
 `Phone`   VARCHAR  (12) NULL,
 `Email`   VARCHAR  (50) NULL,
 `Address`   VARCHAR  (200) NULL,
 `Resume`   TEXT  NULL,
 `RegTime`   VARCHAR  (20) NULL,
 `DepartID`   INT(10)  NULL,
 `Status`   CHAR  (1) NULL,
 `PhotoURL`   VARCHAR  (100) NULL,
PRIMARY KEY ( `MemberID`  ASC)) ; 

INSERT INTO  `Member`  (
   `LoginID` ,
   `Password` ,
   `MembName` ,
   `Gender` ,
   `JobName` ,
   `Phone` ,
   `Email` ,
   `Address` ,
   `Resume` ,
   `RegTime` ,
   `DepartID` ,
   `Status`,
   `PhotoURL` 
) 
VALUES
  (
    'admin',
    'admin',
    '管理员',
    '男',
    '',
    '',
    '',
    '',
    '',
    '',
    0,
    '5',
    ''
  ) ;
  /****** Object:  Table Link    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `Link`  ( `LinkID`   INT(10)  NOT NULL AUTO_INCREMENT,
   `LinkName`   VARCHAR  (50) NULL,
   `URL`   VARCHAR  (200) NULL,
   `PicURL`   VARCHAR  (100) NULL,
   `URLType`   CHAR  (1) NULL,
   `Weight`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY ( `LinkID`  ASC)) ;
  /****** Object:  Table Information    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `Information`  ( `InfoID`   INT(10) NOT NULL AUTO_INCREMENT,
   `Title`   VARCHAR  (100) NULL,
   `Author`   INT(10)  DEFAULT 0,
   `PubTime`   VARCHAR  (20) NULL,
   `ReadNum`   INT(10)  NULL,
   `PicURL1`   VARCHAR  (100) NULL,
   `PicURL2`   VARCHAR  (100) NULL,
   `AccName1`   VARCHAR  (50) NULL,
   `AccName2`   VARCHAR  (50) NULL,
   `AccURL1`   VARCHAR  (100) NULL,
   `AccURL2`   VARCHAR  (100) NULL,
   `BoardID`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
   `Weight`   INT(10)  NULL,
   `Content`   MEDIUMBLOB  NULL,
  PRIMARY KEY ( `InfoID`  ASC)) ;
  /****** Object:  Table HomeImg    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `HomeImg`  ( `ImgID`   INT(10) NOT NULL AUTO_INCREMENT,
   `ImgDesc`   VARCHAR  (100) NULL,
   `ImgURL`   VARCHAR  (100) NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY  ( `ImgID`  ASC) );
  /****** Object:  Table DownFile    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `DownFile`  ( `FileID`   INT(10) NOT NULL AUTO_INCREMENT,
   `FileOriName`   VARCHAR  (100) NULL,
   `FilePath`   VARCHAR  (100) NULL,
   `DownID`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY ( `FileID`  ASC)) ;
  /****** Object:  Table DownCenter    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `DownCenter`  ( `DownID`   INT(10)   NOT NULL AUTO_INCREMENT,
   `DownTitle`   VARCHAR  (100) NULL,
   `DownDesc`   TEXT  NULL,
   `BoardID`   INT(10)  NULL,
   `PubTime`   VARCHAR  (20) NULL,
   `Author`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY  ( `DownID`  ASC)) ;
  /****** Object:  Table Department    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `Department`  ( `DepartID`   INT(10) NOT NULL AUTO_INCREMENT,
   `DepartName`   VARCHAR  (50) NULL,
   `MainCharge`   VARCHAR  (50) NULL,
   `Describ`   TEXT  NULL,
   `Phone`   VARCHAR  (50) NULL,
   `Address`   VARCHAR  (200) NULL,
   `PicURL`   VARCHAR  (100) NULL,
   `BoardID`   INT(10)  NULL,
   `Weight`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY ( `DepartID`  ASC)) ;
 
  /****** Object:  Table Achievement    Script Date: 01/01/2014 19:54:01 ******/
  CREATE TABLE   `Achievement`  ( `AchieveID`   INT (10) NOT NULL AUTO_INCREMENT,
   `AchieveName`   VARCHAR  (50) NULL,
   `MainCharge`   VARCHAR  (50) NULL,
   `Origon`   VARCHAR  (200) NULL,
   `Publish`   VARCHAR  (50) NULL,
   `Content`   TEXT  NULL,
   `Meaning`   TEXT  NULL,
   `AccName`   VARCHAR  (50) NULL,
   `AccURL`   VARCHAR  (100) NULL,
   `BoardID`   INT(10)  NULL,
   `Status`   CHAR  (1) NULL,
  PRIMARY KEY CLUSTERED ( `AchieveID`  ASC)) ;
  /****** Object:  View ViewMemDepart    Script Date: 01/01/2014 19:54:02 ******/
  CREATE VIEW   ViewMemDepart  AS 
SELECT 
  Member.MemberID,
  Member.LoginID,
  Member.Password,
  Member.MembName,
  Member.Gender,
  Member.JobName,
  Member.Phone,
  Member.Email,
  Member.Address,
  Member.Resume,
  Member.RegTime,
  Member.DepartID,
  Member.Status,
  Member.PhotoURL,
  Department.DepartName 
FROM
  Member 
  INNER JOIN Department 
    ON Member.DepartID = Department.DepartID ;
    /****** Object:  View ViewDownLoad    Script Date: 01/01/2014 19:54:02 ******/
    CREATE VIEW   ViewDownLoad  AS 
    SELECT 
      DownCenter.DownID,
      DownCenter.DownTitle,
      DownCenter.DownDesc,
      DownCenter.BoardID,
      DownCenter.PubTime,
      DownCenter.Author,
      Member.MembName,
      DownCenter.Status AS DownStatus,
      DownFile.FileID,
      DownFile.FileOriName,
      DownFile.FilePath,
      DownFile.Status AS FileStatus,
      Board.BoardName 
    FROM
      DownCenter 
      RIGHT 
      OUTER JOIN DownFile 
        ON DownCenter.DownID = DownFile.DownID 
      INNER JOIN Board 
        ON DownCenter.BoardID = Board.BoardID 
      INNER JOIN Member 
        ON DownCenter.Author = Member.MemberID ;