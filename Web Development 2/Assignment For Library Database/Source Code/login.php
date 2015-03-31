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
	<title>Login</title>
	<?php
		session_start();
	?>
</head>

<body>
<center>		
<h1>Login To Your Account</h1> 

<?php
require_once "db_book.php"; 

echo "<form id=\"form4\"  method=\"post\">";
echo "<fieldset><legend>Contact form</legend><p class=\"first\">";
 
echo "<p class=\"first\">";
echo "<label for=\"userName\">User Name:</label>";
echo "<input type=\"text\" name=\"userName\" maxlength=\"21\" size=\"30\">"; 
echo "</p>";
echo "<p>";
echo "<label for=\"password\">Password:</label>";
echo "<input type=\"password\" name=\"password\" maxlength=\"6\" size=\"30\">"; 
echo "</p>";
echo "<p>";
echo "<p class=\"submit\"><button type=\"submit\">Submit</button></p>";
echo "</fieldset>";
echo "</form>"; 
echo "</tbody>";
$result = mysql_query("SELECT * FROM users");
	if ( isset($_POST['userName']) && isset($_POST['password']))
	{  
		
		$u = mysql_real_escape_string( $_POST['userName']);
		$p = mysql_real_escape_string( $_POST['password']); 

		// To protect MySQL injection 
		$u = stripslashes($u);
		$u = stripslashes($u);
		$u = mysql_real_escape_string($u);
		$p = mysql_real_escape_string($p);

		$sql="SELECT * FROM users WHERE userName ='$u' and password ='$p'";
		$result=mysql_query($sql);
		
		// Mysql_num_row is counting table row
		$count=mysql_num_rows($result);

		// If result matched $u and $p, table row must be 1 row
		if($count==1)
		{	
			// Register $myusername, $mypassword and redirect to file "index.php"
			$_SESSION['userName'] = $u;
			$_SESSION['password'] = $p;
			header("Location:index.php");
		}
		else 
		{
			echo "Wrong Username or Password";
		}
		
	}	
	ob_end_flush();
?>

<br>
<br>
<a href="register.php">Not registered an account?, click here</a>
</center>
</body>
</html>