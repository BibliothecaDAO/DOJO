%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address, get_contract_address

from contracts.world.IWorld import IWorld

//
// WORLD LIBRARY------------
//
// Import into Systems and Components to init the World.
// Contains helper Auth functions for the World.

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

    // @notice: register component/system in the world
    func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        guid: felt, ecs_type: felt
    ) {
        let (world_address) = get_world_address();
        let (contract_address) = get_contract_address();
        IWorld.register(world_address, contract_address, guid, ecs_type);
        return ();
    }
}
