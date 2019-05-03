<center>
<img src="https://github.com/di-unipi-socc/EdgeUsher/blob/master/img/edgeusherlogo.png?raw=true" alt="Home Screen" width="250" />
</center>

EdgeUsher is a simple, yet general, probabilistic declarative methodology and a (heuristic) backtracking strategy to model and solve the _VNF placement problem_ in Cloud-Edge computing scenarios. EdgeUsher has been prototyped by means of the probabilistic logic programming language [ProbLog](https://dtai.cs.kuleuven.be/problog/index.html). 

It inputs:

- a description of one (or more) VNF chain(s) along with its (their) hardware, IoT, minimum bandwidth, maximum end-to-end latency and security requirements, and 
- a (probabilistic) description of the corresponding (hardware, IoT, bandwidth, latency and security) capabilities offered by the available Cloud/Edge infrastructure.

Based on those, EdgeUsher outputs a ranking of all eligible placements for the VNF chains and routing paths for the related traffic flows over the available Edge-Cloud infrastructure. The ranking considers how well a certain placement can satisfy the chain requirements as the infrastructure state (probabilistically) varies.

In the following, we briefly present the model used by EdgeUsher and how it is possible to use it.

### Model

#### VNF Chains

EdgeUsher permits to easily specify chains of virtual network service functions and their hardware, IoT, network QoS and security requirements. Indeed, a VNF chain -- identified by a  ```ChainID``` and composed of a list of ```ServiceFunctionIDs``` -- can be declared as

```prolog
chain(ChainID, ServiceFunctionIDs).
```

The requirements of each service function ```F``` composing the chain can be declared as in

```prolog
service(F, TProc, HWReqs, IoTReqs, SecReqs).
```

where ```TProc``` is the average processing time (expressed in ms) of ```F```, ```HWReqs``` is the hardware capacity required to deploy ```F```, ```IoTReqs``` is the list of the IoT devices required by ```F```, and ```SecReqs``` are the security policies for ```F```. 
A security policy is either a list or an AND/OR composition of security properties.

Requirements on network bandwidth can be specified by declaring (directed) flows among pairs of service functions (```F1```, ```F2```) and the ```Bandwidth``` (in Mbps) they need to communicate properly:

```prolog
flow(F1, F2, Bandwidth).
```

Finally, constraints on maximum tolerated latency for (directed) service paths crossing the functions ```F1 ->  F2 -> ... -> FN``` can be specified as

```prolog
maxLatency([F1, F2, ...,FN], MaxLatency).
```

As an example, an instance of the chain below, which insists on a single CCTV system (```video1```) and on a single alarm system (```alarm1```), can be declared as in [chain.pl](https://github.com/di-unipi-socc/EdgeUsher/blob/master/chains/chain.pl).

<center>
<img src="https://raw.githubusercontent.com/di-unipi-socc/EdgeUsher/master/img/cctv.png" alt="Home Screen" width="800" />
</center>

#### Infrastructures

EdgeUsher permits to easily specify an infrastructure and its probabilistic dynamics. An infrastructure is modelled as a graph composed by nodes and links. A (Cloud or Edge) node identified by a certain ```NodeId``` can be declared as

```prolog
node(NodeId, HWCaps, IoTCaps, SecCaps).
```

where ```HWCaps``` is the available hardware capacity of that node, ```IoTCaps``` is the list of  IoT devices that the node reaches out directly, and ```SecProps``` is the list of the security capabilities it features. 

On the other hand, a (point-to-point or end-to-end) link connecting ```NodeA``` to ```NodeB``` which is available in the considered infrastructure can be declared as

```prolog
link(NodeA, NodeB, Latency, Bandwidth).
```

where ```Latency``` is the latency experienced over the link (in ms) and ```Bandwidth``` is the transmission capacity it offers (in Mbps). 

EdgeUsher also permits to naturally specify probabilistic profiles of both nodes and links by exploiting ProbLog _annotated disjunctions_. 

As an example, a portion of the UC Davis edge infrastructure, inspired from [(Ning et al., 2019)](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8594705), can be declared as in [complete.pl](https://github.com/di-unipi-socc/EdgeUsher/blob/master/infra/complete.pl).

<center>
<img src="https://github.com/di-unipi-socc/EdgeUsher/blob/master/img/ucdavis.png?raw=true" alt="Home Screen" width="800" />
</center>


### Usage

There exist two versions of EdgeUsher:

- edgeusher.pl, which performs an exhaustive search for all eligible placemnents of a VNF chain to an Edge/Cloud infrastructure,
- hedgeusher.pl, which prunes the search space through heuristics and only returns a subset of the optimal solutions.

After downloading the repo, one should create the a main.pl file in the root folder and consult the EdgeUsher version of choice as in:

```prolog
:- use_module('edgeusher'). % exhaustive search
:- use_module('hedgeusher'). %heuristic search
```

After specifying an input chain and an Edge infrastructure, EdgeUsher can be used to determine all eligible service function placements and flow routings by simply issuing the query:

```prolog
query(placement(Chain, Placement, Routes)).
```

Output results will be of the form: 

```prolog
placement(chainId,
  [on(f1,n1), on(f2,n2), ..., on(fk,nk)],
  [(n1, n2, usedBw, [(f1, f2), ...]), ...]).
```

where the ```on(.,.)``` constructor associates a service function to its deployment node, whilst each ```(n1, n2, usedBw, [(f1, f2), ...])``` keeps track on the bandwidth consumption and of all the service-to-service flows mapped onto the link between nodes ```n1``` and ```n2```.

It is worth noting that EdgeUsher allows users to easily specify function _affinity_ or _anti-affinity_ requirements among service functions. In the first case, the user can force the mapping of two (or more) functions to the same node, as for instance in the query

```prolog
query(placement(Chain, [on(F1,N1), on(F2,N2), on(F3,N2)], Routes)).
```

stating that ```F2``` and ```F3``` must be mapped on a same node ```N2```.

Analogously, anti-affinity constraints can be specified by queries of the form:

```prolog
query(placement(Chain, 
      [on(F1,N1), on(F2,N2), on(F3,N3)], Routes),
      N2 \== N3).
```
stating that ```F2``` and ```F2``` must be mapped on two different nodes ```N2``` and ```N3```.

Additionally, users can specify partial deployments and/or routes, and use \prototype to complete them. This is useful to quickly determine on-demand re-configurations of a chain in case of infrastructure failures or malfunctioning (e.g., crash of a node currently supporting a function service). Also, users can run EdgeUsher over complete deployments and/or routes -- e.g. among those already enacted or obtained via other tools -- so to instantaneously assess them against varying infrastructure conditions. 

All the described functionalities work also with the heuristic version of the prototype, which can be queried as

```prolog
query(placement(Chain, Placement, Routes, ThrHW, ThrQoS)).
```

by specifying two threshold values, ```ThrHW``` and ```ThrQoS```, that are used to cut the search space whenever the probability of satisfying the chain hardware or QoS requirements, respectively, falls below them.
