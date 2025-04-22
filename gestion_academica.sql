-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-04-2025 a las 16:46:30
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_academica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `IdMateria` varchar(10) NOT NULL,
  `NombreMateria` varchar(100) DEFAULT NULL,
  `Creditos` int(11) DEFAULT NULL,
  `IdSemestre` int(11) DEFAULT NULL,
  `IdProfesor` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`IdMateria`, `NombreMateria`, `Creditos`, `IdSemestre`, `IdProfesor`) VALUES
('ABD01', 'Administracion de Base de Datos ', 2, 6, '0819482750'),
('ADT1', 'Auditoría de TI', 3, 8, '1102948364'),
('AL01', 'Álgebra Lineal', 3, 1, '1704127890'),
('AM05', 'Aplicaciones Móviles', 3, 6, '1702384957'),
('APS04', 'Arquitectura de Plataformas de Servidores', 3, 7, '1302849573'),
('AR02', 'Administracion de Redes', 3, 7, '0819482750'),
('ASO1', 'Administración de Sistemas Operativos', 3, 4, '1302849573'),
('BDD1', 'Sistemas de base de Datos Distribuidos', 3, 5, '1102948573'),
('CD01', 'Cálculo Diferencial', 3, 1, '0921947352'),
('CEA02', 'Conmutacion y Enrutamiento Avanzado', 3, 6, '2204837265'),
('CI01', 'Cálculo Integral', 3, 2, '0617234892'),
('CRB1', 'Conmutación y Enrutamiento Básico', 3, 5, '1802957482'),
('DP01', 'Diseño de Proyectos', 3, 8, '1603849261'),
('DP02', 'Desarrollo de Proyectos', 3, 9, '1865849362'),
('ED01', 'Estructura de Datos', 3, 2, '2305926748'),
('EGF01', 'Emprendimiento y Gestion Financiera', 2, 7, '0301928574'),
('FB01', 'Fundamentos de Base de Datos', 3, 3, '0719284751'),
('FI01', 'Física', 3, 1, '1716832950'),
('FP01', 'Fundamentos de Programación', 3, 1, '0965823109'),
('FR01', 'Fundamentos de Redes y Comunicación de Datos', 3, 3, '1802957482'),
('GBD1', 'Gestión de Base de Datos', 3, 4, '2405827394'),
('GEP1', 'Gestión y Evaluación de Proyectos TI', 3, 5, '0921947352'),
('GTI04', 'Gobiernos TI', 2, 6, '0910427863'),
('IHM1', 'Interacción Hombre Máquina', 3, 4, '1405827390'),
('IN04', 'Inteligencia de Negocios', 3, 7, '1203847265'),
('IOP1', 'Investigación Operativa', 3, 5, '0501829467'),
('IS01', 'Integración de Sistemas', 3, 8, '1902847350'),
('ISW1', 'Ingeniería en Software', 3, 4, '1004829471'),
('LM01', 'Lógica Matemática', 3, 2, '1702364905'),
('ME01', 'Medidas Eléctricas', 3, 2, '0401829301'),
('MI01', 'Metodología de la Investigación', 3, 1, '0219427534'),
('MN01', 'Métodos Numéricos', 3, 4, '0501829467'),
('PA01', 'Programación Avanzada', 3, 3, '1102948573'),
('PE01', 'Probabilidad y Estadística', 3, 3, '1704127890'),
('POO1', 'Programación Orientada a Objetos', 3, 2, '2204837265'),
('RN01', 'Realidad Nacional', 3, 2, '0910427863'),
('SO01', 'Sistemas Operativos', 3, 3, '0301928574'),
('SRI1', 'Seguridad de la Información en Redes de Comunicación de Datos', 3, 8, '1302849573'),
('SSD03', 'Sistema de soporte de Decisiones', 2, 6, '1203847265'),
('TDW1', 'Tecnologías de Desarrollo Web', 3, 5, '1702384957');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculas`
--

CREATE TABLE `matriculas` (
  `IdMatricula` int(11) NOT NULL,
  `CedulaEstudiante` varchar(10) DEFAULT NULL,
  `CedulaSecretaria` varchar(10) DEFAULT NULL,
  `IdMateria` varchar(10) DEFAULT NULL,
  `RepiteMateria` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `matriculas`
--

INSERT INTO `matriculas` (`IdMatricula`, `CedulaEstudiante`, `CedulaSecretaria`, `IdMateria`, `RepiteMateria`) VALUES
(4, '1850989318', '1850536242', 'TDW1', 1),
(5, '1805772330', '1812345678', 'TDW1', 1),
(6, '1805772330', '1850536242', 'BDD1', 1),
(7, '1805772330', '1812345678', 'CRB1', 1),
(8, '1850989318', '1850536242', 'BDD1', 1),
(9, '1850989318', '1812345678', 'IOP1', 1),
(11, '1805772330', '1850536242', 'GTI04', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `IdNota` int(11) NOT NULL,
  `IdMatricula` int(11) DEFAULT NULL,
  `Nota1` decimal(5,2) DEFAULT NULL,
  `Nota2` decimal(5,2) DEFAULT NULL,
  `Supletorio` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`IdNota`, `IdMatricula`, `Nota1`, `Nota2`, `Supletorio`) VALUES
(3, 4, 8.00, 5.00, 0.00),
(4, 5, 7.00, 5.00, 8.00),
(5, 6, 0.00, 0.00, 0.00),
(6, 7, 0.00, 0.00, 0.00),
(7, 8, 7.00, 6.00, 8.00),
(8, 9, 7.00, 9.00, 0.00),
(10, 11, 7.00, 6.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `semestres`
--

CREATE TABLE `semestres` (
  `IdSemestre` int(11) NOT NULL,
  `NombreSemestre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `semestres`
