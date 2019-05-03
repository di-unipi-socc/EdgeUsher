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

As an example, an instance of the chain below, which insists on a single CCTV system (```video1```) and on a single alarm system (```alarm1```), can be declared as in chain.pl.

<center>
<img src="https://raw.githubusercontent.com/di-unipi-socc/EdgeUsher/master/img/cctv.png?raw=true" alt="Home Screen" width="800" />
</center>


