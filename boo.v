
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
	for loc in self.data {
		mut tmp := []string
		mut tid := ` `
		for l in loc {
			if l == `"` && tid == ` ` {

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