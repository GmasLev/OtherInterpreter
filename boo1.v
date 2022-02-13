
struct Lexer {
	mut:
	data		string
	tokens		map[string]string
	keywords	[]string = ['echo']
}
fn (mut self Lexer) lexer(data string) {
	self.data = data  
}
fn (mut self Lexer) tokenizer() {
	mut i := 0
	for loc in self.data {
		print('$i, $loc.ascii_str()')
		i++
		mut tmp := []string
		mut tid := ` `
		for loc != `\0` {
			i++
			if loc == `"` && tid == ` ` {

			}
		}
	}
}
fn main() {
	info := 'Start: echo "This is a Test"'
	mut lexer := &Lexer{}
	lexer.lexer(info)
	lexer.tokenizer()
	
}