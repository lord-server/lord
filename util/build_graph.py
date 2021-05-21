import os
import sys
from graphviz import Digraph

def process(dot, root, mods, iterated):
	if root in iterated:
		return iterated
	dot.node(root, root)
	iterated.append(root)
	if root in mods:
		subs = mods[root]
		for item in subs:
			iterated = process(dot, item, mods, iterated)
		for item in subs:
			dot.edge(root, item)
	return iterated

dot = Digraph(comment='LORD modules dependences')

rootdir = sys.argv[1]
graph = sys.argv[2]
mods = {}
for subdir, dirs, files in os.walk(rootdir):
	depends = None
	modname = None
	if 'depends.txt' in files:
		modname = os.path.basename(subdir)
		with open(os.path.join(subdir, 'depends.txt')) as f:
			depends = [item.replace("?","") for item in  f.read().splitlines()]
	elif 'mod.conf' in files:
		with open(os.path.join(subdir, 'mod.conf')) as f:
			for line in f.readlines():
				line = line.strip()
				line = line.replace(" ", "")
				kv = line.split('=')
				if len(kv) < 2:
					continue
				key = kv[0].strip()
				val = kv[1].strip()
				if key == "name":
					modname = val
				elif key == "depends":
					depends = [item.strip() for item in val.replace("?","").split(",")]

	if modname is None:
		continue

	if depends is None or len(depends) == 0:
		continue


	depends = [item for item in depends if item != '']
	mods[modname] = depends


if len(sys.argv) == 3:
	for name in mods:
		dot.node(name, name)

	for name in mods:
		deps = mods[name]
		for dep in deps:
			dot.edge(name, dep)
elif len(sys.argv) >= 4:
	rootname = sys.argv[3]
	process(dot, rootname, mods, [])

dot.render(graph)

