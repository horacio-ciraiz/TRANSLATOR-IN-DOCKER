

function openPage(pageName, elmnt) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
    tablinks[i].style.color = "#FFFFFF";
    tablinks[i].style.borderTop= "0px";
    tablinks[i].style.borderLeft= "0px";
    tablinks[i].style.borderRight= "0px";
   

   
}

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(pageName).style.display = "block";
  document.getElementById(pageName).style.borderCollapse="#00000";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = "#ccc";
  elmnt.style.color="#000000";
  elmnt.style.borderTop= "1px solid black";
  elmnt.style.borderLeft= "1px solid black";
  elmnt.style.borderRight= "1px solid black";
  
}
document.getElementById("defaultOpen").click();





  

function MetodoAbrir() {

  var cod= document.getElementById("Menu").value;
  if(cod=="Menu_Abrir"){
    
    alert(cod);
    var input = document.createElement('input');
    input.type = 'file';
    input.onchange = e => { 
      // getting a hold of the file reference
      var file = e.target.files[0]; 
      // setting up the reader
      var reader = new FileReader();
      reader.readAsText(file,'UTF-8');
      // here we tell the reader what to do when it's done reading...
      reader.onload = readerEvent => {
         var content = readerEvent.target.result; // this is the content!

         document.getElementById("entradatext").value = content;
         
         var editor=CodeMirror.fromTextArea(
          document.getElementById("entradatext"),{
            theme:"neo",
            lineNumbers:true,
            mode: "text/x-java",
            scrollbarStyle:"native",
          
        });
        editor.setSize("550px","300px");
        

          input= document.getElementById("entradatext").value //Consola que tiene el texto 

          //document.getElementById("ConsolaPython").value = input; //Consola secundaria 

      }
   
   }
   
   input.click();

   var slcchange = document.getElementById("Menu");
    slcchange.addEventListener("null", function() {
    });

  }else if ( cod=="Menu_Analizar"){
    alert("Alertas 0007");
    Conexion();
    CodigoTraducido();
    CodigoErroresLexicos();
    CodigoErroresSintacticos();
    CodigoListaTokens();
    CodigoGraphviz();

    //document.getElementById("ConsolaJavaScript").value = "Errores Lexicos******* \n"+ ErroresLexicos + "\n Errores Sintacticos ********* "+ ErroresSintacticos;
  }
  


}

var ErroresLexicos="";
var ErroresSintacticos="";
var CodigoJavaScript="";
var CodigoGraphvizRecuperado="";
var ListaTokens="";

function generarTexto() {
  var texto = [];
  texto.push(CodigoJavaScript);
  return new Blob(texto, {
    type: 'text/plain'
  });
};

function descargarArchivo(contenidoEnBlob, nombreArchivo) {
  //creamos un FileReader para leer el Blob
  var reader = new FileReader();
  //Definimos la función que manejará el archivo
  //una vez haya terminado de leerlo
  reader.onload = function (event) {
    //Usaremos un link para iniciar la descarga
    var save = document.createElement('a');
    save.href = event.target.result;
    save.target = '_blank';
    //Truco: así le damos el nombre al archivo
    save.download = nombreArchivo || 'archivo.dat';
    var clicEvent = new MouseEvent('click', {
      'view': window,
      'bubbles': true,
      'cancelable': true
    });
    //Simulamos un clic del usuario
    //no es necesario agregar el link al DOM.
    save.dispatchEvent(clicEvent);
    //Y liberamos recursos...
    (window.URL || window.webkitURL).revokeObjectURL(save.href);
  };
  //Leemos el blob y esperamos a que dispare el evento "load"
  reader.readAsDataURL(contenidoEnBlob);
};


function MenuDescargar(){
  var cod= document.getElementById("Descargar").value;

  if(cod=="Menu_Descargar"){
    alert("Descargar JavaScript");

    descargarArchivo(generarTexto(), 'archivo.js');

  }else if (cod=="Menu_AST"){
    alert("Descargar AST");
    
    var graphviz = 'digraph {' + CodigoGraphvizRecuperado + '}';

    d3.select("#graph").graphviz()
    .renderDot(graphviz);

  }


}


//----------------------Conexion--------------
function Conexion(){
  var texto="";

  //falta hacer una validacion si el texto esta vacio*************  
  var url= "http://localhost:3030/api/Analizar/";
  texto = document.getElementById("entradatext").value 

  alert(texto);
  var data = {datos:'"'+texto+'"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
    alert(error);
})
.then(function(response) {
    
    alert(response);
    
});
}


//--------recuperar codigo Traducido-------------
function CodigoTraducido(){
  CodigoJavaScript="";
  var texto="";
  var url = "http://localhost:3030/api/CodigoTraducido/";
  var data = {datos:'"'+texto+ '"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
      alert(error);
  })
  .then(function(response) {
      alert(response);
      CodigoJavaScript=response;
      document.getElementById("ConsolaPython").value = CodigoJavaScript;

      

  });

}

//---------- codigo Graphviz----------------
function CodigoGraphviz(){
  CodigoGraphvizRecuperado="";
  var texto="";
  var url = "http://localhost:3030/api/CodigoGraphviz/";
  var data = {datos:'"'+texto+ '"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
      alert(error);
  })
  .then(function(response) {
      alert(response); 

      CodigoGraphvizRecuperado=response;

  });

}



//--------recuperar Errores Lexicos-------------
function CodigoErroresLexicos(){
  ErroresLexicos="";
  var texto="";
  var url = "http://localhost:3030/api/ErroresLexicos/";
  var data = {datos:'"'+texto+ '"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
      alert(error);
  })
  .then(function(response) {
      alert(response); // el response viene el arreglo 

      response.forEach(element => {
        ErroresLexicos+= element + "\n";
      
    });

      document.getElementById("ConsolaJavaScript").value ="Errores Lexicos:\n"+ErroresLexicos;


  });

}
//--------------------errroes sintacticos-----------
function CodigoErroresSintacticos(){
  ErroresSintacticos="";
  var texto="";
  var url = "http://localhost:3030/api/ErroresSintacticos/";
  var data = {datos:'"'+texto+ '"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
      alert(error);
  })
  .then(function(response) {
      alert(response);

      response.forEach(element => {
        ErroresSintacticos+= element + "\n";
      
    });

      document.getElementById("ConsolaJavaScript").value += "\nErrores Sintacticos:\n"+ ErroresSintacticos;



  });

}

//--------------------lista de tokens------------------
function CodigoListaTokens(){
  ErroresSintacticos="";
  var texto="";
  var url = "http://localhost:3030/api/ListaTokens/";
  var data = {datos:'"'+texto+ '"'};
  fetch(url, {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .catch(function(error) {
      alert(error);
  })
  .then(function(response) {
      alert(response);

      response.forEach(element => {
        ListaTokens+= element + "\n";
      
    });

      document.getElementById("ConsolaJavaScript").value += "\nLista de Tokens:\n"+ ListaTokens;



  });

}





function handleFiles(files) {
  alert("cod");
  var file = files[0];
  var reader = new FileReader();
  reader.onload = function (e) {
    alert("cod2");
      // Cuando éste evento se dispara, los datos están ya disponibles.
      // Se trata de copiarlos a una área <div> en la página.
      var output = document.getElementById("fileOutput");
      output.textContent = e.target.result;
      document.getElementById("entradatext").value = output.textContent;
  };
  reader.readAsText(file);
}

