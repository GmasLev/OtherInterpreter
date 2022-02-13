
struct Lexer {
	mut:
	data		string
	tokens		[]map[string]string
	keywords	[]string = ['echo','stop']
}
fn (mut self Lexer) lexer(data string) {
	self.data = data  
}
fn (mut self Lexer) tokenizer() {
	mut tmp := ''
	mut tid := ''
	mut tam := self.data.len
	mut i := 0
	for loc in self.data {
		if loc == `"` && tid == '' {
			tid = 'char'
			tmp = ''
		}else if loc == `\n` {
			i++
			if i+'stop'.len == self.data.len {
				tmp += ''
				self.tokens << {'id':'atom','value':'stop'}
				tmp = ''
			}
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
			i++
            continue
		}else {
			tmp = tmp + loc.ascii_str()
		}
		tam--
		i++
	}
}
struct Parser {
	mut:
	tokens		[]map[string]string
	ast			[]map[string]string
	/*
	mm			[]map[map[string]string]string
	error: maps only support string, integer, float, rune, 
			enum or voidptr keys for now (not `map[string]string`)
	*/
}
fn (mut self Parser) parser(tokens []map[string]string) {
	self.tokens = tokens
	self.ast = []
}
fn (mut self Parser) add_node(parent string, node map[string]string) {
	for a in self.ast {
		if parent in a {
			self.ast << node
		}
	}
}
fn (mut self Parser) build_ast() {
	mut saved := map[string]string
	mut parent := ''
	mut collect := false
	for token in self.tokens {
		//println(token)
		if token['id'] == 'label' {
			v := token['value']
			//println(v)
			t := {token['value']:' '}
			//println(t)
			if parent != t[v] {
				parent = token['value']
				//println(parent)
				self.ast << (t)
			}
		}else if token['id'] == 'keywords' {
			if token['value'] == 'stop' {
				t := {token['value']:''}
				//println(t)
				//println(parent)
				self.add_node(parent,t)
			}else {
				if collect == false {
					saved = token.clone()
					collect = true
				}else {
					t := {saved['value']: token['value']}
					self.add_node(parent,t)
					collect = false
				}
			}
		}else if token['id'] == 'char' {
			if collect == false {
				saved = token.clone() 
				collect = true
			}else {
				t := {saved['value']: token['value']}
				//println(t)
				self.add_node(parent,t)
				collect = false
			}
			//println(token)
		}
	}
}
struct Evaluator {
	mut:
	ast			[]map[string]string
}
fn (mut self Evaluator) evaluator(tokens []map[string]string) {
	self.ast = tokens
}
fn (mut self Evaluator) cal() {
	for a in self.ast {
		if a['id'] == 'char' {
			println(a['value'])
		}
		else if a['id'] == 'keywords' && a['value'] == 'stop' {
			exit(0)
		}
	}
}
fn main() {
	info := 
'Start: echo "This is a Test"
echo "[]map[map[string]string]string
 maps only support string, integer, float, rune, 
enum or voidptr keys for now (not `map[string]string`)"
stop'

	mut lexer := &Lexer{}
	lexer.lexer(info)
	lexer.tokenizer()
	//println(lexer.tokens)

	mut parser := &Parser{}
	parser.parser(lexer.tokens)
	parser.build_ast()
    //println('AST:')
    //println(parser.ast)

	mut evalua := &Evaluator{}
	evalua.evaluator(lexer.tokens)
	evalua.cal()

}


/*
https://www.youtube.com/watch?v=cRvmSMWLZlY
Create A Programming Language - Part 1: Lex, Parse, Eval
add_node() no funciona
*/