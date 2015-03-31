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
	<title>Reserve A Book</title>
	<link rel="stylesheet" type="text/css" href="style.css">
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
<h1>View Your Reserved Books</h1> 



<?php
	require_once "db_book.php";
		
	$check = false;
	$u = $_SESSION['userName'];
	$result = mysql_query("	SELECT * FROM books 
	LEFT JOIN reservedbooks ON books.ISBN = reservedbooks.ISBN
	");
            
	if($result === FALSE) 
	{
		echo "There was an error when processing the request";
		die(mysql_error()); 
	}
		
	else
	{
		echo "<table cellspacing='0'>";
		echo "<form action= \"removeReserve.php\" method='post'>";
		echo "<thead>";
		echo"<tr><th>"; echo "ISBN";
		echo"</th><th>"; echo "Title";
		echo"</th><th>"; echo "Author";
		echo "</th><th>"; echo "Edition";
		echo "</th><th>"; echo "Year";
		echo "</th><th>"; echo "Category";
		echo "</th><th>"; echo "Date Reserved";
		echo "</th><th>"; echo "Remove Reservation?";
		echo "</th></tr>";
		echo "</thead>";
		echo "<tbody>";
		$i = 0;
					
		while($row = mysql_fetch_array($result))
		{
			if ($row[8] == $u)
			{
				if (($i % 2) == 0)
				{
					echo"<tr class =\"even\"><td>"; 
				}
		
				else
				{
					echo"<tr><td>"; 
				}
				echo $row[0];
				echo"</td><td>"; echo $row[1];
				echo"</td><td>"; echo $row[2];
				echo "</td><td>"; echo $row[3];
				echo "</td><td>"; echo $row[4];
				echo "</td><td>"; echo "00" . $row[5];
				echo "</td><td>"; echo $row[9];
				echo "</td><td>"; echo"<button name= \"reserveId\" value= $row[0] type=\"submit\">Remove </button>";
				echo "</td></tr>";
				$check = true;
				$i++;
			}
		}		
		echo "</tbody>";
		echo "</form>";
		echo "</table>";
	}
	if ($check == false)
	{
		$url = "noReserved.php";
		header( "Location: $url" );
	}
?>

</center>
</div>
</div>
<?php
echo "<div class=\"footer\">";
echo "<p>Logged in as: " . $_SESSION['userName'] . "</p>";
echo "</div>";
?>
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
</body>

</html>