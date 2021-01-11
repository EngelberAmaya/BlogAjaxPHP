<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      
      <li class="nav-item">
        <form class="d-flex">
  		    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
  		    <button class="btn btn-outline-success" type="submit">Search</button>
  		  </form>
      </li>
     
    </ul>

   
    <ul class="nav navbar-right">
        {if isset($smarty.session.user)}
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="?view=perfil">{$smarty.session.user}</a></li>
            <li class="breadcrumb-item"><a href="?view=cuenta">Cuenta</a></li>
            <li class="breadcrumb-item"><a href="?view=logout">Salir</a></li>
          </ol>
        {else}
          <li><a class="nav-link" href="?view=login">Login</a></li>
          <li><a class="nav-link" href="?view=reg">Registrarme</a></li>
        {/if}
      </ul>
  </div>
</nav>

