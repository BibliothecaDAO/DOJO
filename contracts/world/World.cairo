%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.bool import TRUE, FALSE

from contracts.systems.RegisterSystem import RegisterSystem

from contracts.constants.Constants import ECS_ID

from contracts.utils.ISystem import ISystem

// WORLD ------------
// The World is the entry point for all components and systems. You need to register your component or system
// with the world before you can use it. The world is responsible for calling the systems and passing the data
// to them.
// Systems, Components and Etnities all exist in the same table. They are differentiated by their Archetype.
// ------------------

//
// EVENTS ------------
//

// @notice: emitted when a component value is set
// @param: entity: the entity the component value is set on
// @param: component_id: the component id
// @param: data_len: the length of the data
// @param: data: the data
@event
func ComponentValueSet(entity: felt, component_id: felt, data_len: felt, data: felt*) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // we setup initial Archetypes here
    RegisterSystem.register_archetype(ECS_ID.COMPONENT);
    RegisterSystem.register_archetype(ECS_ID.SYSTEM);
    return ();
}

//
// REGISTER ---------------

// @notice: register a component
// @param: address: the address of the component
@external
func register_component{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    address: felt
) {
    RegisterSystem.register(address, ECS_ID.COMPONENT);
    return ();
}

// @notice: register a system
// @param: address: the address of the system
@external
func register_system{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    address: felt
) {
    RegisterSystem.register(address, ECS_ID.SYSTEM);
    return ();
}

// @notice: register a component value set
// @param: entity: the entity to set the value on
// @param: component: the component to set the value on
// @param: data_len: the length of the data
// @param: data: the data to set
@external
func register_component_value_set{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, component: felt, data_len: felt, data: felt*
) {
    alloc_locals;
    // TODO: check Component is registered in world
    // Only can be called by Registered Component

    RegisterSystem.set(entity);
    ComponentValueSet.emit(entity, component, data_len, data);
    return ();
}

//
// EXECUTE ------------------------
// note: No systems are called directly. Everything is called via the World.
// --------------------------------

// @notice: execute a system
// @param: system: the system to execute
// @param: entity: the entity to execute the system on
// @param: data_len: the length of the data
// @param: data: the data to pass to the system
@external
func execute{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    system: felt, entity: felt, data_len: felt, data: felt*
) {
    alloc_locals;

    // Check System is registered in world. Revert if not.
    let is_entity = RegisterSystem.is_entity(system);
    assert is_entity = TRUE;

    // call Systems via the World
    // Auth Check on System
    ISystem.execute(system, entity, data_len, data);
    return ();
}
