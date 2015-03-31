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
		<li class='active'><a href="reserve.php"><span>Reserve a Book</span></a></li>
		<li><a href="viewReserved.php"><span>View Reserved Books</span></a></li>
		<li class='last'><a href="logout.php"><span>Log Out</span></a></li>
		</ul>
		</div>
<center>
<h1>Reserve A Book</h1> 

<?php
	require_once "db_book.php"; 
	
	$sql = ("	SELECT * FROM books LEFT JOIN categories ON books.category = categories.categoryID");
          
	$result = mysql_query($sql);
			
			
			$row = mysql_fetch_assoc($result);
 
			// number of results to show per page
			$per_page = 5;
 
			// figure out the total pages in the database
			$total_results = mysql_num_rows($result);
			$total_pages = ceil($total_results / $per_page);
 
			// check if the 'page' variable is set in the URL 
			if (isset($_GET['page']) && is_numeric($_GET['page']))
			{
			$show_page = $_GET['page'];
         
				// make sure the $show_page value is valid
				if ($show_page > 0 && $show_page <= $total_pages)
				{
					$start = ($show_page -1) * $per_page;
					$end = $start + $per_page; 
				}
				else
				{
					// error - show first set of results
					$start = 0;
					$end = $per_page; 
				}       
			}
			else
			{
				// if page isn't set, show first set of results
				$start = 0;
				$end = $per_page; 
			}	
     
		// display pagination
		for ($i = 1; $i <= $total_pages; $i++)
		{
			echo "<a href='reserve.php?page=$i'>$i</a> ";
		}
		echo "</p>";
	
	echo "<table cellspacing='0'>";
	echo "<thead>"; 
	echo "<form action= \"autoReserve.php\" method='post'>";
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
		
	echo"<tbody>";	
			// loop through results of database query, displaying them in the table 
			for ($i = $start; $i < $end; $i++)
			{
				// make sure that PHP doesn't try to show results that don't exist
				if ($i == $total_results) 
				{
					break;
				}
          
				if (($i % 2) == 0)
				{
					echo"<tr class =\"even\"><td>"; 
				}
		
				else
				{
					echo"<tr><td>"; 
				} 
				$ISBN = mysql_result($result, $i, 'ISBN');
				$bookTitle = mysql_result($result, $i, 'bookTitle');
				$author = mysql_result($result, $i, 'author');
				$edition = mysql_result($result, $i, 'edition');
				$year = mysql_result($result, $i, 'year');
				$category = mysql_result($result, $i, 'category');
				$reserved = mysql_result($result, $i, 'reserved');
			
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