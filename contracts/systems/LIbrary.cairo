%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

namespace RegisterType {
    const Component = 1;
    const System = 2;
}

@storage_var
func setById(register_type: felt, id: felt) -> (address: felt) {
}

@storage_var
func setByAddress(register_type: felt, address: felt) -> (id: felt) {
}

@storage_var
func owner(register_type: felt, id: felt) -> (address: felt) {
}

namespace System {
    func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        register_type: felt, address: felt, id: felt
    ) {
        // set the system id
        setById.write(register_type, id, address);
        // set the system address
        setByAddress.write(register_type, address, id);

        // set Auth to Caller
        let (caller_address) = get_caller_address();
        owner.write(register_type, id, caller_address);
        return ();
    }

    func get_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        register_type: felt, id: felt
    ) {
        return setById.read(register_type, id);
    }

    func get_by_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        register_type: felt, address: felt
    ) {
        return setByAddress.read(register_type, address);
    }
}
