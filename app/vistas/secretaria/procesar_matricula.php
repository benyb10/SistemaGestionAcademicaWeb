<?php
require '../../config/conexion.php';
require '../../config/auth.php';

verificarRol('SECRETARIA');

$modo              = $_POST['modo']           ?? 'crear';
$cedulaEstudiante  = $_POST['cedula_estudiante']  ?? '';
$cedulaSecretaria  = $_POST['cedula_secretaria']  ?? '';
$idMateria         = $_POST['id_materia']         ?? '';
$repite            = $_POST['repite_materia']     ?? 1;   // 1‑3

/* ---------- 1. VALIDAR ROLES ---------- */

// Estudiante
$stmtEst = $conexion->prepare("SELECT Rol FROM Usuarios WHERE Cedula = ?");
$stmtEst->execute([$cedulaEstudiante]);
$estInfo = $stmtEst->fetch(PDO::FETCH_ASSOC);

if (!$estInfo || $estInfo['Rol'] !== 'ESTUDIANTE') {
    header("Location: matriculas.php?error=El usuario $cedulaEstudiante no es un estudiante");
    exit;
}

// Secretaria (o Admin)
$stmtSec = $conexion->prepare("SELECT Rol FROM Usuarios WHERE Cedula = ?");
$stmtSec->execute([$cedulaSecretaria]);
$secInfo = $stmtSec->fetch(PDO::FETCH_ASSOC);

if (!$secInfo || !in_array($secInfo['Rol'], ['SECRETARIA','ADMINISTRADOR'])) {
    header("Location: matriculas.php?error=El usuario $cedulaSecretaria no es secretaria ni administrador");
    exit;
}

try {
    $conexion->beginTransaction();

    /* ---------- 2. EVITAR MATRÍCULA DUPLICADA ---------- */
    if ($modo === 'crear') {
        $stmtDup = $conexion->prepare(
            "SELECT COUNT(*) FROM Matriculas
             WHERE CedulaEstudiante = ? AND IdMateria = ?"
        );
        $stmtDup->execute([$cedulaEstudiante, $idMateria]);
        if ($stmtDup->fetchColumn() > 0) {
            throw new Exception("El estudiante ya está matriculado en esta materia");
        }

        /* ---------- 3. INSERTAR MATRÍCULA ---------- */
        $stmtIns = $conexion->prepare(
            "INSERT INTO Matriculas
             (CedulaEstudiante, CedulaSecretaria, IdMateria, RepiteMateria)
             VALUES (?,?,?,?)"
        );
        $stmtIns->execute([
            $cedulaEstudiante,
            $cedulaSecretaria,
            $idMateria,
            $repite
        ]);

        // Crear registro de notas inicial en cero
        $idMatricula = $conexion->lastInsertId();
        $stmtNota = $conexion->prepare(
            "INSERT INTO Notas (IdMatricula, Nota1, Nota2, Supletorio)
             VALUES (?,0,0,0)"
        );
        $stmtNota->execute([$idMatricula]);

    /* ---------- 4. ACTUALIZAR MATRÍCULA ---------- */
    } elseif ($modo === 'editar') {
        $idMatricula = $_POST['id_matricula'];

        // Verificar que la edición no genere duplicado (otro registro diferente)
        $stmtDup = $conexion->prepare(
            "SELECT COUNT(*) FROM Matriculas
             WHERE CedulaEstudiante = ? AND IdMateria = ?
               AND IdMatricula <> ?"
        );
        $stmtDup->execute([$cedulaEstudiante, $idMateria, $idMatricula]);
        if ($stmtDup->fetchColumn() > 0) {
            throw new Exception("Ya existe otra matrícula del mismo estudiante en esta materia");
        }

        $stmtUpd = $conexion->prepare(
            "UPDATE Matriculas
             SET CedulaEstudiante = ?, CedulaSecretaria = ?, IdMateria = ?, RepiteMateria = ?
             WHERE IdMatricula = ?"
        );
        $stmtUpd->execute([
            $cedulaEstudiante,
            $cedulaSecretaria,
            $idMateria,
            $repite,
            $idMatricula
        ]);
    }

    $conexion->commit();
    header("Location: matriculas.php?success=Operación realizada con éxito");
    exit;

} catch (Exception $e) {
    $conexion->rollBack();
    $msg = urlencode($e->getMessage());
    header("Location: matriculas.php?error=$msg");
    exit;
}
