Sql joining two tables with the same column names

Is there a way for SQL to automatically label the columns based on which table the variable is from?

GitHub
https://tinyurl.com/e9e56m8r
https://github.com/rogerjdeangelis/utl-sql-joining-two-tables-with-the-same-column-names

Inspired by
https://tinyurl.com/5ymb98ta
https://stackoverflow.com/questions/66540391/sql-joining-two-tables-with-the-same-column-names

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data hav1st hav2nd;
  set sashelp.class(keep =name age sex);
run;quit;

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

* create a macro array of variable names;

%array(nams,values=%utl_varlist(hav1st));

/*
%put &=nams1;
%put &=nams2;
%put &=nams3;
%put &=namsn;

NAMS1=NAME
NAMS2=SEX
NAMS3=AGE
NAMSN=3
*/

proc sql;
  create
    table want as
  select
    %do_over(nams,phrase=%str(
       hav1st.? as hav1st_?
      ,hav2nd.? as hav2nd_?), between=comma)
  from
    hav1st, hav2nd
  where
   hav1st.name = hav2nd.name
;quit;

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

WORK.WANT total obs=19

       HAV1ST_    HAV2ND_    HAV1ST_    HAV2ND_    HAV1ST_    HAV2ND_
Obs     NAME       NAME        SEX        SEX        AGE        AGE

  1    Joyce      Joyce         F          F          11         11
  2    Louise     Louise        F          F          12         12
  3    Alice      Alice         F          F          13         13
  4    James      James         M          M          12         12
  5    Thomas     Thomas        M          M          11         11
  6    John       John          M          M          12         12
  7    Jane       Jane          F          F          12         12
  8    Janet      Janet         F          F          15         15
  9    Jeffrey    Jeffrey       M          M          13         13
 10    Carol      Carol         F          F          14         14
 11    Henry      Henry         M          M          14         14
 12    Judy       Judy          F          F          14         14
 13    Robert     Robert        M          M          12         12
 14    Barbara    Barbara       F          F          13         13
 15    Mary       Mary          F          F          15         15
 16    William    William       M          M          15         15
 17    Ronald     Ronald        M          M          15         15
 18    Alfred     Alfred        M          M          14         14
 19    Philip     Philip        M          M          16         16
