
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
	mut tmp := ''
	mut tid := ''
	for loc in self.data {
		if loc == `"` && tid == '' {
			tid = 'char'
			tmp = ''
		}else if loc == `"` && tid == 'char'{
			tmp += ''
			self.tokens << {'id':tid, 'value': tmp}
			tid = ''
			tmp = ''
		}else if loc == `:` {
			tmp += ''
			self.tokens << {'id':'label','value':tmp}
			tmp = ''
		}else if tmp in self.keywords {
			tmp += ''
			self.tokens << {'id':'keywords','value':tmp}
            tmp = ''
		}else if loc == ` ` && tid != 'char' {
            continue
		}else {
			tmp = tmp + loc.ascii_str()
		}
	}
}
fn main() {
	info := 'Start: echo "This is a Test"'
	mut lexer := &Lexer{}
	lexer.lexer(info)
	lexer.tokenizer()
	println(lexer.tokens)
}