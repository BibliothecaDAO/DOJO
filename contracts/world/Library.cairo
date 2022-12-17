%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

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

    // @notice: assert caller is world
    func assert_caller_is_world{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
        let caller_address = get_caller_address();
        let world_address = world_address.read();

        assert caller_address = world_address;

        return world_address.read();
    }
}
