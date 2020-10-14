

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

          document.getElementById("ConsolaPython").value = input; //Consola secundaria 

      }
   
   }
   
   input.click();

   var slcchange = document.getElementById("Menu");
    slcchange.addEventListener("null", function() {
    });

  }else if ( cod=="Menu_Analizar"){
    Conexion();

  }
  


}

function Conexion(){
  alert("Conexion");
  var url= "http://localhost:8001/Analizar/"
  
  var datos= document.getElementById("entradatext").value
  console.log(datos)
  alert("Conexion2");
  $.post(url,{text:datos},function(data,status){
    Console.log.log(status);
    if(data.length==0){
      alert("No hay Errores");
    }else{

      alert("Hay Errores");
    }
  })
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

