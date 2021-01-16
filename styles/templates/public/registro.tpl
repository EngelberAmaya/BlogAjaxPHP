{include 'overall/header.tpl'}

<body>

	{include 'overall/nav.tpl'}

	<div class="container text-center" style="margin-top: 100px; width: 38%;">
		<div id="_AJAX_">

		</div>

		<div class="form-signin">
			<h2 class="form-signin-heading">Registrate</h2>
			<div class="text-left">
				<label for="inputUsuario">Usuario</label>
			</div>
			
			<input type="text" id="user" class="form-control" placeholder="Introduce tu usuario" required="" autofocus=""><br />

			<div class="text-left">
				<label for="inputContrase">Contraseña</label>
			</div>
			<input type="password" id="pass" class="form-control" placeholder="Introduce tu contraseña" required=""><br />

			<div class="text-left">
				<label for="inputEmail">Email</label>
			</div>
			<input type="email" id="email" class="form-control" placeholder="Introduce tu correo electrónico" required=""><br />

			
			<button class="btn btn-lg btn-primary btn-block" id="send_request" type="button">Registrarme</button>
		</div>
	</div>

	{include 'overall/footer.tpl'}

	<script>
		window.onload = function(){
			document.getElementById('send_request').onclick = function(){

				var connect, user, pass, email, form, result;
				user = document.getElementById('user').value;
				pass = document.getElementById('pass').value;
				email = document.getElementById('email').value;

				if (user != '' && pass != '' && email != '') {

					form = 'user=' + user + '&pass=' + pass + '&email=' + email;

					connect = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
					connect.onreadystatechange = function(){

						if (connect.readyState == 4 && connect.status == 200) {
							console.log(connect.responseText);
							if (parseInt(connect.responseText) == 1) {
								//Conectado con exito
								// se redireccione
								result = '<div class="alert alert-dismissible alert-success" style="width: 500px;">'
								result += '<button type="button" class="close" data-dismiss="alert">x</button>';
								result += '<strong>Registro completado</strong> Bienvenido';
								result += '</div>';
								location.href = '?view=index';
								document.getElementById('_AJAX_').innerHTML = result;

							} else if(parseInt(connect.responseText) == 2){
								// ERROR: Los datos son incorrectos
								result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
								result += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
								result += '<strong>ERROR:</strong> El usuario ya existe';
								result += '</div>';
								document.getElementById('_AJAX_').innerHTML = result;

							} else if(parseInt(connect.responseText) == 3){
								// ERROR: Los datos son incorrectos
								result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
								result += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
								result += '<strong>ERROR:</strong> El email ya existe';
								result += '</div>';
								document.getElementById('_AJAX_').innerHTML = result;
							} 

						}else if(connect.readyState != 4){
							// Procesando
							result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
							result += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
							result += 'Procesando...';
							result += '</div>';
							document.getElementById('_AJAX_').innerHTML = result;
						}
					}
					connect.open('POST', '?view=reg', true);
					connect.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
					connect.send(form);					

				} else {
					// ERROR: Datos vacios
					result = '<div class="alert alert-dismissible alert-danger" style="width: 500px;">'
					result += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
					result += '<strong>ERROR:</strong> Todos los campos deben estar llenos';
					result += '</div>';
					document.getElementById('_AJAX_').innerHTML = result;
				}

				
			}
		}
	</script>


</body>
</html>