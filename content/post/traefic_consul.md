+++
date = "2017-05-23T17:50:40+02:00"
subtitle = ""
tags = []
title = "Traefik and Consul Bare"
+++

# Traefik and Consul

## Why?

We still use old VM with no / limited orchastration
Historically we used HA Proxy for load balancing. But things as to change. So I look at Traefik.
My needs : 

- simple path base routing to route to my webapps.
- nice ui to follow the load balancer activity
- single file deployement !
- dynamic configuration reload
- ability to use a third party service discovery

The choice was simple: Traefik 
On top of it, it's lead maintainer is French (big up to Emile @emilevauge) and it has cheese name for all it's release :)

Why Consul
another great question, what are the alternatives : etcd, zookeeper, eureka.
zookeeper is java so ease of deployement is down, sorry
etcd will be tested next :)
eureka too close to aws for my own need :)


## What?

2 examples :

- discover traefik, and use a file config to do some path base routing
- use consul for service discovery and health checking

