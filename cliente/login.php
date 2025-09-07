<?php
session_start();
require_once('Rutas.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $rutas = new Rutas();

    $email = filter_var($_POST["email"], FILTER_SANITIZE_EMAIL);
    $contrasena = $_POST["contrasena"];
    $data = json_encode(["email" => $email, "contrasena" => $contrasena]);

    $ch = curl_init($rutas->getloginApiUrl());
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ["Content-Type: application/json"]);

    $res = curl_exec($ch);
    curl_close($ch);

    $response = json_decode($res, true);

    if ($response && isset($response['message']['token'])) {
        $_SESSION["usuario"] = $email;
        $_SESSION["token"] = $response['message']['token'];
        header("Location: index.php");
        exit;
    } else {
        $error = "Credenciales incorrectas";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Iniciar Sesión</h2>
    <form method="POST">
        <label>Email:</label>
        <input type="email" name="email" required><br>
        <label>Contraseña:</label>
        <input type="password" name="contrasena" required><br>
        <button type="submit">Ingresar</button>
    </form>
    <?= isset($error) ? "<p>$error</p>" : "" ?>
</body>
</html>
