<?php
session_start();
if (!isset($_SESSION['usuario'])) {
    header("Location: login.php");
    exit();
}
$rol = $_SESSION['usuario']['rol'];
$cedula = $_SESSION['usuario']['cedula'];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #4d2c2c">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Sistema Académico</a>
        <div class="d-flex">
            <span class="navbar-text me-3">Cédula: <?= $cedula ?> | Rol: <?= $rol ?></span>
            <a href="logout.php" class="btn btn-light">Cerrar sesión</a>
        </div>
    </div>
</nav>
<img src="recursos/UTA.png" alt="Logo UTA" class="logo img-fluid">

<div class="container mt-4">
    <div class="row">
        <?php if ($rol === 'ADMINISTRADOR'): ?>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Gestión de Usuarios</h5>
                        <a href="vistas/admin/usuarios.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Gestión de Materias</h5>
                        <a href="vistas/admin/materias.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Matrículas</h5>
                        <a href="vistas/admin/matriculas.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Notas</h5>
                        <a href="vistas/admin/notas.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
        <?php elseif ($rol === 'ESTUDIANTE'): ?>
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Mis Materias</h5>
                        <a href="vistas/estudiante/mis_materias.php" class="btn btn-custom">Ver</a>
                    </div>
                </div>
            </div>
        <?php elseif ($rol === 'SECRETARIA'): ?>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Gestión de Estudiantes</h5>
                        <a href="vistas/secretaria/usuarios.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Gestion Matrículas</h5>
                        <a href="vistas/secretaria/matriculas.php" class="btn btn-custom">Ir</a>
                    </div>
                </div>
            </div>
        <?php elseif ($rol === 'PROFESOR'): ?>
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Estudiantes Asignados</h5>
                        <a href="vistas/profesor/mis_estudiantes.php" class="btn btn-custom">Ver</a>
                    </div>
                </div>
            </div>
        <?php endif; ?>
    </div>
</div>
</body>
</html>