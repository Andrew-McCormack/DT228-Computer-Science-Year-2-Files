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
	<title>Search By Author Or Title For A Book</title>
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
		<li class='active'><a href="searchByTitle&Author.php"><span>Search For a Book By Title / Author</span></a></li>
		<li><a href="searchByCategory.php"><span>Search For a Book By Category</span></a></li>
		<li><a href="reserve.php"><span>Reserve a Book</span></a></li>
		<li><a href="viewReserved.php"><span>View Reserved Books</span></a></li>
		<li class='last'><a href="logout.php"><span>Log Out</span></a></li>
		</ul>
		</div>
		<center>
<h1>Book Title / Author Search</h1> 

<form id="form4"  method="get">
<fieldset><legend>Search form</legend><p class="first">
<p class="first">
<label for="bookTitle">Book Title:</label>
<input type="text" name="bookTitle"  maxlength="31" size="30"> 
</p>
<p>
<label for="author">Author:</label>
<input type="text" name="author"  maxlength="31" size="30">
</p>
<p>
<p class="submit"><button type="submit" value="Search">Search</button></p>
</fieldset>
</form> 
<?php
	require_once "db_book.php"; 
	$con = require_once "db_book.php";

	function search($searchTerm1, $searchTerm2, $option)
	{
		if ($option == 1)
		{
			$sql = ("SELECT * FROM books WHERE bookTitle LIKE '%".$searchTerm1."%'");
		}
			
		else if ($option == 2)
		{
			$sql = ("SELECT * FROM books WHERE author LIKE '%".$searchTerm1."%'");
		}
			
		else
		{
			$sql = ("SELECT * FROM books WHERE bookTitle LIKE '%".$searchTerm1."%' AND author LIKE '%".$searchTerm2."%'");
		}
	
		$result = mysql_query($sql);
			
		if(mysql_num_rows($result) === 0) 
		{
			echo "No results found, please refine search!";
			die(mysql_error()); 
		}
			
			
		echo "</p>";		

			echo "<table cellspacing='0'>";
			echo "<form action= \"autoReserve.php\" method='post'>";				
			echo "<thead>";	
			echo"<tr><th>"; echo "ISBN";
			echo"</th><th>"; echo "Title";
			echo"</th><th>"; echo "Author";
			echo "</th><th>"; echo "Edition";
			echo "</th><th>"; echo "Year";
			echo "</th><th>"; echo "Category";
			echo "</th><th>"; echo "Reserved";
			echo "</th><th>"; echo "Do You Wish To Reserve?";
			echo "</th></tr>";
			echo"</thead>";
		    
		    echo "<tbody>";
			$i = 0;
		
			// loop through results of database query, displaying them in the table 
			for ($i = 0; $i < mysql_num_rows($result); $i++)
			{

				$ISBN = mysql_result($result, $i, 'ISBN');
				$bookTitle = mysql_result($result, $i, 'bookTitle');
				$author = mysql_result($result, $i, 'author');
				$edition = mysql_result($result, $i, 'edition');
				$year = mysql_result($result, $i, 'year');
				$category = mysql_result($result, $i, 'category');
				$reserved = mysql_result($result, $i, 'reserved');
			
				if (($i % 2) == 0)
				{
					echo"<tr class =\"even\"><td>"; 
				}
		
				else
				{
					echo"<tr><td>"; 
				} 
				echo $ISBN;
				echo"</td><td>"; echo $bookTitle;
				echo "</td><td>"; echo $author;
				echo "</td><td>"; echo $edition;
				echo "</td><td>"; echo $year;
				echo "</td><td>"; echo $category;
				echo "</td><td>"; echo $reserved;
				if (mysql_result($result, $i, 'reserved') == 'Y')
				{
					echo "</td><td>"; echo"<button name= \"reserveId\" disabled>Reserved</button>";
				}
				
				else
				{
					echo "</td><td>"; echo "<button name= \"reserveId\" value= $ISBN type=\"submit\">Reserve </button>";
				}
				
				echo "</td></tr>";
			}	
			
			echo "</tbody>";
			
			echo "</form>";
			echo "</table>";
			
		}
	
	
	
	if ( isset($_GET['bookTitle']) && isset($_GET['author']))
	{
		$t = mysql_real_escape_string( $_GET['bookTitle']);
		$a = mysql_real_escape_string( $_GET['author']); 	

		if (trim($t) != '' || trim($a) != '')
		{
			if (trim($a) == '')
			{		
				search($t, NULL, 1);
			}
		
			else if (trim($t) == '')
			{		
				search($a, NULL, 2);
			}
		
			else
			{		
				search($t, $a, 3);
			}
		}

		else
		{
			echo "You must fill in at least one of the fields!";
		}
	}
	else
	{
		echo "Enter the name of the book, the author or both in the boxes above";
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
</body>
</html>