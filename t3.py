

#ast = [{'id':'label','value':'Start'},{'id':'cmd','value':'echo'}, {'id':'string','value':'quehueva'}]
ast = []
parent = 'quehueva'
node = {'value':0}
t = {'Start':0}
print(t)
for a in ast:
    print(a)
    if parent in a:
        print(a)
        a[parent].append(t)
        
