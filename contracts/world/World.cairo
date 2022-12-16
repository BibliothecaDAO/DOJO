%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

from contracts.systems.RegisterSystem import RegisterSystem

from contracts.constants.Constants import RegisterType

// __WORLD__
// This contract is the world. It is the center of the on-chain world.
// It stores all entitiy IDs
// It stores all systems.
// It stores all archetypes.

// It doesn't store any system logic.
// It doesn't store any component state.

// It emits events for the whole world when components are changed.

// TOOD:
// Figure out query system for efficient querying of entities and their components. This is how we tick all systems that are interested in correct entites.

// GLOBAL Questions:
// Should Entities all be NFTs
// How do we destroy enemies from the Mapping without Arrays

// emitted on every value change
@event
func ComponentValueSet(entity: felt, component_id: felt, data_len: felt, data: felt*) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // init

    return ();
}

@external
func register_component{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    componentAddr: felt, id: felt
) {
    // register
    RegisterSystem.register(RegisterType.Component, componentAddr, id);
    return ();
}

@external
func register_system{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    systemAddr: felt, id: felt
) {
    // register
    RegisterSystem.register(RegisterType.System, systemAddr, id);
    return ();
}

@external
func register_component_value_set{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, component: felt, data_len: felt, data: felt*
) {
    // emit event of changed data
    // sets component value

    // get component address
    ComponentValueSet.emit(entity, component, data_len, data);

    // set entity has component in mapping -> this will allow querying all components of an entity

    return ();
}

@view
func get_address_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    id: felt
) -> (address: felt) {
    // register
    return RegisterSystem.get_by_id(RegisterType.Component, id);
}

@view
func components_of_entity{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt
) -> (components_len: felt, components: felt*) {
    // register
    // query ID
    // query components and check entity has value -> we should store entities components in a map in world
    // return all components that the entity has

    // IDEAS:
    // hibitset to store IDs of components associatd with an Entity
    return ();
}

@external
func set_entity_ids{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt
) -> (components_len: felt, components: felt*) {
    // entity ID counter
    // components call this function to check that ID is valid

    return ();
}
