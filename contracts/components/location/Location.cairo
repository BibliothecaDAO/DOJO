%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.utils.Utils import Utils

from contracts.world.IWorld import IWorld
from contracts.world.Library import World

// import ID
from contracts.components.location.Constants import ID

// we use generic name at the component level, so we can reuse functions at the system level
// Position
struct ComponentStruct {
    x: felt,
    y: felt,
}

@storage_var
func component(entity: felt) -> (data: ComponentStruct) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    world_address: felt
) {
    World.set_world_address(world_address);
    return ();
}

@external
func set{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, data_len: felt, data: felt*
) {
    alloc_locals;
    // authorize

    // cast data to struct so we can store it
    // TODO: CAST FUNCTION HERE - we need to cast the data to the struct
    component.write(entity, ComponentStruct(1, 2));

    // call World with state update to trigger event
    let (world_address) = World.get_world_address();
    IWorld.register_component_value_set(world_address, entity, ID, data_len, data);

    return ();
}

// get Schema for component
@external
func get_schema{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    schema: ComponentStruct
) {
    return (schema=ComponentStruct(1, 2));
}
