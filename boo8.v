
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
	mut i := 0
	lim := self.data.len-1
	for i < lim || self.data[i] != `\0` {
		mut tmp := 'W'
		mut tid := ''
		if self.data[i] == `"` && tid == '' {
			tid = 'char'
			tmp = ''
		}else if self.data[i] == `"` && tid == 'char'{
			tmp += ''
			self.tokens << {'id':tid, 'value': tmp}
			tid = ''
			tmp = ''
		}else if self.data[i] == `:` {
			tmp = tmp + ''
			self.tokens << {'id':'label','value':tmp}
			tmp = ''
		}else if tmp in self.keywords {
			tmp += ''
			self.tokens << {'id':'keywords','value':tmp}
            tmp = ''
		}else if self.data[i] == ` ` && tid != 'char' {
			i++
            continue
		}else {
			tmp = tmp + self.data[i].ascii_str()
			println(tmp)
		}
		i++
	}
}
fn main() {
	info := 'Start: echo "This is a Test"'
	mut lexer := &Lexer{}
	lexer.lexer(info)
	lexer.tokenizer()
	println(lexer.tokens)
}