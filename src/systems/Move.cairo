%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

// import component
from contracts.ecs.IComponent import IComponent as ILocation

// single function that executes the move system
@external
func execute{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, data_len: felt, data: felt*
) { 
    // AUTH
    // get component address from World registry
    
    // set data 
    ILocation.set(entity, data_len, data);
    return ();
}
