// You can edit this code!
// Click here and start typing.
package main

import (
	"fmt"           //	implements formatted I/O
	"html/template" //	implements data-driven templates for generating HTML
	"net/http"      //	provides HTTP client and server implementations (GET, POST...)
)

//	Sets up an html file to be showed in the defined port.
func index(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("Index.html")) //
	t.Execute(w, "")                                      //
}

func main() {
	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("css/"))))
	http.Handle("/js/", http.StripPrefix("/js/", http.FileServer(http.Dir("js/"))))

	http.HandleFunc("/", index) //	registers a handler function (index) for the pattern ("/")

	fmt.Printf("Servidor escuchando en: http://localhost:8014/") //	message (using fmt package)
	http.ListenAndServe(":8014", nil)                            //	listens on the TCP network address (localhost:8000) and then calls Serve to handle requests on incoming connections.
}
