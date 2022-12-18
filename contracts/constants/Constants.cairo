%lang starknet

// Components, systems and entites are registered in the same index
namespace ECS_TYPE {
    const ENTITY = 0;
    const COMPONENT = 1;
    const SYSTEM = 2;
}

// TODO: Maybe this is too much?
struct Entity {
    guid: felt,  // unique ID - not an address. This ID needs to be a constant in the component contract which allows the entity to be fetched.
    ecs_address: felt,  // can be address or ID
    archetype: felt,  // ECS_TYPE is the first bit - after first we store a vector of component IDS bitmapped
}
