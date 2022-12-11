%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.interfaces.IWorld import IWorld
from contracts.utils.Utils import Utils
from contracts.components.library import ComponentLibrary

// Questions:
// Should have have type system at the component level. We can have a view function that fetches the type so clients know what the component accepts.
// How should we pack the values? Do we come up with generic bitmapping system?

const ID = 'example.component.Location';

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
    ComponentLibrary.set_world_address(world_address);
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

    // Get world addr
    let (world_address) = ComponentLibrary.get_world_address();

    // call World with state update to trigger event
    let (world_address) = ComponentLibrary.get_world_address();
    IWorld.registerComponentValueSet(world_address, entity, ID, data_len, data);

    return ();
}
