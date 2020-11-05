package main

import (
	"log"
	"net/http"
	"time"
)

func main() {

	mux := http.NewServeMux()

	fs := http.FileServer(http.Dir("./"))
	mux.Handle("/", fs)

	server := &http.Server{
		Addr:           ":8086",
		Handler:        mux,
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	log.Println("Servidor escuchando en: http://localhost:8086/Index.html")
	log.Fatal(server.ListenAndServe())

}
