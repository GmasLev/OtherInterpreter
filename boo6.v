
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
	mut c := ` `
	for loc in self.data {
		c = loc
		mut tmp := 'W'
		mut tid := ''
		if c == `"` && tid == '' {
			tid = 'char'
			tmp = ''
		}else if c == `"` && tid == 'char'{
			tmp += ''
			self.tokens << {'id':tid, 'value': tmp}
			tid = ''
			tmp = ''
		}else if c == `:` {
			tmp += ''
			self.tokens << {'id':'label','value':tmp}
			tmp = ''
		}else if tmp in self.keywords {
			tmp += ''
			self.tokens << {'id':'keywords','value':tmp}
            tmp = ''
		}else if c == ` ` && tid != 'char' {
            continue
		}else {
			tmp = tmp + c.str()
			println(tmp)
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