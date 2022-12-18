%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.constants.Constants import ECS_TYPE

// import component
from contracts.components.IComponent import IComponent as ILocation
from contracts.components.location.Constants import ID as LocationID

from contracts.world.Library import World
from contracts.world.IWorld import IWorld

// System specific imports
from contracts.systems.Constants import ID

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    world_address: felt
) {
    World.set_world_address(world_address);
    return ();
}

// single function that executes the move system
@external
func execute{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, data_len: felt, data: felt*
) {
    alloc_locals;
    // TODO: Assert Caller is World / Admin / Approved System
    // World.assert_caller_is_world();

    // get component address from World registry
    let (world_address) = World.get_world_address();
    let (component_address) = IWorld.get_address_by_id(world_address, LocationID);

    // set data
    ILocation.set(component_address, entity, data_len, data);
    return ();
}

// Set up the system within the World.
// TODO: System cannot be called until this is setup
@external
func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Set Component in World
    World.register(ID, ECS_TYPE.SYSTEM);
    return ();
}
