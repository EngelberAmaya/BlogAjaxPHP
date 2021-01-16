<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      {if (isset($smarty.get.view) and $smarty.get.view == 'index') or !isset($smarty.get.view)}
        <li class="active">
      {else}  
      <li class="nav-item">
        {/if}<a class="nav-link" href="?view=index">Inicio</a>
      </li>
     
      
      <li class="nav-item">
        <form class="d-flex navbar-form" role="search" action="?view=buscar" method="POST">
          <div>
              <input class="form-control me-2" name="busqueda" type="search" placeholder="Buscar un post..." aria-label="Search">
          </div>
  		    
  		    <button class="btn btn-outline-success margin" type="submit">Buscar</button>
  		  </form>
      </li>
     
    </ul>

   
    <ul class="nav navbar-nav navbar-right">
        {if isset($smarty.session.user)}
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="?view=perfil&user={$smarty.session.id}">{$smarty.session.user}</a>
            </li>
            <li class="breadcrumb-item"><a href="?view=cuenta">Cuenta</a></li>
            <li class="breadcrumb-item"><a href="?view=logout">Salir</a></li>
          </ol>
        {else}
            {if isset($smarty.get.view) and $smarty.get.view == 'login'}
            <li class="active">
            {else}
            <li>{/if}<a class="nav-link" href="?view=login">Login</a>
            {if isset($smarty.get.view) and $smarty.get.view == 'reg'}
            <li class="active">
            {else}
            <li>{/if}<a class="nav-link" href="?view=reg">Registrarme</a></li>
        {/if}
      </ul>
  </div>
</nav>

