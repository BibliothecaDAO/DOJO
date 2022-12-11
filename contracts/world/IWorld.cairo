// MIT License

%lang starknet

@contract_interface
namespace IWorld {
    func register_component_value_set(entity: felt, component: felt, data_len: felt, data: felt*) {
    }
    func get_address_by_id(id: felt) -> (address: felt) {
    }
}
