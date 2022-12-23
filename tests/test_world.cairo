%lang starknet

from starkware.cairo.common.uint256 import Uint256, uint256_sub
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

from contracts.constants.Constants import ECS_TYPE
from contracts.components.location.Constants import ID as ExampleLocationId
from contracts.systems.Constants import ID as ExampleMoveId

from contracts.world.IWorld import IWorld

@external
func __setup__() {
    // Deploy contracts
    %{ context.world_address = deploy_contract("./contracts/world/World.cairo", []).contract_address %}

    %{
        context.move_address = deploy_contract("./contracts/systems/Move.cairo",
               [context.world_address]).contract_address
    %}

    %{
        context.location_address = deploy_contract("./contracts/components/location/Location.cairo",
               [context.world_address]).contract_address
    %}
    return ();
}

func register_and_assert_contract{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    world_address: felt, contract_to_register: felt, guid: felt, ecs_type: felt
) {
    IWorld.register(
        contract_address=world_address, address=contract_to_register, guid=guid, ecs_type=ecs_type
    );

    let (registered_address) = IWorld.get_address_by_id(world_address, guid);

    assert contract_to_register = registered_address;

    return ();
}

@external
func test__world_should_register_system{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;

    tempvar world_address;
    tempvar move_address;

    %{ ids.world_address = context.world_address %}
    %{ ids.move_address = context.move_address %}

    register_and_assert_contract(world_address, move_address, ExampleMoveId, ECS_TYPE.SYSTEM);

    return ();
}

@external
func test__world_should_register_component{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;

    tempvar world_address;
    tempvar location_address;

    %{ ids.world_address = context.world_address %}
    %{ ids.location_address = context.location_address %}

    register_and_assert_contract(
        world_address, location_address, ExampleLocationId, ECS_TYPE.COMPONENT
    );

    return ();
}
