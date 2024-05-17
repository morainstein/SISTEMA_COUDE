<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
</head>
<body>

  <form action="/api/post/usuarios/login.php" method="POST">
    <input type="email" name="email">
    <input type="password" name="senha">
    <input type="submit">
  </form>
  
</body>
</html>