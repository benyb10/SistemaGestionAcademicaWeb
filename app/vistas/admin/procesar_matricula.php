<?php
require '../../config/conexion.php';
require '../../config/auth.php';

verificarRol('ADMINISTRADOR');

// Validar que los datos obligatorios existan
if (
    !isset($_POST['modo'], $_POST['cedula_estudiante'], $_POST['cedula_secretaria'], 
           $_POST['id_materia'], $_POST['repite_materia'])
) {
    header("Location: matriculas.php?error=Faltan datos para procesar la matrícula");
    exit;
}

$modo = $_POST['modo'];
$cedulaEstudiante = trim($_POST['cedula_estudiante']);
$cedulaSecretaria = trim($_POST['cedula_secretaria']);
$idMateria = intval($_POST['id_materia']);
$repite = intval($_POST['repite_materia']);

// Validar que el estudiante tenga rol ESTUDIANTE
$stmtEstudiante = $conexion->prepare("SELECT Rol FROM Usuarios WHERE Cedula = ?");
$stmtEstudiante->execute([$cedulaEstudiante]);
$estudiante = $stmtEstudiante->fetch(PDO::FETCH_ASSOC);

if (!$estudiante || $estudiante['Rol'] !== 'ESTUDIANTE') {
    header("Location: matriculas.php?error=" . urlencode("El usuario con cédula $cedulaEstudiante no es un estudiante"));
    exit;
}

// Validar que la secretaria tenga rol SECRETARIA o ADMINISTRADOR
$stmtSecretaria = $conexion->prepare("SELECT Rol FROM Usuarios WHERE Cedula = ?");
$stmtSecretaria->execute([$cedulaSecretaria]);
$secretaria = $stmtSecretaria->fetch(PDO::FETCH_ASSOC);

if (!$secretaria || !in_array($secretaria['Rol'], ['SECRETARIA', 'ADMINISTRADOR'])) {
    header("Location: matriculas.php?error=" . urlencode("El usuario con cédula $cedulaSecretaria no es secretaria ni administrador"));
    exit;
}

try {
    // Iniciar transacción para garantizar la integridad de los datos
    $conexion->beginTransaction();

    if ($modo === 'crear') {
        // Crear la matrícula
        $sql = "INSERT INTO Matriculas (CedulaEstudiante, CedulaSecretaria, IdMateria, RepiteMateria)
                VALUES (?, ?, ?, ?)";
        $stmt = $conexion->prepare($sql);
        $stmt->execute([$cedulaEstudiante, $cedulaSecretaria, $idMateria, $repite]);

        // Obtener el ID de la matrícula recién creada
        $idMatricula = $conexion->lastInsertId();

        // Crear registro de notas con valores iniciales en 0
        $sqlNotas = "INSERT INTO Notas (IdMatricula, Nota1, Nota2, Supletorio)
                     VALUES (?, 0, 0, 0)";
        $stmtNotas = $conexion->prepare($sqlNotas);
        $stmtNotas->execute([$idMatricula]);

    } elseif ($modo === 'editar') {
        if (!isset($_POST['id_matricula'])) {
            header("Location: matriculas.php?error=Falta el ID de matrícula para editar");
            exit;
        }
        $id = intval($_POST['id_matricula']);

        // Actualizar la matrícula existente
        $sql = "UPDATE Matriculas
                SET CedulaEstudiante = ?, CedulaSecretaria = ?, IdMateria = ?, RepiteMateria = ?
                WHERE IdMatricula = ?";
        $stmt = $conexion->prepare($sql);
        $stmt->execute([$cedulaEstudiante, $cedulaSecretaria, $idMateria, $repite, $id]);
    } else {
        throw new Exception("Modo de operación no válido.");
    }

    // Confirmar la transacción
    $conexion->commit();
    header("Location: matriculas.php?success=Operación realizada con éxito");
    exit;

} catch (Exception $e) {
    // Revertir los cambios en caso de error
    $conexion->rollBack();
    header("Location: matriculas.php?error=" . urlencode("Error al procesar la operación: " . $e->getMessage()));
    exit;
}