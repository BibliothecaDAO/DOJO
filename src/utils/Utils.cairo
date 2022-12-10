%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

namespace Utils {

    // Since we cannot send arbitrary data to the contract, we need to cast the struct to an array
    @external
    func cast_struct_to_arry{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        entity: felt, value: felt
    ) {
        // TODO: Cast and return
        return ();
    }

}