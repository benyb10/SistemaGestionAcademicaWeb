/**
 * Funciones comunes para el sistema de gestión académica
 * Puede incluirse en todas las páginas mediante:
 * <script src="../../assets/js/funciones.js"></script>
 */

document.addEventListener("DOMContentLoaded", function () {
    const formulario = document.querySelector("form");

    if (formulario) {
        formulario.addEventListener("submit", function (e) {
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
    }
});


// Validación general de formularios
document.addEventListener('DOMContentLoaded', function() {
    // Aplicar validación a todos los formularios con la clase 'needs-validation'
    const forms = document.querySelectorAll('.needs-validation');
    
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
    
    // Auto-cerrar las alertas después de 5 segundos
    setTimeout(function() {
        const alertas = document.querySelectorAll('.alert-dismissible');
        alertas.forEach(alerta => {
            const botonCerrar = alerta.querySelector('.btn-close');
            if (botonCerrar) {
                botonCerrar.click();
            }
        });
    }, 5000);
});

/**
 * Función para buscar en tablas
 * @param {string} inputId - ID del campo de búsqueda
 * @param {string} tableId - ID de la tabla
 */
function configurarBuscador(inputId, tableId) {
    const inputBusqueda = document.getElementById(inputId);
    if (!inputBusqueda) return;
    
    inputBusqueda.addEventListener('input', function() {
        const filtro = this.value.toLowerCase();
        const tabla = document.getElementById(tableId);
        if (!tabla) return;
        
        const filas = tabla.querySelectorAll('tbody tr');
        filas.forEach(fila => {
            const texto = fila.textContent.toLowerCase();
            fila.style.display = texto.includes(filtro) ? '' : 'none';
        });
    });
}

/**
 * Mostrar una alerta personalizada
 * @param {string} mensaje - Mensaje a mostrar
 * @param {string} tipo - Tipo de alerta (success, danger, warning, info)
 * @param {string} contenedorId - ID del elemento donde insertar la alerta
 */
function mostrarAlerta(mensaje, tipo = 'info', contenedorId = 'alertas-container') {
    const contenedor = document.getElementById(contenedorId);
    if (!contenedor) return;
    
    const alerta = document.createElement('div');
    alerta.className = `alert alert-${tipo} alert-dismissible fade show`;
    alerta.role = 'alert';
    
    alerta.innerHTML = `
        ${mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    contenedor.appendChild(alerta);
    
    // Auto-cerrar después de 5 segundos
    setTimeout(() => {
        alerta.classList.remove('show');
        setTimeout(() => {
            alerta.remove();
        }, 150);
    }, 5000);
}

/**
 * Confirmar acción con un modal
 * @param {string} mensaje - Mensaje de confirmación
 * @param {Function} fnConfirmar - Función a ejecutar si se confirma
 */
function confirmarAccion(mensaje, fnConfirmar) {
    if (confirm(mensaje)) {
        fnConfirmar();
    }
}

/**
 * Formatear fecha a formato local
 * @param {string} fecha - Fecha en formato ISO o similar
 * @returns {string} - Fecha formateada
 */
function formatearFecha(fecha) {
    if (!fecha) return '';
    const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(fecha).toLocaleDateString('es-ES', opciones);
}

/**
 * Seleccionar una fila de una tabla
 * @param {HTMLTableRowElement} fila - Fila de la tabla
 * @param {string} tableId - ID de la tabla
 */
function seleccionarFilaTabla(fila, tableId) {
    const tabla = document.getElementById(tableId);
    if (!tabla) return;
    
    // Quitar selección de todas las filas
    const filas = tabla.querySelectorAll('tbody tr');
    filas.forEach(f => f.classList.remove('table-active'));
    
    // Seleccionar la fila actual
    fila.classList.add('table-active');
}

/**
 * Función para seleccionar una opción en un select
 * @param {string} selectId - ID del elemento select
 * @param {string|number} valor - Valor a seleccionar
 */
function seleccionarOpcion(selectId, valor) {
    const select = document.getElementById(selectId);
    if (!select) return;
    
    for (let i = 0; i < select.options.length; i++) {
        if (select.options[i].value == valor) {
            select.selectedIndex = i;
            break;
        }
    }
}

/**
 * Cargar datos en un formulario
 * @param {Object} datos - Objeto con los datos a cargar
 * @param {string} formId - ID del formulario
 */
function cargarDatosEnFormulario(datos, formId) {
    const form = document.getElementById(formId);
    if (!form) return;
    
    for (const [key, value] of Object.entries(datos)) {
        const campo = form.elements[key];
        if (campo) {
            if (campo.type === 'checkbox') {
                campo.checked = value === '1' || value === true;
            } else if (campo.type === 'radio') {
                const radio = form.querySelector(`input[name="${key}"][value="${value}"]`);
                if (radio) radio.checked = true;
            } else if (campo.tagName === 'SELECT') {
                seleccionarOpcion(campo.id, value);
            } else {
                campo.value = value;
            }
        }
    }
}

/**
 * Función para validar cédula ecuatoriana
 * @param {string} cedula - Número de cédula a validar
 * @returns {boolean} - true si es válida, false si no
 */
function validarCedulaEcuatoriana(cedula) {
    if (!/^\d{10}$/.test(cedula)) {
        return false;
    }
    
    const digitoRegion = parseInt(cedula.substring(0, 2));
    if (digitoRegion < 1 || digitoRegion > 24) {
        return false;
    }
    
    const ultimoDigito = parseInt(cedula.substring(9, 10));
    const pares = parseInt(cedula.substring(1, 2)) + parseInt(cedula.substring(3, 4)) + parseInt(cedula.substring(5, 6)) + parseInt(cedula.substring(7, 8));
    
    let sumaNones = 0;
    for (let i = 0; i < 9; i += 2) {
        const digito = parseInt(cedula.charAt(i)) * 2;
        sumaNones += digito > 9 ? digito - 9 : digito;
    }
    
    const total = sumaNones + pares;
    const modulo = total % 10;
    const resultado = modulo === 0 ? 0 : 10 - modulo;
    
    return resultado === ultimoDigito;
}

/**
 * Función para exportar una tabla a CSV
 * @param {string} tableId - ID de la tabla
 * @param {string} filename - Nombre del archivo a descargar
 */
function exportarTablaACSV(tableId, filename = 'datos.csv') {
    const tabla = document.getElementById(tableId);
    if (!tabla) return;
    
    let csv = [];
    const filas = tabla.querySelectorAll('tr');
    
    for (let i = 0; i < filas.length; i++) {
        const fila = [];
        const celdas = filas[i].querySelectorAll('td, th');
        
        for (let j = 0; j < celdas.length; j++) {
            // Escapar comillas dobles y agregar comillas alrededor del texto
            let texto = celdas[j].innerText;
            texto = texto.replace(/"/g, '""');
            fila.push(`"${texto}"`);
        }
        
        csv.push(fila.join(','));
    }
    
    const csvString = csv.join('\n');
    const blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' });
    
    // Crear enlace para descargar
    const link = document.createElement('a');
    if (link.download !== undefined) {
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', filename);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
}

/**
 * Mostrar u ocultar elemento según condición
 * @param {string} elementoId - ID del elemento
 * @param {boolean} mostrar - true para mostrar, false para ocultar
 */
function toggleElemento(elementoId, mostrar) {
    const elemento = document.getElementById(elementoId);
    if (!elemento) return;
    
    elemento.style.display = mostrar ? '' : 'none';
}

/**
 * Limitar caracteres en un campo de texto
 * @param {HTMLInputElement} input - Elemento input
 * @param {number} maxLength - Longitud máxima
 * @param {string} contadorId - ID del elemento que muestra el contador
 */
function limitarCaracteres(input, maxLength, contadorId) {
    const contador = document.getElementById(contadorId);
    if (!contador) return;
    
    const restantes = maxLength - input.value.length;
    contador.textContent = restantes;
    
    if (restantes < 0) {
        input.value = input.value.slice(0, maxLength);
        contador.textContent = 0;
    }
    
    // Cambiar color según cantidad restante
    if (restantes < 10) {
        contador.className = 'text-danger';
    } else if (restantes < 20) {
        contador.className = 'text-warning';
    } else {
        contador.className = 'text-muted';
    }
}