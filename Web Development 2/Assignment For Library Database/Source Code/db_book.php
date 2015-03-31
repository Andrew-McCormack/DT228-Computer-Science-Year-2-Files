<?php
$db = mysql_connect('localhost', 'root', ''); 
if ( $db === FALSE ) die('Fail message'); 
if ( mysql_select_db("book") === FALSE ) die("Fail message"); 
?>  