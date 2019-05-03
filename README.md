# EdgeUsher

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


