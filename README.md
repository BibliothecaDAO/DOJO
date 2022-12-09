# Cairo-ecs
(From our Lord and Saviour ChatGPT 🙏)
# What's an Entity-Component-System (ECS)?

An ECS system is a way of organizing and managing the architecture of a game or application. ECS stands for "*Entity-Component-System*", and it is a design pattern that is often used in game development to create reusable and modular code. 

In an ECS system, entities are the objects that exist in the game or application, components are the data that defines their attributes and behavior, and systems are the logic that operates on the entities and components to make the game or application work. 

ECS systems are known for their flexibility and scalability, which makes them well-suited for large, complex projects.


# Why put an ECS on-chain?

The benefits of using an entity component system (ECS) in a blockchain application are mainly related to improved flexibility, scalability and composability.

ECS is a design pattern that is often used in the development of video games, but it can also be applied to other types of software, including blockchain applications. In an ECS, entities (e.g., objects or characters in a game) are represented as collections of components (e.g., data or behavior) that can be added, removed, or modified independently of each other. This allows developers to easily create and manage complex systems by combining simple, modular components in various ways.

In the context of a blockchain application, using ECS can help improve flexibility by allowing developers to easily add, remove, or modify the data and behavior of entities without having to make changes to the underlying blockchain infrastructure. This makes it easier to adapt the application to changing requirements or to integrate new features over time.

Additionally, ECS can help improve scalability by allowing developers to distribute the data and behavior of entities across different nodes in the network. This can help reduce the load on any single node, making the system more resilient to large amounts of data or high levels of concurrent access.

Overall, the use of ECS in a blockchain application can help improve flexibility, scalability, and composability, making it a useful design pattern to consider in the development of such applications.

# Are there any ECS on-chain?

The chads at [Lattice.xyz](https://lattice.xyz/) have built an ECS in Solidity called [MUD](https://mud.dev/).

Videos
* Lattice keynote at DEVCON 2022: https://www.youtube.com/watch?v=P9UTCLCz-iA
* Intro to MUD: https://www.youtube.com/watch?v=j-_Zf8o5Wlo
* minecraft built on Optimism using mud: https://www.youtube.com/watch?v=mv3jA4USZtg

Since Starknet has a lot of gaming projects, let's see if we can build an ECS system in Cairo.

# Overall roadmap
* Wait for cairo 1.0 to be released to actually start coding everything but jam about designs as fast as possible on current Cairo version
* We need an easy way to spin up permissioned devnets to actually test out composability. We build on top of Shard Lab's https://github.com/Shard-Labs/starknet-devnet
* Need an indexing system to stream events, we'll use Ceccon's Apibara https://www.apibara.com/
* See if we can integrate Jun's work on DIP (Full-Rust Web3 application toolkit focus on, ECS based event-driven development): https://github.com/diptools/dip

# Work so far
- [x] loaf's initial thoughts & design
<img width="1864" alt="ECS" src="https://user-images.githubusercontent.com/43751434/206679784-2efcd2f0-2591-4fda-b26b-b78b067dc8e1.png">

# Resources
* [What's an ECS?](https://github.com/SanderMertens/ecs-faq)
* [loaf's figma explanation](https://www.figma.com/file/qAjxTZc6tRonazjfsv9GZa/ECS?node-id=0%3A1&t=frLQWE5fVjIvblII-0)
* [MUD github repo](https://github.com/latticexyz/mudbasics#mudbasics)
* [Autonomous worlds blogpost by Ludens](https://0xparc.org/blog/autonomous-worlds)
* [are.na collection of links on autonomous worlds / on-chain realities](https://www.are.na/sylve-chevet/on-chain-realities-and-autonomous-worlds)

# Wanna contribute?
Reach out to [@lordofafew](https://twitter.com/lordofafew) and [@sylvechv](https://twitter.com/sylvechv) on Twitter
