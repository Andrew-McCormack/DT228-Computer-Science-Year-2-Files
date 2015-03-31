<!DOCTYPE html PUBLIC "-//W3C//DD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html lang="en">
<head>
	<meta charset='utf-8'>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="style.css">
   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
	<title>Remove Reserved Books</title>
	
	<?php
		session_start();
		if(!$_SESSION['userName'])
		{
			header("location:login.php");
		}
	?>
</head>

<body>
<div class="wrapper">
	<div id='cssmenu'>
		<ul>
		<li><a href="index.php"><span>Home</span></a></li>
		<li><a href="searchByTitle&Author.php"><span>Search For a Book By Title / Author</span></a></li>
		<li><a href="searchByCategory.php"><span>Search For a Book By Category</span></a></li>
		<li><a href="reserve.php"><span>Reserve a Book</span></a></li>
		<li class='active'><a href="viewReserved.php"><span>View Reserved Books</span></a></li>
		<li class='last'><a href="logout.php"><span>Log Out</span></a></li>
		</ul>
		</div>
	
<center>
<?php
require_once "db_book.php"; 
$reserveId = $_POST["reserveId"];
$u = $_SESSION['userName'];
		$sql1="UPDATE `book`.`books` SET `reserved` = 'N' WHERE `books`.`ISBN` = '". $reserveId."'";
		$sql2="DELETE FROM `book`.`reservedbooks` WHERE `reservedbooks`.`ISBN` ='" . $reserveId ."' AND `reservedbooks`.`userName` ='$u'";
		
		if (!mysql_query($sql1) || !mysql_query($sql2))
		{
			echo "<h1>There was an error when processing the request</h1>";
		}
		
		else
		{
			$result = mysql_query($sql1);
			$result = mysql_query($sql2);
			echo "<h1>Book Successfully Removed!</h1>";
			echo "<a href=\"viewReserved.php\">Remove another reservation?</a>";
		}
		
?>
		
</div>
</div>
<?php
echo "<div class=\"footer\">";
echo "<p>Logged in as: " . $_SESSION['userName'] . "</p>";
echo "</div>";
?>
</center>
</body>
</html>