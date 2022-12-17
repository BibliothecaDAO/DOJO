%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.bool import TRUE, FALSE

from contracts.constants.Constants import Entity

// __Concepts__
// ecs_id: The ID of the entity in the ECS - This can be address or an id
// archetype: The archetype of the entity
// archetype_id: The ID of the entity in the archetype

// --------------------------------
// Events
// --------------------------------

// called when a new entity is registered
// different from the ComponentValueSet which is emitted on every statechange
// TOOD: Might not need it? Undecided
@event
func ECSRegistryUpdate(entity: Entity, archetype_id: felt, owner: felt) {
}

// --------------------------------
// Storage
// --------------------------------

// entity index
@storage_var
func Storage_guid(id: felt) -> (entity: Entity) {
}

// archetype index - archetypes are bitmapped and can be used to check if an entity has a component
@storage_var
func Storage_archetype_guid(archetype: felt, id: felt) -> (entity: Entity) {
}

// owner of entity index
@storage_var
func owner(id: felt) -> (address: felt) {
}

// counter for entity IDs
@storage_var
func guid_count() -> (count: felt) {
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

// --------------------------------
// Functions
// --------------------------------

namespace RegisterSystem {
    // @notice: Registers an entity in the ECS and stores it Archetype
    // @param: ecs_id - the ID of the entity in the ECS - This can be address or an id
    // @param: archetype - the archetype of the entity
    func register{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        ecs_id: felt, archetype: felt
    ) {
        alloc_locals;
        // check ID not already registered
        // TODO: Stop overriding unless owner

        // check archetype is registered
        // we can register the archetype of Systems and Components in the World init.
        let registered = is_archetype_registered(archetype);
        assert registered = 1;

        // get the next Archetype ID
        let archetype_id = archetype_counter(archetype);

        // get Archetype - Archetypes are bitmapped values of component IDs and can be used to check if an entity has a component
        // first bit is type - 0 = entity, 1 = component, 2 = system
        Storage_guid.write(ecs_id, Entity(ecs_id, archetype));

        // slightly dirty - as we are doubling up on storage, but once it's in, we save massively on query.
        Storage_archetype_guid.write(archetype, archetype_id, Entity(ecs_id, archetype));

        // set Auth to Caller
        let (caller_address) = get_caller_address();
        owner.write(ecs_id, caller_address);

        // emit register event and ID
        ECSRegistryUpdate.emit(Entity(ecs_id, archetype), archetype_id, caller_address);
        return ();
    }

    // --------------------------------
    // Getters
    // --------------------------------

    // @notice: Gets the Archetype ID of an entity
    // @param: ecs_id - the ID of the entity in the ECS - This can be address or an id
    func get_by_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        ecs_id: felt
    ) -> (entity: Entity) {
        return Storage_guid.read(ecs_id);
    }

    // --------------------------------
    // Entities
    // --------------------------------

    // checks if entity exists
    func is_entity{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        ecs_id: felt
    ) -> felt {
        let (entity) = Storage_guid.read(ecs_id);

        if (entity.ecs_id == 0) {
            return 0;
        }

        return TRUE;
    }

    // checks if entity exists
    //  if not, creates it
    //  if so, returns it
    func set{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(ecs_id: felt) {
        let entity = is_entity(ecs_id);

        // TODO: Come up with way to check Archetypes and pop and or add
        // V1 has none

        if (entity == FALSE) {
            // register
            register(ecs_id, 0);
            return ();
        }

        return ();
    }

    // --------------------------------
    // Archetypes
    // --------------------------------

    // check archetype is registered
    func is_archetype_registered{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        _archetype: felt
    ) -> felt {
        let (registered) = archetype.read(_archetype);

        return registered;
    }

    // register archetype
    func register_archetype{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        _archetype: felt
    ) {
        // check archetype is not already registered
        let registered = is_archetype_registered(_archetype);
        assert registered = 0;

        archetype.write(_archetype, 1);

        return ();
    }

    // --------------------------------
    // Counters
    // --------------------------------

    // guid
    func counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> felt {
        let (count) = guid_count.read();

        guid_count.write(count + 1);

        return count;
    }

    // archetype
    func archetype_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        archetype: felt
    ) -> felt {
        let (count) = archetype_id_count.read(archetype);

        archetype_id_count.write(archetype, count + 1);

        return count;
    }
}