--

INSERT INTO `semestres` (`IdSemestre`, `NombreSemestre`) VALUES
(1, 'Primer Semestre'),
(2, 'Segundo Semestre'),
(3, 'Tercer Semestre'),
(4, 'Cuarto Semestre'),
(5, 'Quinto Semestre'),
(6, 'Sexto Semestre'),
(7, 'Séptimo Semestre'),
(8, 'Octavo Semestre'),
(9, 'Noveno Semestre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Cedula` varchar(10) NOT NULL,
  `PrimerNombre` varchar(50) DEFAULT NULL,
  `SegundoNombre` varchar(50) DEFAULT NULL,
  `PrimerApellido` varchar(50) DEFAULT NULL,
  `SegundoApellido` varchar(50) DEFAULT NULL,
  `CorreoInstitucional` varchar(100) DEFAULT NULL,
  `Provincia` varchar(50) DEFAULT NULL,
  `Rol` varchar(20) DEFAULT NULL CHECK (`Rol` in ('ADMINISTRADOR','ESTUDIANTE','PROFESOR','SECRETARIA')),
  `Contrasena` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Cedula`, `PrimerNombre`, `SegundoNombre`, `PrimerApellido`, `SegundoApellido`, `CorreoInstitucional`, `Provincia`, `Rol`, `Contrasena`) VALUES
('0219427534', 'Dario', 'Javier', 'Benavides', 'Padilla', 'dpadilla7534@uta.edu.ec', 'Bolivar', 'PROFESOR', '$2y$10$7A0bxj94PAD9By9Yt2Z1xu6GuYaOe267OVaVpqCGm7gh5OqOtdYnG'),
('0301928574', 'Daniel', 'Sebastian', 'Jerez', 'Mayorga', 'dmayorga8574@uta.edu.ec', 'Cañar', 'PROFESOR', '$2y$10$ibRAN9VnJGEd8FUJ7yXhju7YS2wtq5e6t5nBbqN3kahbrgAkkemV6'),
('0401829301', 'Franklin', 'Wilfredo', 'Salazar', 'Logroño', 'flogrono9301@uta.edu.ec', 'Carchi', 'PROFESOR', '$2y$10$jkX/RA5agXj3EeeSjail.uUxIxl0sBexEoPDAR4/vlFD8LCQY5ByG'),
('0501829467', 'Donald', 'Eduardo', 'Reyes', 'Bedoya', 'dbedoya9467@uta.edu.ec', 'Cotopaxi', 'PROFESOR', '$2y$10$prBQLs6XmOn4u/LB6LULi.Xyj57XywnQU4QR454.nifRvKnOC/rNG'),
('0617234892', 'Gabriel', 'Fernando', 'Leon', 'Paredes', 'gparedes4892@uta.edu.ec', 'Chimborazo', 'PROFESOR', '$2y$10$XyBIW1ALas5BGi6jYxz/leU3q0jxQaRE0HB1rU8J9A2K8WlIDoO8S'),
('0719284751', 'Edwin', 'Hernando', 'Buenaño', 'Valencia', 'evalencia4751@uta.edu.ec', 'El Oro', 'PROFESOR', '$2y$10$WKFq1eEcx.kbxwtXIU8w5.vLnem9KBwD95ZzTdjpM1D.v4eC1OMfi'),
('0819482750', 'Dennis', 'Vinicio', 'Chicaiza', 'Castillo', 'dcastillo2750@uta.edu.ec', 'Esmeraldas', 'PROFESOR', '$2y$10$KTgXLNXTK5nUrNOYi5wunOadSBonQhvRhCSvM1XlxGp4jl8kF02Iy'),
('0910427863', 'Jose', 'Vicente', 'Morales', 'Lozada', 'jlozada7863@uta.edu.ec', 'Guayas', 'PROFESOR', '$2y$10$JEEvwT46/VJrk6.FjecIYeeTLz7yj4mfdWH2hAvHO2Uz2LJ6PPTJi'),
('0921947352', 'Paulo', 'Cesar', 'Torres', 'Abril', 'pabril7352@uta.edu.ec', 'Guayas', 'PROFESOR', '$2y$10$nm560u8LbeM8JXe3a9vF.uB.bbxbjvUxv8jbQk2NjQ3k93dBA0Csq'),
('0956528236', 'Juan', 'Carlos', 'Alejandro', 'Mero', 'jalejandro8236@uta.edu.ec', 'Guayas', 'ESTUDIANTE', '$2y$10$svXcU7OkIN/DRDREOGbvN.Q7MdDu/sPqeGtVsQkpa9RuUAdbzrIvC'),
('0965823109', 'Hernan', 'Fabricio', 'Naranjo', 'Avalos', 'havalos3109@uta.edu.ec', 'Guayas', 'PROFESOR', '$2y$10$NS48PbHI0ZSFJheC/tQrbucU6TGe8cC.Hz19QFIxLtmyrI2LHIkAm'),
('1004829471', 'Oscar', 'Fernando', 'Ibarra', 'Torres', 'otorres9471@uta.edu.ec', 'Imbabura', 'PROFESOR', '$2y$10$RDeHJjcjoZLLxro8OD/jZ.Gc542/koLmARjGn6yEzTJ7An4xe352.'),
('1102948364', 'Julio', 'Enrique', 'Balarezo', 'Lopez', 'jlopez8364@uta.edu.ec', 'Loja', 'PROFESOR', '$2y$10$mytTNWVs9F6zRL/4.Nf0..iUs6z.t.ii32xXVeo.hfbqOCHTOsJ0G'),
('1102948573', 'Jose', 'Ruben', 'Caiza', 'Caizabuano', 'jcaiza8573@uta.edu.ec', 'Loja', 'PROFESOR', '$2y$10$7yw4UHhTpYf1y3NcUBquIu2LsCXM8WfRiHjeLWTGQM3nstEDLr8mi'),
('1203847265', 'Edison', 'Homero', 'Alvarez', 'Mayorga', 'emayorga7265@uta.edu.ec', 'Los Rios', 'PROFESOR', '$2y$10$TllPTjbWZogtgwBxQ4tOQuLVSKiL2w93/uYijhwDxC1n8pOjydoA.'),
('1302849573', 'David', 'Omar', 'Guevara', 'Aulesta', 'daulesta9573@uta.edu.ec', 'Manabi', 'PROFESOR', '$2y$10$QMp07mHsWjxyoVHQlrblFu.g7x.GhJVCOw5vdpU2wnTtPPC8KK0kS'),
('1405827390', 'Marco', 'Vinicio', 'Guachimboza', 'Villalba', 'mvillalba7390@uta.edu.ec', 'Morona Santiago', 'PROFESOR', '$2y$10$QOdykNjHDcuY0EfoKFUUeOyr8FIi7ZSgL4xwAkTzKkYtWYYUhhO.6'),
('1603849261', 'Franklin', 'Oswaldo', 'Mayorga', 'Mayorga', 'fmayorga9261@uta.edu.ec', 'Pastaza', 'PROFESOR', '$2y$10$9R/o5UbSZWntzr.ATzH47ub.PDpO/RV2e6HCEyxO3vLWOM3aJVV..'),
('1702364905', 'Santiago', 'David', 'Jara', 'Moya', 'smoya4905@uta.edu.ec', 'Pichincha', 'PROFESOR', '$2y$10$fltacm9hxAcI343x4GgyCuy.nD1cu1uPaWPx1bhxYwYEoVWCRe4YK'),
('1702384957', 'Clay', 'Fernando', 'Aldas', 'Flores', 'cflores4957@uta.edu.ec', 'Pichincha', 'PROFESOR', '$2y$10$ZQFn5Mj5VX.89CbDIbNgme.mNbertVgxfl6ZYwGCXvJq2.ZMjror6'),
('1704127890', 'Paola', 'Mariela', 'Proaño', 'Molina', 'pmolina7890@uta.edu.ec', 'Pichincha', 'PROFESOR', '$2y$10$Vd2Slm8Le.mKfhPTPN78Ve5Y2RdXdwzlTlFL.yT3NwrqjNzZcoFg6'),
('1716832950', 'Luis', 'Alfredo', 'Pomaquero', 'Moreno', 'lmoreno2950@uta.edu.ec', 'Pichincha', 'PROFESOR', '$2y$10$zb.JKrYL4DmBzUTqBh.07e8Ze3vzw5DKvA0A1W420K7M/LGzopy7S'),
('1802957482', 'Elsa', 'Pilar', 'Urrutia', 'Urrutia', 'eurrutia7482@uta.edu.ec', 'Tungurahua', 'PROFESOR', '$2y$10$EGaakNBFI7uYV3lII468i.4lbp8uIpysFdHFBjnM7E9PWcdClFVJO'),
('1804095956', 'Jesus', 'David', 'Adame', 'Tiguazo', 'jadame5956@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$YViuJAOPBY7HDCCq21eYN.a4qAOWWrWf/lo5C/aVVa1KrEi3tpuLa'),
('1804375010', 'Luis', 'Andres', 'Alcivar', 'Hernandez', 'lalcivar5010@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$iVoqO691RTF59tUAkw9vSu3lYB8GFHB0LT6giCQRKFJxvRH1pck3C'),
('1804836235', 'Marco', 'Vinicio', 'Aguilar', 'Gavilanes', 'maguilar6235@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$08sSEjF79k1SNLok5RkiruPsemp0mx2C2B0hBWXi6U9b31.Y9Zai.'),
('1805244199', 'Edison', 'Joel', 'Acosta', 'Nuñez', 'eacosta4199@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$zkNYmj3t93gfp6Dw6QkrQ.ytZIbsgT.z7KpLwNJ56Rb34z8RdHMrq'),
('1805772330', 'Benjamin', 'Alejandro', 'Raza', 'Guerrero', 'braza2330@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$zJyU6WQ2R/TF3lN8voD/auNJjPEKKEpv2M14Df1PhNRH3vL1HyWce'),
('1805773445', 'Diana', 'Carolina', 'Albuja', 'Coba', 'dalbuja3445@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$/F509x8jW2BmBFXS9.PepuhimDl5sGW5aM0wELlnESrEMXsfvTDCq'),
('1809835620', 'Carlos', 'Israel', 'Nuñez', 'Miranda', 'cmiranda5620@uta.edu.ec', 'Tungurahua', 'PROFESOR', '$2y$10$DHRgKFWa60kCsNJ7VwxPFeb03zk8o1.BsPKRYSboPPUptAAFSC10y'),
('1812345678', 'Alisson', 'Monserath', 'Andrade', 'Ruiz', 'aandrade5678@uta.edu.ec', 'Tungurahua', 'SECRETARIA', '$2y$10$n.e.5W3tj7sS2k/BKb9JlOM/VeZaObIsCDM9CGvURwPygsgTFG0kC'),
('1850091040', 'Dario', 'Josue', 'Acurio', 'Pazmiño', 'dacurio1040@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$DHRCxoEXfPcwWBqIBGPhnev0MJefCmxinQT7U4XkBhPATdNAdLfcC'),
('1850094507', 'Brayan', 'Stiven', 'Alomaliza', 'Chuca', 'balomaliza4507@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$t611zFNszDwb96PgQAx6TeavH2ifJhfjkL9NflVqHqP/6r49lPiLK'),
('1850254929', 'Bryan', 'Alexis', 'Acosta', 'Escobar', 'bacosta4929@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$QnoZp6Y8.kJmgYcExha07OeJF1PGzlgL5rSW1A3TrPCl2BV2sMACy'),
('1850351840', 'Cristal', 'Yanela', 'Acosta', 'Escobar', 'cacosta1840@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$s55wA.MN7PAbBDjmP9OK4eyAVDPnG3DPUJz1wwiszpGEswnanA3US'),
('1850395037', 'Damian', 'Ismael', 'Alban', 'Fuel', 'dalban5037@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$RsFxgAwdzgbaZ6hxie1IleYf12VAagoOQC8yhgmSBSMyPYAtGQx/C'),
('1850529049', 'Steven', 'Xavier', 'Alomaliza', 'Llamuca', 'salomaliza9049@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$63m5t1E9d4D9yTH2RwTfXuBylwrSegOMfLBysDYiXByuC0tCYRP2a'),
('1850536242', 'Bryan', 'Orlando', 'Viteri', 'Yancahtipan', 'bviteri6242@uta.edu.ec', 'Tungurahua', 'ADMINISTRADOR', '$2y$10$erV1N7OIrZHUi1ATilkk.eDuDM9niTbofQ4GeTMfN8JRNgKz7Ss6O'),
('1850600782', 'Wellington', 'Ismael', 'Aldas', 'Jordan', 'waldas0782@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$xR11ic44i2fymG5ISBzUFOVDS5U82dEoJJPzWlfZbvaWp8hqoe0yy'),
('1850989318', 'Ivan', 'Alexander', 'Sanchez', 'Yauli', 'isanchez9318@uta.edu.ec', 'Tungurahua', 'ESTUDIANTE', '$2y$10$8egXvV90zLSYgxDMjl9FeeGEFaJqRH97KkZWBzCyOv6Mbh0/spWiq'),
('1865849362', 'Xavier', 'Francisco', 'Lopez', 'Andrade', 'xandrade9362@uta.edu.ec', 'Tungurahua', 'PROFESOR', '$2y$10$i4fykWGKVvSPtSc2Am25pevaxDdKSekQikPIbd/JHSRijs.NxkPTi'),
('1902847350', 'Klever', 'Renato', 'Urvina', 'Barrionuevo', 'kbarrionuevo7350@uta.edu.ec', 'Zamora Chinchipe', 'PROFESOR', '$2y$10$Xh.ZPGD03522Ni1eQ45RJOs7Ri1Bgf5aENnsgAG8zO8F9UL/reZhK'),
('2204837265', 'Daniel', 'Alejandro', 'Maldonado', 'Ruiz', 'druiz7265@uta.edu.ec', 'Orellana', 'PROFESOR', '$2y$10$1ngzXKYuL9/R6LAQw.22hOVO8IOCzKQLpFjG9V9hoE2aES/ZSTTM6'),
('2305926748', 'Felix', 'Oscar', 'Fernandez', 'Peña', 'fpena6748@uta.edu.ec', 'Santo Domingo de los Tsachilas', 'PROFESOR', '$2y$10$v9SexsdAQjmXbdAflszJlOx.PSz47qDZMybgkWhqbaH1hL/tSLW0C'),
('2405827394', 'Oscar', 'Fernando', 'Buenaño', 'Torres', 'otorres7394@uta.edu.ec', 'Santa Elena', 'PROFESOR', '$2y$10$LPDhY3nL9kAboOaCxS2YoejtEBl9CaD8yoxx9wqp8UV/n7TDEr5Sy');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`IdMateria`),
  ADD KEY `IdSemestre` (`IdSemestre`),
  ADD KEY `IdProfesor` (`IdProfesor`);

--
-- Indices de la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD PRIMARY KEY (`IdMatricula`),
  ADD KEY `CedulaEstudiante` (`CedulaEstudiante`),
  ADD KEY `CedulaSecretaria` (`CedulaSecretaria`),
  ADD KEY `IdMateria` (`IdMateria`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`IdNota`),
  ADD KEY `IdMatricula` (`IdMatricula`);

--
-- Indices de la tabla `semestres`
--
ALTER TABLE `semestres`
  ADD PRIMARY KEY (`IdSemestre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Cedula`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `matriculas`
--
ALTER TABLE `matriculas`
  MODIFY `IdMatricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `IdNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `materias`
--
ALTER TABLE `materias`
  ADD CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`IdSemestre`) REFERENCES `semestres` (`IdSemestre`),
  ADD CONSTRAINT `materias_ibfk_2` FOREIGN KEY (`IdProfesor`) REFERENCES `usuarios` (`Cedula`);

--
-- Filtros para la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`CedulaEstudiante`) REFERENCES `usuarios` (`Cedula`),
  ADD CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`CedulaSecretaria`) REFERENCES `usuarios` (`Cedula`),
  ADD CONSTRAINT `matriculas_ibfk_3` FOREIGN KEY (`IdMateria`) REFERENCES `materias` (`IdMateria`);

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`IdMatricula`) REFERENCES `matriculas` (`IdMatricula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
