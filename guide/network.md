# Networking 

Networking is quite important as it is needed to diagnose problems in API calls, cybersecurity, and just any connection in/out of your computer. 

I like to learn about networking as if I am designing it from scratch. Some questions to ask when designing network schemes are: 
1. How do we uniquely identify computers? 
2. How should we establish a connection between them? Through hardware or signals? 
3. What protocols should we use, like a common language, so that all computers understand what each other are saying? 
4. Can we implement security measures to prevent unwanted visitors into our computer? 



## Public and Private IP Addresses



Every computer has an IP address. We can access our public IPv4 address with the following: 
```
curl ifconfig.me
```
Since this is public, any device connected to the same network/router should have the same IP address. However, if we want to find our private IP address, we use the following command. 
```
~ ➤ ip -c a                                                                       
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 64:bc:58:11:c0:24 brd ff:ff:ff:ff:ff:ff
    inet 172.30.1.61/24 brd 172.30.1.255 scope global dynamic noprefixroute wlan0
       valid_lft 3235sec preferred_lft 3235sec
    inet6 fe80::6ab9:70c3:f583:ff3e/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
```
There's a few things to look at: 
1. The type of connection that I am on is important. The `lo` (loopback) connection is default to every computer, representing the local connection. `wlan*` refers to WiFi, `eth*` represents ethernet. 

Every device has a public/private IP if it is connected to the internet. To connect to the computer, you need to know the IP and then find a port to connect to. Computers usually have $2^{16} = 65,536$ ports, and whenever computer A is connecting to computer B, data is both coming in and out through certain ports. A port, combined with an IP address, results in a socket address that is used to establish a connection between a client and a server. 




## Protocols 
We should talk about the different protocols. HTTP/HTTPS, UDP, TCP, IP. 

### OSI Layer 

Before we get into any technicalities, we should get a big-picture conceptual grasp of how computers communicate. In here, the **Open Systems Interconnection (OSI) model** is a conceptual model that provides a common standard of communication. It is split into 7 layers of increasing abstraction: 
1. **Physical Layer**: Transmission and reception of raw bit streams over a physical medium. 
2. **Data Link Layer**: Transmission of data frames between two nodes connected by a physical layer. 
3. **Network Layer**:  Structuring and managing a multi-node network, including addressing, routing, and traffic control. 
4. **Transport Layer**: Reliable transmission of data segments between points on a network, including segmentation, acknowledgement, and multiplexing. 
5. **Session Layer**: Managing communication sessions, i.e. continuous exchange of information in the form of multiple back-and-forth transmissions between two nodes.
6. **Presentation Layer**: Translation of data between a networking service and an application, including character encoding, data compression, and encryption/decryption. 
7. **Application Layer**: High-level protocols for resource sharing or remote file access, e.g. HTTP. 


### HTTP and HTTPS
HTTP stands for hypertext transfer protocol, implemented in Layer 7, which transfers data between your computer and the server over the internet through **clear text**. This may not be the most ideal way since any interceptors can read the transferred data. This isn't a problem for regular internet browsing, but if you are inputting sensitive data, then HTTP should not be used. This is why HTTPS (which stands for secure HTTP) was invented, which  is implemented in Layer 4 and encrypts the data being transferred, and every website where you input sensitive data should be using HTTPS (indicated by the `https://` prefix in the URL and a padlock symbol for modern browsers). Due to the extra security measures, HTTPS is less lightweight than HTTP, and its respective default ports are HTTP (80) and HTTPS (443).  

A natural question to ask would be: which encryption scheme does HTTPS use? Both Secure Sockets Layer (SSL) and Transport Layer Security (TLS) is used in the modern web. 

SSL certificate. 

## Curl and wget

Curl is a utility that can be used to view and download things from the internet. 
1. To simply retrieve a webpage and output it in the terminal `curl mbahng.com` 
2. To save it into a file `curl -o myFile.txt mbahng.com`
3. To save the original name: `curl -O ubuntu_iso.iso` 
4. 



curl, wget
nmap --open (only scan open) -F (fast) -vv (verbose) -A (aggressive w/ OS distro) 0.0.0.0
nslookup google.com 
whois 0.0.0.0 
tcpdump (?)
dig (?) 

