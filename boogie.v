import os


fn main() {
	filename := 'hola.bo'
	mut file := os.open_file(filename, 'r') or {
		println('File desconocido!!')
		exit(1)
	}
	println(file.str())

	file.close()
}