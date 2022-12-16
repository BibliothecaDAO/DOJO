%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

// Components, systems and entites are registered in the same index
namespace ECS_ID {
    const ENTITY = 0;
    const COMPONENT = 1;
    const SYSTEM = 2;
}

// TODO: Maybe this is too much?
struct Entity {
    address: felt,
    type: felt,
    id: felt,
}

// entity index
@storage_var
func setById(id: felt) -> (entity: Entity) {
}

// helper to get the entity id - can be used as a check the entity exists
@storage_var
func setByAddress(address: felt) -> (entity: Entity) {
}

// archetype index - archetypes are bitmapped and can be used to check if an entity has a component
@storage_var
func setByArchetype(id: felt) -> (archetype: felt) {
}

// owner of entity index
@storage_var
func owner(id: felt) -> (address: felt) {
}

// counter for entity IDs
@storage_var
func id_count() -> (count: felt) {
}

namespace RegisterSystem {
    func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        address: felt, type_id: felt
    ) {
        // TODO: Check ID is registered
        // AUTH: Stop overriding unless owner

        // get the next ID
        let (id) = counter();

        // set the system id
        setById.write(id, Entity(address, type_id, id));

        // TODO: Maybe... set the system address
        setByAddress.write(address, Entity(address, type_id, id));

        // set Auth to Caller
        let (caller_address) = get_caller_address();
        owner.write(id, caller_address);

        // emit register event and ID
        return ();
    }

    func get_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(id: felt) -> (
        entity: Entity
    ) {
        return setById.read(id);
    }

    func get_by_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        address: felt
    ) -> (entity: Entity) {
        return setByAddress.read(address);
    }

    // register archetype
    // TODO: check if archetype is already registered
    // Archetypes are bitmapped values of component IDs and can be used to check if an entity has a component
    func register_archetype{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        id: felt, archetype: felt
    ) {
        // bitmapped archetype of component IDS
        // this creates a unique ID for each combination of components
        // we can use this to query all entities with a specific set of components
        // then we can tick the game!
        setByArchetype.write(id, archetype);

        // TODO: emit
        return ();
    }

    func counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> felt {
        let (count) = id_count.read();

        id_count.write(count + 1);

        return count;
    }
}
