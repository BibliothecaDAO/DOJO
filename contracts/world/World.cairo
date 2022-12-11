%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

from contracts.systems.RegisterSystem import RegisterSystem

from contracts.constants.Constants import RegisterType

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

    return ();
}

@external
func get_address_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    id: felt
) -> (address: felt) {
    // register
    return RegisterSystem.get_by_id(RegisterType.Component, id);
}
