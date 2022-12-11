%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

namespace Utils {
    // Since we cannot send arbitrary data to the contract, we need to cast the struct to an array
    @external
    func struct_to_array{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        entity: felt, value: felt
    ) {
        // TODO: Cast and return
        return ();
    }
    func array_to_struct{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        entity: felt, value: felt
    ) {
        // TODO: Cast and return
        return ();
    }
}
