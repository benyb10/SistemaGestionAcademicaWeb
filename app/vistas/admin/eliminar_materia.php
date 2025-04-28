<?php
require '../../config/conexion.php';

try {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        $stmt = $conexion->prepare("DELETE FROM Materias WHERE IdMateria = ?");
        $stmt->execute([$id]);
    }

    header("Location: materias.php");
    exit;
} catch (PDOException $e) {
    // Código de error 23000 = violación de restricción (ej: clave foránea)
    if ($e->getCode() == 23000) {
        $error = urlencode("No se puede eliminar la materia porque tiene estudiantes matriculados.");
    } else {
        $error = urlencode("Error al eliminar la materia.");
    }

    header("Location: materias.php?error=$error");
    exit;
}
