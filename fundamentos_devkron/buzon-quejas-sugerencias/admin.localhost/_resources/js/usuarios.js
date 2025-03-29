function eliminar(id) {
    if (!confirm("¿Esta seguro que desea eliminar el usuario?")) return;

    fetch("/usuarios/" + id + "/", {
        headers: {
            "Content-Type": "application/json",
			"Accept": "json"
        },
		method: "DELETE"
    })
	.then((response) => {
		if (!response.ok) {
			throw new Error("Error en la solicitud DELETE");
		}
		return response.json();
	})
	.then((data) => {
		if (!data.success) {
            throw new Error(data.message);
        }

		console.log("Recurso eliminado:", data);
		window.location.reload();
	})
	.catch((error) => {
		console.error("Error:", error);
	});
}

function login(e) {
    e.preventDefault();

    if (!e.target.reportValidity()) return;

    fetch("/usuarios/_login/", {
        headers: {
            // "Content-Type": "application/json",
            "Accept": "json"
        },
        method: "POST",
        body: new FormData(e.target)
    })
	.then((response) => {
		if (!response.ok) {
			throw new Error("Error en la solicitud POST");
		}
		return response.json();
	})
	.then((data) => {
		if (!data.success) {
            throw new Error(data.message);
        }
        
        window.location.href = "/home/"
	})
	.catch((error) => {
		console.error("Error:", error);
		alert(error);
	});
}
