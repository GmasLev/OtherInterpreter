
struct Lexer {
	mut:
	data		string
	tokens		[]map[string]string
	keywords	[]string = ['echo']
}
fn (mut self Lexer) lexer(data string) {
	self.data = data  
}
fn (mut self Lexer) tokenizer() {
	for loc in self.data {
		println(loc.ascii_str())
		mut tmp := []string
		mut tid := ''
		for loc != `\0` {
			if loc == `"` && tid == ' ' {
				tid = 'char'
				tmp = []
			}else if loc == `"` && tid == 'char' {
				mut c := tmp.join('')
				self.tokens << {'id': tid, 'value': c}
				tid = ''
				tmp = []
			}else if loc == `:` {
				self.tokens << {'id': 'label', 'value': tmp.join('')}
			}else if loc == ` ` && tid != 'char' {
				continue
			}
			else {
				tmp << loc.ascii_str()
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