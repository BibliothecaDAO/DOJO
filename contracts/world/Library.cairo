%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

@storage_var
func world_address() -> (address: felt) {
}

namespace World {
    // set world
    func set_world_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        value: felt
    ) {
        world_address.write(value);
        return ();
    }

    // get world
    func get_world_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
        address: felt
    ) {
        return world_address.read();
    }
}
