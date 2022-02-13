class Parser:
    def __init__(self,tokens):
        self.tokens = tokens
        self.AST = []

    def add_node(self,parent,node):
        for a in self.AST:
            print('3')
            print(a)
            if parent in a:
                a[parent].append(node)
                print('4')
                print(a)


    def build_AST(self):
        saved = {}
        parent = ''
        collect = False
        for token in self.tokens:
            print('1')
            print(token)
            if token['id'] == 'label':
                t = {token['value']: []}
                print(t)
                if parent != t:
                    parent = token['value']     # +- .clone() NO sí es string!!!!!
                    print(parent)
                    self.AST.append(t)
            elif token['id'] == 'keywords':
                if token['value'] == 'stop':
                   t = {token['value']: 0}
                   #print(t)
                   self.add_node(parent,t)
                else:
                    if collect == False:
                        saved = token
                        collect = True
                    else:
                        t = {saved['value']: token['value']}
                        self.add_node(parent,t)
                        collect = False
            elif token['id'] == 'char' or token['id'] == 'atom':
                if collect == False:
                    saved = token 
                    collect = True
                else:
                    t = {saved['value']: token['value']}
                    self.add_node(parent,t)
                    collect = False
