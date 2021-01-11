{include 'overall/header.tpl'}

<body>

	{include 'overall/nav.tpl'}

	<div class="container text-center" style="margin-top: 100px; width: 38%;">
		<div id="_AJAX_">

		</div>

		<div class="form-signin">
			<h2 class="form-signin-heading">Inicia Sesión</h2>
			<div class="text-left">
				<label for="inputUsuario">Usuario</label>
			</div>
			<input type="text" id="user" class="form-control" placeholder="Introduce tu usuario" required="" autofocus=""><br />

			<div class="text-left">
				<label for="inputContrase">Contraseña</label>
			</div>
			<input type="password" id="pass" class="form-control" placeholder="Introduce tu contraseña" required=""><br />

			<div class="checkbox text-left">
				<label>
					<input type="checkbox" value="1" id="session"> Recordarme
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block" id="send_request" type="button">Iniciar Sesión</button>
		</div>
	</div>

	{include 'overall/footer.tpl'}

	<script>
		window.onload = function(){
			document.getElementById('send_request').onclick = function(){

				var connect, user, pass, session, form, result;
				user = document.getElementById('user').value;
				pass = document.getElementById('pass').value;
				session = document.getElementById('session').checked ? true : false;

				if (user != '' && pass != '') {

					form = 'user=' + user + '&pass=' + pass + '&session=' + session;

					connect = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
					connect.onreadystatechange = function(){

						if (connect.readyState == 4 && connect.status == 200) {

							if (parseInt(connect.responseText) == 1) {
								//Conectado con exito
								// se redireccione
								result = '<div class="alert alert-dismissible alert-success" style="width: 500px;">'
								result += '<button type="button" class="close" data-dismiss="alert">x</button>';
								result += '<strong>Conectado</strong> Bienvenido';
								result += '</div>';
								location.href = '?view=index';
								document.getElementById('_AJAX_').innerHTML = result;
							} else {
								// ERROR: Los datos son incorrectos
								result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
								result += '<button type="button" class="close" data-dismiss="alert">x</button>';
								result += '<strong>ERROR:</strong> Credenciales incorrectas';
								result += '</div>';
								document.getElementById('_AJAX_').innerHTML = result;
							}

						}else if(connect.readyState != 4){
							// Procesando
							result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
							result += '<button type="button" class="close" data-dismiss="alert">x</button>';
							result += 'Procesando...';
							result += '</div>';
							document.getElementById('_AJAX_').innerHTML = result;
						}
					}
					connect.open('POST', '?view=login', true);
					connect.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
					connect.send(form);					

				} else {
					// ERROR: Datos vacios
					result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
					result += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
					result += '<strong>ERROR:</strong> El usuario y la contraseña no pueden estar vacios..';
					result += '</div>';
					document.getElementById('_AJAX_').innerHTML = result;
				}

			}
		}
	</script>

</body>
</html>