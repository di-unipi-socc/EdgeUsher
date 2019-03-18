import random as rnd

def createNetwork(N, p, Ops, Things, seed = 0):
    rnd.seed = seed
    nodes = createNodes(N, Ops, Things)
    links = createLinks(N, p, nodes)

    return nodes, links

def createLinks(N,p, nodes):
    links = []
    for i in range(N):
        for j in range(1,N):
            toss = rnd.random()
            if toss > p:
                link = {}
                link['a'] = nodes[i]['name']
                link['b'] = nodes[j]['name']
                link['lat'] = rnd.randint(1,150)
                link['bw'] = rnd.randint(1,50)
                links.append(link)
    return links
    
def createNodes(N, Ops, Things):
    nodes = []
    for i in range(N):
        isCloud = rnd.random()
        if isCloud > 0.9:
            node = {}
            node['name'] = 'cloud' + str(i)
            node['resources'] = 10000
            node['operator'] = rnd.choice(Ops)
            node['things'] = []
        else:
            node = {}
            node['name'] = 'edge' + str(i)
            node['resources'] = rnd.randint(1, 50)
            node['operator'] = rnd.choice(Ops)
            node['things'] = []
            for j in range(rnd.randint(0,2)):
                if Things != []:
                    t = rnd.choice(Things)
                    node['things'].append(t)
                    Things.remove(t)
        nodes.append(node)
    return nodes


def declareNode(node):
    result = 'node({}, {}, {}, {}).'.format(node['name'], node['resources'], node['operator'], node['things'])
    return result.replace("'", "")

def declareLink(link):
    result = 'link({}, {}, {}, {}).'.format(link['a'], link['b'], link['lat'], link['bw'])
    return result.replace("'", "")



nodes, links = createNetwork(10, 0.7, ['OpA', 'OpB'], ['t1', 't2', 't3', 't4', 't5'])

for node in nodes:
    print(declareNode(node))

for link in links:
    print(declareLink(link))



        
    