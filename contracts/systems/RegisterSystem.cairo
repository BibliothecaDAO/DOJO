%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

from contracts.constants.Constants import Entity

// Vectors are bitmaps of component IDs

// __Concepts__
// Archetypes are bitmapped values of component IDs and can be used to check if an entity has a component
// this means we can add entities to entities

// __TODO__
// - check if archetype is already registered
// - check if entity is already registered
// - check if entity is owned by caller

// entity index
@storage_var
func set_by_id(id: felt) -> (entity: Entity) {
}

// helper to get the entity id - can be used as a check the entity exists
@storage_var
func set_by_address(address: felt) -> (entity: Entity) {
}

// archetype index - archetypes are bitmapped and can be used to check if an entity has a component
@storage_var
func set_by_archetype(archetype: felt, id: felt) -> (entity: Entity) {
}

// owner of entity index
@storage_var
func owner(id: felt) -> (address: felt) {
}

// counter for entity IDs
@storage_var
func id_count() -> (count: felt) {
}

// counter for entity IDs
@storage_var
func archetype_id_count(archetype: felt) -> (count: felt) {
}

// mark as true if archetype is registered
// TODO: A way to pluck all archetypes into an Array
@storage_var
func archetype(archetype: felt) -> (registered: felt) {
}

namespace RegisterSystem {
    func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        address: felt, archetype: felt
    ) {
        // TODO: Stop overriding unless owner

        // check archetype is registered
        // we can register the archetype of Systems and Components in the World init.
        let registered = is_archetype_registered(archetype);
        assert registered = 1;

        // get the next Global ID
        let id = counter();

        // get the next Archetype ID
        let archetype_id = archetype_counter(archetype);

        // get Archetype - Archetypes are bitmapped values of component IDs and can be used to check if an entity has a component
        // first bit is ID, second bit is type, third + is any other components that this entity has
        // this gives us cheap way to fetch all entities with a specific set of components
        set_by_id.write(id, Entity(address, archetype));

        // slightly dirty - as we are doubling up on storage, but once it's in, we save massively on query.
        set_by_archetype.write(archetype, archetype_id, Entity(address, archetype));

        // set Auth to Caller
        let (caller_address) = get_caller_address();
        owner.write(id, caller_address);

        // emit register event and ID
        return ();
    }

    func get_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(id: felt) -> (
        entity: Entity
    ) {
        return set_by_id.read(id);
    }

    func get_by_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        address: felt
    ) -> (entity: Entity) {
        return set_by_address.read(address);
    }

    // register archetype
    // TODO: check if archetype is already registered
    // Archetypes are bitmapped values of component IDs and can be used to check if an entity has a component
    // this means we can add entities to entities

    // func register_archetype{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    //     id: felt, archetype: felt
    // ) {
    //     // bitmapped archetype of component IDS
    //     // this creates a unique ID for each combination of components
    //     // we can use this to query all entities with a specific set of components
    //     // then we can tick the game!
    //     set_by_archetype.write(id, archetype);

    // // TODO: emit
    //     return ();
    // }

    func counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> felt {
        let (count) = id_count.read();

        id_count.write(count + 1);

        return count;
    }

    // archetype counter
    func archetype_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        archetype: felt
    ) -> felt {
        let (count) = archetype_id_count.read(archetype);

        archetype_id_count.write(archetype, count + 1);

        return count;
    }

    // check archetype is registered
    func is_archetype_registered{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        archetype: felt
    ) -> felt {
        let (registered) = archetype.read(archetype);

        return registered;
    }

    // resgister archetype
    func register_archetype{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        archetype: felt
    ) {
        // check archetype is not already registered
        // TODO: Auth
        let registered = is_archetype_registered(archetype);
        assert registered = 0;

        archetype.write(archetype, 1);

        return ();
    }
}
