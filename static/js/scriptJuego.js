document.addEventListener("DOMContentLoaded", () => {
  // ---- Referencias al DOM ----
  const botonGirar = document.getElementById("boton-girar");
  const preguntaContainer = document.getElementById("question-container");
  const preguntaTitulo = document.getElementById("pregunta-titulo");
  const preguntaImagenContainer = document.getElementById(
    "pregunta-imagen-container",
  );
  const preguntaImagen = document.getElementById("pregunta-imagen");
  const btnHabilitarBotoneras = document.getElementById(
    "btn-habilitar-botoneras",
  );
  const seleccionEquipoResponder = document.getElementById(
    "seleccion-equipo-responder",
  );
  const equiposSelectorRespuesta = document.getElementById(
    "equipos-selector-respuesta",
  );
  const temporizadorEl = document.getElementById("temporizador");
  const opcionesRespuesta = document.getElementById("opciones-respuesta");
  const panelJuicioManual = document.getElementById("panel-juicio-manual");
  const btnJuicioCorrecto = document.getElementById("btn-juicio-correcto");
  const btnJuicioIncorrecto = document.getElementById("btn-juicio-incorrecto");
  const btnTransferirTurno = document.getElementById("btn-transferir-turno");
  const btnDetenerTiempo = document.getElementById("btn-detener-tiempo");
  const panelJuradoFinal =document.getElementById("panel-jurado-final");
  const juradoEquipos = document.getElementById("jurado-equipos");
  const btnSiguienteEnunciado = document.getElementById(
    "btn-siguiente-enunciado",
  );
  const seleccionGanadorFinal = document.getElementById(
    "seleccion-ganador-final",
  );
  const ganadorFinalResumen = document.getElementById("ganador-final-resumen");
  const ganadorFinalEquipos = document.getElementById("ganador-final-equipos");
  const MATERIA_DESEMPATE = "Desempate"; // categoría solo para desempates
  const TIEMPO_BOTONERA = 10; // segundos para presionar la botonera
  const TIEMPO_FINAL = 120; // segundos por enunciado en la Final (Pizarra)
  const PREGUNTAS_FINAL = 3; // enunciados fijos en la Final
  const teamDisplay1 = document.getElementById("team-display-1");
  const teamDisplay2 = document.getElementById("team-display-2");
  const gameArea = document.getElementById("game-area");
  const matchWinnerDisplay = document.getElementById("match-winner-display");
  const matchWinnerName = document.getElementById("match-winner-name");
  const tournamentStatus = document.getElementById("tournament-status");
  const botonSiguiente = document.getElementById("boton-siguiente");
  const winnerModal = document.getElementById("winner-modal");
  const winnerTeamName = document.getElementById("winner-team-name");
  const btnVolverDocente = document.getElementById("btn-volver-docente");
  const categoriaSeleccionadaSpan = document.getElementById(
    "categoria-seleccionada",
  );
  const feedbackContainer = document.getElementById("feedback-container");
  const desempateBanner = document.getElementById("desempate-banner");
  const toastContainer = document.getElementById("toast-container");
  const arrowEl = document.querySelector(".arrow");
  const ruletaCanvas = document.getElementById("ruleta");

  // ---- Estado del Juego ----
  let estadoJuego = {
    torneoRonda: 1,
    enfrentamientosRonda: [],
    ganadoresRonda: [],
    enfrentamientoActualIdx: 0,
    preguntaActualEnfrentamiento: 0,
    totalPreguntasPorEnfrentamiento: 3,
    puntosEnfrentamiento: [0, 0],
    equipoActivoIdx: -1,
    totalEnfrentamientosTorneo: 0,
    enfrentamientoGlobalActual: 0,
    totalRondasTorneo: 1,
    faseActual: 1, // 1 = Cuartos, 2 = Semifinal, 3 = Final
    desempate: { activo: false, puntos: [0, 0], preguntasJugadas: 0 },
  };
  let preguntaActual = null;
  let temporizador = null;
  let respuestaCorrectaTexto = "";

  // ---- Utils ----
  const clearChildren = (el) => {
    while (el.firstChild) el.removeChild(el.firstChild);
  };
  const norm = (s) =>
    String(s ?? "")
      .trim()
      .toLowerCase();

  function showToast(msg, type, ttl = 2200) {
    if (!toastContainer) return;
    const el = document.createElement("div");
    el.className = "toast" + (type ? ` toast--${type}` : "");
    el.textContent = String(msg || "");
    toastContainer.appendChild(el);
    setTimeout(() => {
      if (el.parentNode) el.parentNode.removeChild(el);
    }, ttl);
  }

  // ---- Mapeo ronda de bracket -> fase del torneo ----
  // Se cuenta desde el final: la última ronda jugada es la Final, la
  // anteúltima la Semifinal, y todas las anteriores son Cuartos de Final.
  function calcularFase(ronda, totalRondas) {
    if (ronda === totalRondas) return 3;
    if (ronda === totalRondas - 1) return 2;
    return 1;
  }

  // ===== INICIALIZACIÓN DEL JUEGO CON DATOS DE LA API =====
  async function initGame() {
    try {
      const [equiposRes, preguntasRes, configRes, fasesRes] =
        await Promise.all([
          fetch("/api/equipos"),
          fetch("/api/preguntas?solo_disponibles=1"),
          fetch("/api/configuracion"),
          fetch("/api/fases"),
        ]);

      if (!equiposRes.ok || !preguntasRes.ok || !configRes.ok || !fasesRes.ok) {
        throw new Error(
          "No se pudieron cargar los datos del juego desde el servidor.",
        );
      }

      const equipos = await equiposRes.json();
      const preguntas = await preguntasRes.json();
      const configDB = await configRes.json();
      const fases = await fasesRes.json();

      estadoJuego.totalPreguntasPorEnfrentamiento = configDB.cantidad;

      if (equipos.length < 2) {
        alert(
          "Se necesitan al menos 2 equipos para jugar. Volviendo al panel del docente.",
        );
        window.location.href = "/docente";
        return;
      }
      if (preguntas.length === 0) {
        alert(
          "Se necesita al menos una pregunta disponible para jugar. Volviendo al panel del docente.",
        );
        window.location.href = "/docente";
        return;
      }
      if (!fases || fases.length === 0) {
        alert(
          "No se encontró la configuración de fases del torneo. Volviendo al panel del docente.",
        );
        window.location.href = "/docente";
        return;
      }

      runGame(equipos, preguntas, fases);
    } catch (error) {
      console.error("Error fatal al iniciar el juego:", error);
      alert("Error de conexión. No se pudo iniciar el juego.");
      window.location.href = "/docente";
    }
  }

  // ===== LÓGICA PRINCIPAL DEL JUEGO (RUN GAME) =====
  function runGame(todosLosEquipos, todasLasPreguntas, fasesConfig) {
    // Las preguntas de "Desempate" viven aparte: solo salen en desempates.
    let preguntasDisponibles = todasLasPreguntas.filter(
      (p) => p.materia_nombre !== MATERIA_DESEMPATE,
    );
    let preguntasDesempate = todasLasPreguntas.filter(
      (p) => p.materia_nombre === MATERIA_DESEMPATE,
    );
    let turnoState = { equiposIntentaron: [false, false] };
    const preguntasPorEnfrentamientoConfig =
      estadoJuego.totalPreguntasPorEnfrentamiento;

    const fasesPorId = new Map(fasesConfig.map((f) => [f.id_fase, f]));
    function obtenerFaseActual() {
      return fasesPorId.get(estadoJuego.faseActual);
    }
    function esFinal() {
      return obtenerFaseActual().tipo_respuesta === "pizarra";
    }
    function esDesempate() {
      return estadoJuego.desempate.activo;
    }
    // En desempate la respuesta es directa (solo Correcto / Incorrecto).
    function tipoRondaActual() {
      return esDesempate() ? "directa" : obtenerFaseActual().tipo_respuesta;
    }

    function iniciarTorneo() {
      estadoJuego.totalEnfrentamientosTorneo = todosLosEquipos.length - 1;
      estadoJuego.totalRondasTorneo = Math.max(
        1,
        Math.ceil(Math.log2(todosLosEquipos.length)),
      );
      estadoJuego.faseActual = calcularFase(
        estadoJuego.torneoRonda,
        estadoJuego.totalRondasTorneo,
      );

      const equiposOrdenados = todosLosEquipos.map((e) => ({
        nombre: e.nombre_equipo,
        puntos: 0,
        avatarSrc: null,
      }));

      let equipoQueEspera = null;

      if (equiposOrdenados.length % 2 !== 0) {
        equipoQueEspera = equiposOrdenados.pop();
      }

      for (let i = 0; i < equiposOrdenados.length; i += 2) {
        if (equiposOrdenados[i + 1]) {
          estadoJuego.enfrentamientosRonda.push([
            equiposOrdenados[i],
            equiposOrdenados[i + 1],
          ]);
        }
      }

      if (equipoQueEspera) {
        estadoJuego.ganadoresRonda.push(equipoQueEspera);
      }

      iniciarEnfrentamiento();
    }

    // Las materias representan el tipo de ronda: cada fase busca sus
    // preguntas en la materia homónima ("Multiple", "Directa", "Pizarra").
    const MATERIA_POR_TIPO = {
      opcion_multiple: "Multiple",
      directa: "Directa",
      pizarra: "Pizarra",
    };

    function elegirPreguntaAlAzar() {
      if (esDesempate()) {
        let candidatas = preguntasDesempate;
        if (candidatas.length === 0) {
          candidatas = preguntasDisponibles.filter(
            (p) => p.materia_nombre === MATERIA_POR_TIPO.directa,
          );
          showToast(
            `Sin preguntas en la categoría "${MATERIA_DESEMPATE}"; se usa una de Directa.`,
            "warn",
          );
        }
        return candidatas[Math.floor(Math.random() * candidatas.length)];
      }

      const fase = obtenerFaseActual();
      const materiaFase = MATERIA_POR_TIPO[fase.tipo_respuesta];

      let candidatas = preguntasDisponibles.filter(
        (p) => p.materia_nombre === materiaFase,
      );
      if (candidatas.length === 0) {
        candidatas = preguntasDisponibles;
        showToast(
          `Sin preguntas en la materia "${materiaFase}"; se usa una de otra materia.`,
          "warn",
        );
      }

      if (fase.tipo_respuesta === "pizarra") {
        const conImagen = candidatas.filter((p) => p.imagen_url);
        if (conImagen.length > 0) {
          candidatas = conImagen;
        } else {
          showToast(
            "Sin preguntas con imagen para la Final; se usa una sin imagen.",
            "warn",
          );
        }
      }

      const idx = Math.floor(Math.random() * candidatas.length);
      return candidatas[idx];
    }

    function mostrarResultado() {
      const fase = obtenerFaseActual();

      gameArea.style.display = "none";
      preguntaContainer.style.display = "block";
      feedbackContainer.style.display = "none";
      const tipoRonda = tipoRondaActual();
      categoriaSeleccionadaSpan.textContent = esDesempate()
        ? MATERIA_DESEMPATE
        : fase.nombre;

      preguntaActual = elegirPreguntaAlAzar();
      preguntasDisponibles = preguntasDisponibles.filter(
        (p) => p.id_pregunta !== preguntaActual.id_pregunta,
      );
      preguntasDesempate = preguntasDesempate.filter(
        (p) => p.id_pregunta !== preguntaActual.id_pregunta,
      );
      fetch(`/api/preguntas/${preguntaActual.id_pregunta}/marcar-usada`, {
        method: "PUT",
      }).catch(() => {});

      if (preguntaActual.imagen_url) {
        // En opción múltiple se mantiene el enunciado junto a la imagen.
        if (tipoRonda === "opcion_multiple") {
          preguntaTitulo.textContent = preguntaActual.pregunta;
          preguntaTitulo.style.display = "block";
        } else {
          preguntaTitulo.style.display = "none";
        }
        preguntaImagen.src = preguntaActual.imagen_url;
        preguntaImagenContainer.style.display = "block";
      } else {
        preguntaTitulo.textContent = preguntaActual.pregunta;
        preguntaTitulo.style.display = "block";
        preguntaImagenContainer.style.display = "none";
      }

      const respuestaCorrectaObj = preguntaActual.respuestas.find(
        (r) => r.es_correcta === 1,
      );
      respuestaCorrectaTexto = respuestaCorrectaObj
        ? respuestaCorrectaObj.respuesta
        : "";

      clearChildren(opcionesRespuesta);
      if (tipoRonda === "opcion_multiple") {
        const opcionesMezcladas = [...preguntaActual.respuestas].sort(
          () => Math.random() - 0.5,
        );
        opcionesMezcladas.forEach((op) => {
          const b = document.createElement("button");
          b.className = "btn-opcion";
          b.textContent = op.respuesta;
          b.disabled = true;
          b.onclick = () =>
            resolverRespuesta(
              estadoJuego.equipoActivoIdx,
              norm(op.respuesta) === norm(respuestaCorrectaTexto),
            );
          opcionesRespuesta.appendChild(b);
        });
      }

      clearChildren(equiposSelectorRespuesta);
      const enJuego =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      enJuego.forEach((eq, i) => {
        const b = document.createElement("button");
        b.className = "btn-equipo-selector";
        b.textContent = eq.nombre;
        b.onclick = () => seleccionarEquipoParaResponder(i);
        equiposSelectorRespuesta.appendChild(b);
      });

      turnoState = { equiposIntentaron: [false, false] };
      detenerTemporizador();
      panelJuradoFinal.style.display = "none";
      btnHabilitarBotoneras.textContent = esFinal()
        ? "⏱️ INICIAR TIEMPO"
        : "🔔 Habilitar Botoneras";
      seleccionEquipoResponder.style.display = "none";
      // En opción múltiple las opciones se ven junto a la pregunta
      // (deshabilitadas hasta que un equipo gane el derecho a responder).
      opcionesRespuesta.style.display =
        tipoRonda === "opcion_multiple" ? "flex" : "none";
      panelJuicioManual.style.display = "none";
      btnHabilitarBotoneras.style.display = "block";
      btnHabilitarBotoneras.disabled = false;
    }

    function habilitarBotoneras() {
      btnHabilitarBotoneras.style.display = "none";
      if (esFinal()) {
        // Final: ambos equipos resuelven a la vez, sin botonera.
        iniciarTemporizador(TIEMPO_FINAL, () => tiempoFinalAgotado(), "✍️");
        btnDetenerTiempo.style.display = "block";
        return;
      }
      seleccionEquipoResponder.style.display = "block";
      iniciarTemporizador(TIEMPO_BOTONERA, botoneraSinRespuesta, "🔔");
    }

    // ---- Final (Pizarra): jurado anota aciertos y avanza ----
    function tiempoFinalAgotado(detenidoManual = false) {
      temporizadorEl.style.display = "block";
      temporizadorEl.textContent = detenidoManual
        ? "⏹️ Tiempo detenido"
        : "⏰ Tiempo agotado";

      const enJuego =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      const aciertos = [false, false];
      clearChildren(juradoEquipos);
      enJuego.forEach((eq, i) => {
        const b = document.createElement("button");
        b.className = "btn-equipo-selector";
        b.textContent = eq.nombre;
        b.onclick = () => {
          aciertos[i] = !aciertos[i];
          estadoJuego.puntosEnfrentamiento[i] += aciertos[i] ? 1 : -1;
          b.classList.toggle("acierto", aciertos[i]);
          b.textContent = (aciertos[i] ? "✅ " : "") + eq.nombre;
          actualizarUI();
        };
        juradoEquipos.appendChild(b);
      });

      const esUltimo =
        estadoJuego.preguntaActualEnfrentamiento >=
        estadoJuego.totalPreguntasPorEnfrentamiento;
      btnSiguienteEnunciado.textContent = esUltimo
        ? "VER RESULTADO FINAL"
        : "SIGUIENTE ENUNCIADO";
      panelJuradoFinal.style.display = "block";
    }

    function mostrarSeleccionGanadorFinal() {
      gameArea.style.display = "none";
      preguntaContainer.style.display = "none";
      const enJuego =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      const [p1, p2] = estadoJuego.puntosEnfrentamiento;
      clearChildren(ganadorFinalResumen);
      [
        [enJuego[0].nombre, p1],
        [enJuego[1].nombre, p2],
      ].forEach(([nombre, pts], i) => {
        if (i === 1) {
          const sep = document.createElement("span");
          sep.className = "marcador-sep";
          sep.textContent = "vs";
          ganadorFinalResumen.appendChild(sep);
        }
        const item = document.createElement("div");
        item.className = "marcador-equipo";
        const n = document.createElement("span");
        n.className = "marcador-nombre";
        n.textContent = nombre;
        const p = document.createElement("span");
        p.className = "marcador-puntos";
        p.textContent = String(pts);
        item.append(n, p);
        ganadorFinalResumen.appendChild(item);
      });
      clearChildren(ganadorFinalEquipos);
      enJuego.forEach((eq) => {
        const b = document.createElement("button");
        b.className = "btn-equipo-selector";
        b.textContent = eq.nombre;
        b.onclick = () => {
          seleccionGanadorFinal.style.display = "none";
          mostrarGanadorDelEnfrentamiento(eq);
        };
        ganadorFinalEquipos.appendChild(b);
      });
      seleccionGanadorFinal.style.display = "block";
    }

    // Nadie presionó la botonera a tiempo: se pasa a la siguiente pregunta.
    function botoneraSinRespuesta() {
      seleccionEquipoResponder.style.display = "none";
      setFeedback(
        "Ningún equipo presionó la botonera. Siguiente pregunta.",
        "incorrect",
      );
      setTimeout(avanzarTrasResolucion, 1800);
    }

    function setFeedback(texto, tipo) {
      feedbackContainer.style.display = "block";
      feedbackContainer.className =
        "feedback-container" + (tipo ? " " + tipo : "");
      clearChildren(feedbackContainer);
      const strong = document.createElement("strong");
      strong.textContent = texto;
      feedbackContainer.appendChild(strong);
    }

    function setOpcionesEnabled(enabled) {
      opcionesRespuesta
        .querySelectorAll(".btn-opcion")
        .forEach((b) => (b.disabled = !enabled));
    }

    function setJuicioEnabled(enabled) {
      btnJuicioCorrecto.disabled = !enabled;
      btnJuicioIncorrecto.disabled = !enabled;
    }

    function setDesempateUI(on) {
      if (desempateBanner)
        desempateBanner.style.display = on ? "block" : "none";
    }

    function mostrarPanelRespuesta() {
      if (tipoRondaActual() === "opcion_multiple") {
        opcionesRespuesta.style.display = "flex";
        panelJuicioManual.style.display = "none";
        setOpcionesEnabled(true);
      } else {
        panelJuicioManual.style.display = "flex";
        opcionesRespuesta.style.display = "none";
        setJuicioEnabled(true);
      }
    }

    function iniciarEnfrentamiento() {
      if (
        estadoJuego.enfrentamientoActualIdx >=
        estadoJuego.enfrentamientosRonda.length
      ) {
        finalizarRondaDeTorneo();
        return;
      }
      estadoJuego.enfrentamientoGlobalActual++;

      estadoJuego.totalPreguntasPorEnfrentamiento = esFinal()
        ? PREGUNTAS_FINAL
        : preguntasPorEnfrentamientoConfig;
      estadoJuego.preguntaActualEnfrentamiento = 0;
      estadoJuego.puntosEnfrentamiento = [0, 0];
      estadoJuego.desempate = { activo: false, puntos: [0, 0], preguntasJugadas: 0 };
      setDesempateUI(false);
      siguientePregunta();
    }

    function siguientePregunta() {
      estadoJuego.preguntaActualEnfrentamiento++;
      if (
        estadoJuego.preguntaActualEnfrentamiento >
        estadoJuego.totalPreguntasPorEnfrentamiento
      ) {
        finalizarEnfrentamiento();
        return;
      }
      prepararTurnoUI();
    }

    function prepararTurnoUI() {
      preguntaContainer.style.display = "none";
      matchWinnerDisplay.style.display = "none";
      botonSiguiente.style.display = "none";
      gameArea.style.display = "flex";

      const sinPreguntas = esDesempate()
        ? preguntasDesempate.length === 0 &&
          !preguntasDisponibles.some(
            (p) => p.materia_nombre === MATERIA_POR_TIPO.directa,
          )
        : preguntasDisponibles.length === 0;
      if (sinPreguntas) {
        showToast(
          "¡Felicidades! Han respondido todas las preguntas disponibles.",
          "info",
          3000,
        );
        setTimeout(finalizarJuego, 1000);
        return;
      }

      dibujarRuleta();
      botonGirar.disabled = false;

      actualizarUI();
      updateArrowPosition();
    }

    function finalizarEnfrentamiento() {
      if (esFinal()) {
        // En la Final no hay desempate: el jurado elige al ganador.
        mostrarSeleccionGanadorFinal();
        return;
      }
      const [p1, p2] = estadoJuego.puntosEnfrentamiento;
      const [e1, e2] =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      if (p1 === p2) {
        estadoJuego.desempate = { activo: true, puntos: [0, 0], preguntasJugadas: 0 };
        setDesempateUI(true);
        showToast("Empate → desempate a mejor de 3 preguntas", "warn", 2600);
        prepararTurnoUI();
      } else {
        mostrarGanadorDelEnfrentamiento(p1 > p2 ? e1 : e2);
      }
    }

    function evaluarDesempate() {
      const [d1, d2] = estadoJuego.desempate.puntos;
      const [e1, e2] =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      if (d1 >= 2 || d2 >= 2) {
        const ganador = d1 >= 2 ? e1 : e2;
        estadoJuego.desempate.activo = false;
        setDesempateUI(false);
        mostrarGanadorDelEnfrentamiento(ganador);
      } else {
        estadoJuego.desempate.preguntasJugadas++;
        prepararTurnoUI();
      }
    }

    function mostrarGanadorDelEnfrentamiento(ganador) {
      estadoJuego.ganadoresRonda.push(ganador);
      gameArea.style.display = "none";
      preguntaContainer.style.display = "none";
      matchWinnerName.textContent = ganador.nombre;
      matchWinnerDisplay.style.display = "block";
      botonSiguiente.textContent = esFinal()
        ? "Ver campeón"
        : "Siguiente Enfrentamiento";
      botonSiguiente.style.display = "block";
      botonSiguiente.onclick = () => {
        estadoJuego.enfrentamientoActualIdx++;
        iniciarEnfrentamiento();
      };
    }

    function finalizarRondaDeTorneo() {
      if (estadoJuego.ganadoresRonda.length <= 1) {
        finalizarJuego();
        return;
      }
      estadoJuego.torneoRonda++;
      estadoJuego.faseActual = calcularFase(
        estadoJuego.torneoRonda,
        estadoJuego.totalRondasTorneo,
      );
      const prox = [...estadoJuego.ganadoresRonda];
      estadoJuego.ganadoresRonda = [];
      estadoJuego.enfrentamientoActualIdx = 0;
      estadoJuego.enfrentamientosRonda = [];
      for (let i = 0; i < prox.length; i += 2) {
        if (prox[i + 1])
          estadoJuego.enfrentamientosRonda.push([prox[i], prox[i + 1]]);
        else estadoJuego.ganadoresRonda.push(prox[i]);
      }
      iniciarEnfrentamiento();
    }

    function finalizarJuego() {
      let ganadorFinal = null;
      if (estadoJuego.ganadoresRonda.length === 1) {
        ganadorFinal = estadoJuego.ganadoresRonda[0];
      } else {
        const puntajesFinales = new Map();
        estadoJuego.enfrentamientosRonda.flat().forEach((eq) => {
          if (!puntajesFinales.has(eq.nombre))
            puntajesFinales.set(eq.nombre, 0);
        });
        estadoJuego.ganadoresRonda.forEach((eq) => {
          if (!puntajesFinales.has(eq.nombre))
            puntajesFinales.set(eq.nombre, 0);
        });

        if (estadoJuego.ganadoresRonda.length > 0) {
          ganadorFinal =
            estadoJuego.ganadoresRonda[estadoJuego.ganadoresRonda.length - 1];
        }
      }
      winnerTeamName.textContent = ganadorFinal
        ? ganadorFinal.nombre
        : "No se pudo determinar un ganador";
      winnerModal.style.display = "flex";
    }

    window.seleccionarEquipoParaResponder = (idx) => {
      estadoJuego.equipoActivoIdx = idx;
      seleccionEquipoResponder.style.display = "none";
      mostrarPanelRespuesta();
      iniciarTemporizadorRespuesta();
    };

    function cederTurno(idx) {
      estadoJuego.equipoActivoIdx = idx;
      mostrarPanelRespuesta();
      iniciarTemporizadorRespuesta();
    }

    function iniciarTemporizadorRespuesta() {
      iniciarTemporizador(
        obtenerFaseActual().tiempo_segundos,
        tiempoRespuestaAgotado,
      );
    }

    // Al agotarse el tiempo NO se transfiere solo: se sigue pudiendo
    // responder y se ofrece el botón para pasar el turno manualmente.
    function tiempoRespuestaAgotado() {
      temporizadorEl.style.display = "block";
      temporizadorEl.textContent = "⏰ Tiempo agotado";
      const otroIdx = estadoJuego.equipoActivoIdx === 0 ? 1 : 0;
      btnTransferirTurno.textContent = turnoState.equiposIntentaron[otroIdx]
        ? "➡️ Siguiente pregunta"
        : "🔁 Transferir turno";
      btnTransferirTurno.style.display = "block";
    }

    function registrarPunto(idx) {
      if (estadoJuego.desempate.activo) estadoJuego.desempate.puntos[idx]++;
      else estadoJuego.puntosEnfrentamiento[idx]++;
      actualizarUI();
    }

    function avanzarTrasResolucion() {
      if (estadoJuego.desempate.activo) evaluarDesempate();
      else siguientePregunta();
    }

    function resolverRespuesta(equipoIdx, esCorrecta) {
      detenerTemporizador();
      setOpcionesEnabled(false);
      setJuicioEnabled(false);

      if (esCorrecta) {
        registrarPunto(equipoIdx);
        const nombreEq =
          estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx][
            equipoIdx
          ].nombre;
        setFeedback(`¡Correcto! Punto para ${nombreEq}.`, "correct");
        setTimeout(avanzarTrasResolucion, 2000);
        return;
      }

      const otroIdx = equipoIdx === 0 ? 1 : 0;
      const esPrimerFallo =
        !turnoState.equiposIntentaron[0] && !turnoState.equiposIntentaron[1];
      turnoState.equiposIntentaron[equipoIdx] = true;

      if (esPrimerFallo) {
        const nombreOtro =
          estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx][
            otroIdx
          ].nombre;
        setFeedback(`Incorrecto. Pasa el turno a ${nombreOtro}.`, "incorrect");
        setTimeout(() => {
          feedbackContainer.style.display = "none";
          cederTurno(otroIdx);
        }, 1800);
      } else {
        setFeedback("Ningún equipo respondió correctamente.", "incorrect");
        setTimeout(avanzarTrasResolucion, 1800);
      }
    }

    function renderTeamCard(container, equipo, idxPuntos) {
      clearChildren(container);

      const tpl = document.getElementById("tpl-team-card");
      const fragment = tpl.content.cloneNode(true);
      const card = fragment.querySelector(".team-card");

      card.querySelector(".team-title").textContent = equipo.nombre;

      const puntosFuente = estadoJuego.desempate.activo
        ? estadoJuego.desempate.puntos
        : estadoJuego.puntosEnfrentamiento;
      card.querySelector(".score").textContent = String(
        puntosFuente[idxPuntos],
      );

      const iconContainer = card.querySelector(".team-icon");
      const input = iconContainer.querySelector(".file-input");
      const status = iconContainer.querySelector(".file-status");

      if (equipo.avatarSrc) {
        clearChildren(iconContainer);
        const img = document.createElement("img");
        img.src = equipo.avatarSrc;
        img.classList.add("team-avatar");
        iconContainer.appendChild(img);
      } else {
        input.addEventListener("change", function () {
          const file = this.files[0];
          if (!file) {
            status.textContent = "Ningún archivo seleccionado";
            return;
          }

          const img = document.createElement("img");
          img.src = URL.createObjectURL(file);
          img.classList.add("team-avatar");

          equipo.avatarSrc = img.src;

          clearChildren(iconContainer);
          iconContainer.appendChild(img);
        });
      }

      container.appendChild(card);
    }

    function actualizarUI() {
      const enf =
        estadoJuego.enfrentamientosRonda[estadoJuego.enfrentamientoActualIdx];
      if (!enf) return;
      const nombreFase = obtenerFaseActual().nombre;
      if (estadoJuego.desempate.activo) {
        const [d1, d2] = estadoJuego.desempate.puntos;
        tournamentStatus.textContent = `🔥 ${nombreFase} — DESEMPATE (mejor de 3): ${d1} - ${d2} 🔥`;
      } else {
        tournamentStatus.textContent = `${nombreFase} | Enfrentamiento ${estadoJuego.enfrentamientoGlobalActual} de ${estadoJuego.totalEnfrentamientosTorneo} | Pregunta ${estadoJuego.preguntaActualEnfrentamiento} de ${estadoJuego.totalPreguntasPorEnfrentamiento}`;
      }
      tournamentStatus.style.display = "block";
      const [e1, e2] = enf;
      renderTeamCard(teamDisplay1, e1, 0);
      renderTeamCard(teamDisplay2, e2, 1);
    }

    function iniciarTemporizador(segundos, onFin, icono = "⏰") {
      detenerTemporizador();
      let t = segundos;
      temporizadorEl.style.display = "block";
      const draw = () => {
        temporizadorEl.textContent = `${icono} ${t}s`;
      };
      draw();
      temporizador = setInterval(() => {
        t--;
        draw();
        if (t <= 0) {
          detenerTemporizador();
          onFin();
        }
      }, 1000);
    }

    function detenerTemporizador() {
      clearInterval(temporizador);
      temporizadorEl.style.display = "none";
      btnTransferirTurno.style.display = "none";
      btnDetenerTiempo.style.display = "none";
    }

    // ---- Ruleta de modalidad: Múltiple / Directa / Pizarra ----
    // Los 3 sectores son fijos y el giro siempre debe terminar en el
    // sector correspondiente a la fase actual (no es azar): es un efecto
    // ceremonial que confirma visualmente la modalidad de la ronda.
    // Durante un desempate se añade un 4.º sector "Desempate".
    const categoriasBase = [
      { nombre: "Múltiple", tipo: "opcion_multiple", color: "#3498db" },
      { nombre: "Directa", tipo: "directa", color: "#2ecc71" },
      { nombre: "Pizarra", tipo: "pizarra", color: "#e67e22" },
    ];
    const sectorDesempate = {
      nombre: MATERIA_DESEMPATE,
      tipo: "desempate",
      color: "#e74c3c",
    };
    const sectoresRuleta = () =>
      esDesempate() ? [...categoriasBase, sectorDesempate] : categoriasBase;

    let ruletaCtx = setupHiDPICanvas(ruletaCanvas);
    let anguloActual = 0;
    let animando = false;

    function setupHiDPICanvas(canvas) {
      const dpr = window.devicePixelRatio || 1;
      const rect = canvas.getBoundingClientRect();
      canvas.width = Math.round(rect.width * dpr);
      canvas.height = Math.round(rect.height * dpr);
      const ctx = canvas.getContext("2d");
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      return ctx;
    }

    function updateArrowPosition() {
      if (!arrowEl) return;
      const triH = 18;
      const gap = 18;
      arrowEl.style.top = `${ruletaCanvas.offsetTop - triH + gap}px`;
    }

    function dibujarRuleta() {
      const size = ruletaCanvas.getBoundingClientRect().width;
      const center = size / 2;
      const radio = center - 5;
      ruletaCtx.clearRect(0, 0, size, size);

      const sectores = sectoresRuleta();
      const totalSectores = sectores.length;
      const anguloPorSector = (2 * Math.PI) / totalSectores;

      for (let i = 0; i < totalSectores; i++) {
        const angI = anguloActual + i * anguloPorSector;

        ruletaCtx.fillStyle = sectores[i].color;

        ruletaCtx.beginPath();
        ruletaCtx.moveTo(center, center);
        ruletaCtx.arc(
          center,
          center,
          radio,
          angI,
          angI + anguloPorSector,
          false,
        );
        ruletaCtx.lineTo(center, center);
        ruletaCtx.fill();

        ruletaCtx.save();
        ruletaCtx.fillStyle = "#fff";
        ruletaCtx.font = "bold 16px Poppins";
        ruletaCtx.translate(center, center);
        ruletaCtx.rotate(angI + anguloPorSector / 2);
        ruletaCtx.textAlign = "right";
        ruletaCtx.fillText(sectores[i].nombre, radio - 10, 5);
        ruletaCtx.restore();
      }
    }

    function easeOutCubic(x) {
      return 1 - Math.pow(1 - x, 3);
    }

    function girarRuletaHacia(idxObjetivo) {
      animando = true;
      botonGirar.disabled = true;

      const anguloInicio = anguloActual;
      const totalSectores = sectoresRuleta().length;
      const anguloPorSector = (2 * Math.PI) / totalSectores;
      const angFlecha = 1.5 * Math.PI;

      const angRelDeseado = idxObjetivo * anguloPorSector + anguloPorSector / 2;
      const angParadaDeseado =
        (((angFlecha - angRelDeseado) % (2 * Math.PI)) + 2 * Math.PI) %
        (2 * Math.PI);
      const anguloInicioMod =
        ((anguloInicio % (2 * Math.PI)) + 2 * Math.PI) % (2 * Math.PI);

      let delta = angParadaDeseado - anguloInicioMod;
      delta = ((delta % (2 * Math.PI)) + 2 * Math.PI) % (2 * Math.PI);

      const vueltasExtra = 4 + Math.floor(Math.random() * 3); // 4 a 6 vueltas, solo efecto visual
      const anguloObjetivo =
        anguloInicio + delta + vueltasExtra * 2 * Math.PI;

      const duracionMs = 3200;
      const inicioTs = performance.now();

      function paso(ts) {
        const t = Math.min(1, (ts - inicioTs) / duracionMs);
        const avance = easeOutCubic(t);
        anguloActual = anguloInicio + (anguloObjetivo - anguloInicio) * avance;
        dibujarRuleta();
        if (t < 1) {
          requestAnimationFrame(paso);
        } else {
          animando = false;
          mostrarResultado();
        }
      }
      requestAnimationFrame(paso);
    }

    btnHabilitarBotoneras.onclick = habilitarBotoneras;
    btnDetenerTiempo.onclick = () => {
      detenerTemporizador();
      tiempoFinalAgotado(true);
    };
    btnSiguienteEnunciado.onclick = () => {
      panelJuradoFinal.style.display = "none";
      detenerTemporizador();
      siguientePregunta();
    };
    btnTransferirTurno.onclick = () =>
      resolverRespuesta(estadoJuego.equipoActivoIdx, false);
    btnJuicioCorrecto.onclick = () =>
      resolverRespuesta(estadoJuego.equipoActivoIdx, true);
    btnJuicioIncorrecto.onclick = () =>
      resolverRespuesta(estadoJuego.equipoActivoIdx, false);

    botonGirar.onclick = () => {
      if (animando) return;
      const tipoObjetivo = esDesempate()
        ? sectorDesempate.tipo
        : obtenerFaseActual().tipo_respuesta;
      const idxObjetivo = sectoresRuleta().findIndex(
        (c) => c.tipo === tipoObjetivo,
      );
      girarRuletaHacia(idxObjetivo);
    };

    window.addEventListener("resize", () => {
      ruletaCtx = setupHiDPICanvas(ruletaCanvas);
      dibujarRuleta();
      updateArrowPosition();
    });

    btnVolverDocente.onclick = () => {
      window.location.href = "/docente";
    };

    updateArrowPosition();
    dibujarRuleta();
    iniciarTorneo();
  }

  initGame();
});
