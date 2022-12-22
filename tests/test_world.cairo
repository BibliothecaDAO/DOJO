%lang starknet

from starkware.cairo.common.uint256 import Uint256, uint256_sub
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

from contracts.world.IWorld import IWorld

@external
func __setup__() {
    // Deploy contract
    %{
       context.world_address  = deploy_contract("./contracts/world/World.cairo", []).contract_address
    %}
    return ();
}

@external
func test_world{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    alloc_locals;

    tempvar world_address;
    %{ ids.world_address = context.world_address %}
    
    %{
    print(f"{ids.world_address=}")
    %}

    return ();
}
