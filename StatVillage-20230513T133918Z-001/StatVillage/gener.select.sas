
options nodate noovp;

/* This program will generate the html code for the selectable village map */
/* To use this program, change the %type variable to one of 'maxi', 'mini',
   or 'micro' to generate the maximal (128 blocks), mini (64 blocks), or
   micro (32 blocks) maps */
 
/* After running this program, be sure to modify the permission bits to
   allow access to the generated html code */
 
%let type = maxi;
 

/* first generate the html code for the header */

filename  select "select.&type..html";

data _null_;
   file select noprint;
   put "<html>";
   put "<head>";
   put "<title>SFU Statistics - StatVillage - &type-Map of village</title>";
   put '</head>';
   put '<body>';
   put '<a href=//www.math.sfu.ca/stats/Innovation/workshopindex.html>';
   put 'SFU Statistics Workshops</a> - <a href=index.html>';
   put "StatVillage</a> &type-Map";
   put ' ';

   type = symget('type');  /* get the type of map */
   type=compress(type,"'");
   if type='maxi' or type='mini' then do;
      put '<br><blink>This page may take a minute to load and format.';
      put ' Please be patient.</blink>';
   end;

   put '<h2>Selecting units from StatVillage</h2>';
   put 'To select units from StatVillage, simply click on the squares';
   put 'corresponding to the units desired and then press the left';
   put 'button at the bottom of the page (you may have to scroll down';
   put 'to find the buttons).';
   if type='maxi' or type='mini' then do;
      put 'You may wish to adjust your screen size to see the entire';
      put ' village at once.';
   end;
   put 'Units are numbered using a <a href=hownumbered.html>block';
   put ' and unit-within-block system</a>.'; 
   put '<hr>';
   put '<Form method=POST action="/cgi-bin/stats/selectunits.pl">';
 

   /* now to generate the actual selection map */
   if type='maxi' then do;
      nblocks=128;
      rowsize=8;
   end;
   if type='mini' then do;
      nblocks=60;
      rowsize=6;
   end;
   if type='micro' then do;
      nblocks=36;
      rowsize=6;
   end;

   put '<table border colspan=' rowsize '>';
 
   nhouse = nblocks*8;


   block = 1;
   do ii=1 to nhouse by rowsize*8;
      put '<tr>';
      do i=ii to (ii+rowsize*8-1) by 8;
        j=i; jp1=i+1; jp2=i+2; jp3=i+3; jp4=i+4; jp5=i+5; jp6=i+6; jp7=i+7;
      
put '<td><table border=0 colspan=3 cellspacing=0 cellpadding=0>';
put '<tr><td><input type="checkbox" name="unit" value="' j   z4. '"></td>';
put '    <td><input type="checkbox" name="unit" value="' jp1 z4. '"></td>';
put '    <td><input type="checkbox" name="unit" value="' jp2 z4. '"></td></tr>';
put '<tr><td><input type="checkbox" name="unit" value="' jp3 z4. '"></td>';
put '    <td><center>' block '</center>  </td>';
put '    <td><input type="checkbox" name="unit" value="' jp4 z4. '"></td></tr>';
put '<tr><td><input type="checkbox" name="unit" value="' jp5 z4. '"></td>';
put '    <td><input type="checkbox" name="unit" value="' jp6 z4. '"></td>';
put '    <td><input type="checkbox" name="unit" value="' jp7 z4. '"></td></tr>';
put '</table></td>';
      block = block + 1;
      end;
      put '</tr>';
      put ' ';
   end;


    /* now for the closing html code */

   put '</table>';
   put '<hr>';
   put '<P><Input TYPE="submit" VALUE="Get the sample units">';
   put '<Input TYPE="reset" VALUE="Erase all selections"></p>';
   put '</Form>';
   put "<p>A file will be returned to you with the ";
   put "selected unit's information.";
 
   put "<hr>";
   put "<address>";
   put "[";
   put '<A href="http://www.math.sfu.ca/stats/stat_home.html">';
   put 'SFU Stats Home</A>';
   put '|';
   put '<A href="http://www.math.sfu.ca/mast_home.html">';
   put 'SFU Math Home</A>';
   put '|';
   put '<A href="http://www.sfu.ca/">SFU Home</A>]';
   put '<br>';
   put '<a href=mailto:cschwarz@cs.sfu.ca>Email comments ';
   put 'or suggestions to Carl Schwarz (cschwarz@cs.sfu.ca)</a></address>';
   put '</body>';
   put '</html>';

 
    
