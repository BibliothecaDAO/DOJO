%lang starknet

// Components, systems and entites are registered in the same index
namespace ECS_ID {
    const ENTITY = 0;
    const COMPONENT = 1;
    const SYSTEM = 2;
}

// TODO: Maybe this is too much?
struct Entity {
    ecs_id: felt,  // can be address or ID
    archetype: felt,  // ECS_ID is the first bit - after first we store a vector of component IDS bitmapped
}
