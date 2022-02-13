d = {
    'name': 'gus',
    'age': 55,
    'job': 'dev',
    'value': 'stop'
}
c = d
s = {c['name']: d['name']}
t = {d['age']: 0}

for x in d:
    print(d[x])
    print(t)
    print(s)