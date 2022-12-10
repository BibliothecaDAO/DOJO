%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

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
func registerComponent{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    componentAddr: felt, id: felt
) {
    // register
    return ();
}

@external
func registerSystem{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    systemAddr: felt, id: felt
) {
    // register
    return ();
}

@external
func registerComponentValueSet{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    entity: felt, component: felt, data_len: felt*, data: felt*
) {
    // emit event of changed data
    // sets component value

    // get component address
    ComponentValueSet.emit(entity, component, data_len, data);

    return ();
}
