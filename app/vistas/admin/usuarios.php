<?php
require '../../config/conexion.php';
require '../../config/auth.php';

verificarRol('ADMINISTRADOR');

$filtro = $_GET['filtro'] ?? '';
$cedulaEditar = $_GET['editar'] ?? null;
$usuarioEditar = null;

// Obtener todos los usuarios
$sql = "SELECT * FROM usuarios 
        WHERE Cedula LIKE :filtro OR PrimerNombre LIKE :filtro 
        ORDER BY PrimerApellido ASC";
$stmt = $conexion->prepare($sql);
$stmt->execute(['filtro' => "%$filtro%"]);
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Si se va a editar, obtener datos del usuario
if ($cedulaEditar) {
    $sqlEditar = "SELECT * FROM usuarios WHERE Cedula = ?";
    $stmtEditar = $conexion->prepare($sqlEditar);
    $stmtEditar->execute([$cedulaEditar]);
    $usuarioEditar = $stmtEditar->fetch(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #ffffff; }
        .navbar-custom { background-color: #8B0000; }
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link,
        .navbar-custom .navbar-text { color: #ffffff; }
        .btn-rojo { background-color: #8B0000; color: white; }
        .btn-rojo:hover { background-color: #a10000; }
        .table thead { background-color: #8B0000; color: white; }
        h2 { color: #8B0000; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#">Panel Administrador</a>
        <span class="navbar-text">Gestión de Usuarios</span>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="mb-4">Gestión de Usuarios</h2>
    <a href="../../dashboard.php" class="btn btn-rojo mb-3">← Volver al Dashboard</a>

    <!-- Formulario de Crear / Editar -->
    <form action="procesar_usuario.php" method="POST" class="border p-4 rounded shadow-sm bg-light mb-4">
        <input type="hidden" name="modo" value="<?= $usuarioEditar ? 'editar' : 'crear' ?>">
        <div class="row g-3">
            <div class="col-md-2">
                <input type="text" name="cedula" class="form-control" placeholder="Cédula" required value="<?= $usuarioEditar['Cedula'] ?? '' ?>" <?= $usuarioEditar ? 'readonly' : '' ?>>
            </div>
            <div class="col-md-2">
                <input type="password" name="contrasena" class="form-control" placeholder="<?= $usuarioEditar ? 'Nueva Contraseña (opcional)' : 'Contraseña' ?>">
            </div>
            <div class="col-md-2">
                <input type="text" name="primer_nombre" class="form-control" placeholder="Primer Nombre" required value="<?= $usuarioEditar['PrimerNombre'] ?? '' ?>">
            </div>
            <div class="col-md-2">
                <input type="text" name="segundo_nombre" class="form-control" placeholder="Segundo Nombre" required value="<?= $usuarioEditar['SegundoNombre'] ?? '' ?>">
            </div>
            <div class="col-md-2">
                <input type="text" name="primer_apellido" class="form-control" placeholder="Primer Apellido" required value="<?= $usuarioEditar['PrimerApellido'] ?? '' ?>">
            </div>
            <div class="col-md-2">
                <input type="text" name="segundo_apellido" class="form-control" placeholder="Segundo Apellido" required value="<?= $usuarioEditar['SegundoApellido'] ?? '' ?>">
            </div>
            <div class="col-md-3">
                <input type="email" name="correo" class="form-control" placeholder="Correo Institucional" required value="<?= $usuarioEditar['CorreoInstitucional'] ?? '' ?>">
            </div>
            <div class="col-md-3">
                <input type="text" name="provincia" class="form-control" placeholder="Provincia" required value="<?= $usuarioEditar['Provincia'] ?? '' ?>">
            </div>
            <div class="col-md-3">
                <select name="rol" class="form-select" required>
                    <option value="">Rol</option>
                    <option value="ADMINISTRADOR" <?= (isset($usuarioEditar) && $usuarioEditar['Rol'] == 'ADMINISTRADOR') ? 'selected' : '' ?>>Administrador</option>
                    <option value="ESTUDIANTE" <?= (isset($usuarioEditar) && $usuarioEditar['Rol'] == 'ESTUDIANTE') ? 'selected' : '' ?>>Estudiante</option>
                    <option value="PROFESOR" <?= (isset($usuarioEditar) && $usuarioEditar['Rol'] == 'PROFESOR') ? 'selected' : '' ?>>Profesor</option>
                    <option value="SECRETARIA" <?= (isset($usuarioEditar) && $usuarioEditar['Rol'] == 'SECRETARIA') ? 'selected' : '' ?>>Secretaria</option>
                </select>
            </div>
            <div class="col-md-12 text-end">
                <button class="btn btn-rojo mt-3" type="submit"><?= $usuarioEditar ? 'Actualizar Usuario' : 'Guardar Usuario' ?></button>
            </div>
        </div>
    </form>

    <!-- Buscador -->
    <form method="GET" class="mb-3">
        <input type="text" name="filtro" class="form-control" placeholder="Buscar por nombre o cédula (Enter)" value="<?= htmlspecialchars($filtro) ?>">
    </form>

    <!-- Tabla de Usuarios -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover shadow-sm">
            <thead>
                <tr>
                    <th>Cédula</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                    <th>Provincia</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($usuarios as $u): ?>
                <tr>
                    <td><?= $u['Cedula'] ?></td>
                    <td><?= $u['PrimerNombre'] . ' ' . $u['SegundoNombre'] ?></td>
                    <td><?= $u['PrimerApellido'] . ' ' . $u['SegundoApellido'] ?></td>
                    <td><?= $u['CorreoInstitucional'] ?></td>
                    <td><?= $u['Provincia'] ?></td>
                    <td><?= $u['Rol'] ?></td>
                    <td>
                        <a href="usuarios.php?editar=<?= $u['Cedula'] ?>" class="btn btn-warning btn-sm">Editar</a>
                        <a href="eliminar_usuario.php?cedula=<?= $u['Cedula'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar este usuario?')">Eliminar</a>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
<script>
document.querySelector("form").addEventListener("submit", function(e) {
    const cedula = document.querySelector('input[name="cedula"]').value.trim();
    const correo = document.querySelector('input[name="correo"]').value.trim();

    // Validar cédula (exactamente 10 dígitos)
    if (!/^\d{10}$/.test(cedula)) {
        alert("La cédula debe contener exactamente 10 dígitos.");
        e.preventDefault();
        return;
    }

    // Validar correo institucional
    if (!correo.endsWith("@uta.edu.ec")) {
        alert("El correo debe ser institucional y terminar en @uta.edu.ec.");
        e.preventDefault();
        return;
    }
});
</script>
</body>
</html>